# Common Experiment Mistakes

Experiments fail in predictable ways. This file catalogs the ten most common failures with enough detail to recognise and avoid each one.

---

## Quick reference

| Mistake | Core harm | Red flag |
|---------|-----------|----------|
| Peeking | Inflated false positive rate | Team stops when p < 0.05 |
| SRM | Groups are not comparable | Split deviates from intended |
| Post-hoc metric | Multiple testing via selection | "Let's see what moves" |
| Ignoring guardrails | Missed second-order harm | No guardrails defined pre-launch |
| Underpowered test | Null proves nothing | No sample size calc before launch |
| Multiple testing | False positives across metrics | 10 metrics, winner declared post-hoc |
| Novelty effect | Short-term spike misread as real lift | Only week 1 looks good |
| Wrong unit | Contamination or near-zero power | One user sees both variants |
| Interference | Biased estimate | Marketplace or social experiment |
| Composition shift | Spurious segment results | Segmenting by post-assignment outcomes |

---

## 1. Peeking (early stopping)

**What it is:** Checking results before the pre-specified end date and stopping when p < 0.05.

**Why it's harmful:** At alpha = 0.05, a false positive happens 1 in 20 times under the null. If you check daily and stop whenever p crosses 0.05, you are running many tests on the same accumulating data. The actual false positive rate can exceed 30–40% even though you set alpha = 0.05.

**How to detect it:** Pattern of "experiments that worked" that fail to replicate. Teams that routinely stop tests after 3–4 days.

**What to do instead:** Pre-specify the end date. Analyse once, at the end. If you genuinely need early stopping, use a sequential testing method (group sequential tests or always-valid confidence intervals) — these are mathematically designed for repeated looks.

---

## 2. Sample ratio mismatch (SRM)

**What it is:** The actual proportion of users in each variant does not match the intended assignment ratio. Planned 50/50. Got 47/53.

**Why it's harmful:** SRM means the assignment mechanism is broken. Some filtering process is unevenly removing users after they were assigned. The groups are no longer comparable. Every metric comparison is suspect.

**How to detect it:** Run a chi-squared test on actual vs expected counts on day 1, and again at the end:

```sql
-- From experiment_analysis.sql
SELECT
    variant,
    COUNT(DISTINCT user_id) AS users,
    ROUND(COUNT(DISTINCT user_id) * 100.0 / SUM(COUNT(DISTINCT user_id)) OVER (), 1) AS pct
FROM experiment_assignments
WHERE experiment_id = 'your_experiment'
GROUP BY variant;
```

A significant deviation (chi-squared p < 0.01) is an SRM.

**What to do instead:** Stop. Do not interpret metric results until the SRM is explained and resolved. Common causes: bot filtering applied post-assignment, client-side feature flags that only activate on certain devices, caching that serves the wrong variant, logging bugs. Fix the root cause, then re-run the experiment from scratch.

---

## 3. Not pre-specifying the primary metric

**What it is:** Looking at many metrics after the experiment ends and declaring victory on the ones that happened to be significant.

**Why it's harmful:** At alpha = 0.05 with 20 metrics, you expect 1 false positive just from chance. Choosing the winning metric after the fact is post-hoc cherry-picking — even if it feels like genuine discovery.

**How to detect it:** Was the primary metric documented before launch? Is the result being reported on a metric that was not the original focus of the experiment?

**What to do instead:** Write down one primary metric, one hypothesis and the pre-specified launch criterion before the experiment starts. Store it in a doc, ticket or experiment platform with a timestamp. Treat all other metrics as exploratory — they generate hypotheses for future experiments, not evidence for this one.

---

## 4. Ignoring guardrail metrics

**What it is:** Shipping a feature because the primary metric improved without checking whether downstream health metrics degraded.

**Why it's harmful:** Many changes have genuine trade-offs. Increasing checkout conversion can increase returns. Increasing notification CTR can drive opt-outs and uninstalls. Improving short-term engagement can hurt D30 retention. A feature that "wins" on the primary metric but causes silent downstream harm is a net negative.

**Example:** An email team increases open rate by 8% with more urgent subject lines. They ship. Three months later, the unsubscribe rate has risen by 15%. The experiment looked like a win; it was not.

**What to do instead:** Define at least two guardrail metrics before launch. Include them in every experiment readout. A ship recommendation requires guardrails to be stable or positive.

---

## 5. Underpowered tests

**What it is:** Running an experiment without enough sample to reliably detect the effect size that matters.

**Why it's harmful:** A null result from an underpowered test is not evidence the feature does not work. If power was 30% for a 2pp lift, a null result means there was a 70% chance of missing a real 2pp improvement. "We tried it and it didn't work" is a false conclusion.

**How to detect it:** Was sample size calculated before launch? What was the pre-specified MDE? Given the actual sample and observed effect, what was the post-hoc power?

**What to do instead:** Always calculate the required sample size before launch. The four inputs: baseline rate, MDE, alpha, power. "We'll run it for a week and see what happens" is not an experiment design — it is a decision waiting to be made on insufficient evidence.

---

## 6. Multiple testing without correction

**What it is:** Running many statistical tests — across metrics, segments or variants — and treating each at alpha = 0.05 without adjusting.

**Why it's harmful:** At alpha = 0.05 with 20 independent tests, you expect 1 false positive under the null even if nothing is real. Reporting "3 of 20 metrics showed significant improvement" without correction may reflect random noise.

**Correction approaches:**

| Situation | Correction | When to use |
|-----------|-----------|-------------|
| Small number of pre-specified outcomes | Bonferroni (alpha / n) | Primary + a few secondaries |
| Many exploratory metrics | Benjamini-Hochberg FDR | When you want to control the proportion of false positives among significant results |
| Multiple variants vs one control | Dunnett's test or Bonferroni | Multi-arm experiments |

**What to do instead:** Pre-specify one primary metric. Use corrections for any planned secondary comparisons. Treat unadjusted exploratory findings as hypotheses, not conclusions.

---

## 7. Novelty effect misread as real improvement

**What it is:** The treatment group shows higher engagement early in the experiment because the feature is new, not because it is genuinely better.

**Why it's harmful:** Shipping a feature based on novelty-driven lift produces a product that is no better than what it replaced — the effect decays to zero once the novelty wears off, and sometimes reverses.

**How to detect it:** Compare the treatment effect in week 1 versus weeks 2–3. If the lift decays significantly toward zero, it is a novelty effect.

```
Week 1: treatment +4.2pp (p = 0.02)
Week 2: treatment +1.1pp (p = 0.28)
Week 3: treatment +0.3pp (p = 0.71)
```

This is a novelty effect. Do not ship.

**What to do instead:** Run experiments long enough for novelty to dissipate. For UI changes, aim for 4–6 weeks. For features with inherent novelty (new content format, new social feature), plan to analyse week-by-week and require the effect to be stable over the final 2 weeks.

---

## 8. Wrong randomisation unit

**What it is:** Randomising at a level that is too fine (session or pageview) or too coarse (geography).

**Too fine (session-level):**
A single user sees both control and treatment across sessions. Statistical tests assume independent observations — they are not. This both biases estimates and understates variance (the same user seeing both variants shows up as more "data" than they really are).

**Too coarse (market-level):**
A handful of geographic units means very few independent observations. Power is near zero and estimates are highly variable.

**How to detect it:** Can you find users who appear in both variants? Does the experiment platform assign at the right level? Does each user see only one variant for the entire experiment?

**What to do instead:** Default to user-level randomisation. Use session-level only for anonymous landing page tests where sessions are truly independent. Use geographic or cluster randomisation when there is strong interference — but plan for the dramatic power reduction this implies.

---

## 9. Interference (SUTVA violation)

**What it is:** One user's treatment affects another user's outcome, violating the stable unit treatment value assumption (SUTVA). Control group outcomes are contaminated by the treatment.

**Where it happens most:**
- Marketplaces: a recommendation algorithm affects what sellers list or price, affecting all buyers
- Social networks: treating one user affects what their friends see
- Two-sided platforms: any supply-side change affects demand-side users

**Why it's harmful:** The treatment effect is biased — often understated in supply-constrained settings. A feature appears less effective than it is (or more effective, depending on the direction of spillover).

**What to do instead:** Use cluster randomisation at a level that contains the interference. Randomise geographic markets if markets are fairly independent. Run synthetic control or DiD analyses on market-level holdouts. Always flag SUTVA concerns in the analysis write-up even if they cannot be fully addressed.

---

## 10. Composition shift in segment analysis

**What it is:** Concluding that a segment responded differently to the treatment when the difference is actually driven by a change in who fell into that segment after assignment.

**The canonical example:**
> Treatment shows a large lift for "users who added an item to cart."

But the treatment caused *more* users to add to cart — so the "added to cart" group in treatment is a different, less self-selected population than in control. The comparison is not apples-to-apples.

**Why it's harmful:** Leads to incorrect conclusions about heterogeneous treatment effects and wrong targeting decisions.

**How to detect it:** Are segments defined using pre-experiment characteristics (platform, tenure, geography) or post-experiment outcomes (actions taken during the experiment)? The latter creates this bias.

**What to do instead:** Segment only on pre-experiment attributes. If you want to understand treatment effects for users who took a particular action, use a causal inference method — not a naive comparison.

---

## The meta-mistake: designing the analysis after the fact

The common thread through most of these mistakes is that the decision to analyse in a particular way was made after seeing the data. The solution is the same in every case: **write down what you will measure, how you will measure it, and what constitutes a win before the experiment starts.** Pre-registration is not bureaucracy — it is the only way to ensure the result means what you think it means.

---

*Back to overview: [ab_testing.md](ab_testing.md)*
*Cheatsheet: [../00_quick_reference/ab_testing_cheatsheet.md](../00_quick_reference/ab_testing_cheatsheet.md)*
*Interview questions: [../10_interview_prep/ab_testing_questions.md](../10_interview_prep/ab_testing_questions.md)*
