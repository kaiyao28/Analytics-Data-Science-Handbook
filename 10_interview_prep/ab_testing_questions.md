# A/B Testing Interview Questions

---

## What interviewers are testing

- Can you design a rigorous experiment from first principles?
- Do you understand statistical power, sample size, and what makes a test valid?
- Do you know the common failure modes (peeking, SRM, novelty, multiple testing)?
- Can you interpret results correctly and communicate them clearly?
- Can you handle ambiguous or inconclusive results without pretending certainty?

## Answer framework

For any A/B testing question, hit these points in order:
1. Hypothesis → 2. Randomisation unit → 3. Primary metric → 4. Guardrails → 5. Sample size → 6. Duration → 7. Risks

---

## Questions

### Q1 — Design an A/B test from scratch

**Question:** The team wants to test a new checkout button. Design the experiment.

**Strong answer:**

> "Hypothesis: if we replace the blue checkout button with a green one, checkout completion rate will improve because it has higher contrast and is easier to find.
>
> Randomisation unit: user — we want consistency within a session and across devices.
>
> Primary metric: checkout completion rate (completed purchases / checkout sessions started).
>
> Guardrails: refund rate and customer support contacts — we don't want to accidentally create confusion that leads to abandoned orders.
>
> Sample size: I need the baseline rate (say 4.0%), the MDE (smallest lift worth acting on — say 0.5pp), alpha = 0.05, power = 0.80. With those inputs I would calculate roughly 15,000 per group.
>
> Duration: at 1,000 checkout sessions per day per group, that's 15 days minimum. I'd run 21 days to cover 3 full weekly cycles.
>
> Pre-specified criterion: ship if conversion improves by ≥ 0.3pp AND guardrails are stable.
>
> Key risks: novelty effect (a new button may attract clicks initially), SRM (I'd check the split on day 1)."

---

### Q2 — What is a p-value?

**Question:** Explain what a p-value is to a product manager who has a statistics background but is not a data scientist.

**Strong answer:**

> "The p-value is the probability of seeing a result at least as extreme as ours if the change we made actually had no effect.
>
> A p-value of 0.03 means: if the new checkout button were truly identical to the old one, there's only a 3% chance we'd see a difference this large just by random variation.
>
> It does not mean: there is a 97% chance the result is real. It doesn't tell us the probability that our hypothesis is true.
>
> The most common misinterpretation is treating p < 0.05 as proof that the result is real. It's really just evidence against the null — and at alpha = 0.05, we'll get a false positive 1 in 20 times even when nothing changed."

---

### Q3 — Why is peeking a problem?

**Question:** An analyst checks the experiment results every morning and stops the test when p < 0.05. What is wrong with this?

**Strong answer:**

> "This inflates the false positive rate far beyond the stated alpha.
>
> When alpha = 0.05, we expect 1 in 20 tests to appear significant by chance. But if we check every day and stop whenever we cross 0.05, we are effectively running many tests on the same data. The probability of at least one false positive over 20 checks can exceed 30–40%.
>
> The fix: pre-specify the test duration before launch and only analyse at the end. If you need early stopping for operational reasons, use a sequential testing method (like a group sequential test or always-valid p-values) that is designed to handle repeated looks."

---

### Q4 — What is a sample ratio mismatch?

**Question:** After launching an experiment, you notice the split is 48% / 52% instead of 50% / 50%. What do you do?

**Strong answer:**

> "This is a sample ratio mismatch — the actual assignment split doesn't match the intended one. This almost always indicates an assignment integrity problem: a bot filter removing users unevenly, a bug in the assignment logic, or a logging issue.
>
> The critical point: a SRM means the groups are not comparable. Even if the primary metric looks promising, I would not interpret the results until the SRM is resolved.
>
> Steps: check the assignment mechanism, look for any filtering that happens after assignment, check whether both variants have the same exclusion criteria. Only after the SRM is explained and resolved is it safe to interpret the experiment."

---

### Q5 — Handling an inconclusive result

**Question:** Your experiment ran for 4 weeks and shows p = 0.14. The PM wants to run it "a bit longer to see if it becomes significant." How do you respond?

**Strong answer:**

> "I'd explain why this doesn't work the way the PM hopes.
>
> Running longer after seeing p = 0.14 is a form of peeking — we're now making the stopping decision based on what we've seen. If we keep extending until p < 0.05, we will eventually get there by chance even if the feature has no real effect.
>
> The right framing: was the test adequately powered? If we pre-specified a 5% relative lift as the MDE, and our power was 80%, then p = 0.14 tells us the true effect is likely smaller than our MDE or does not exist.
>
> Two honest options:
> 1. Accept the null — the feature did not demonstrate the improvement we needed, and we move on.
> 2. Run a new test with a lower MDE and larger sample size — but this is a new pre-registered test, not extending this one."

---

### Q6 — Multiple metrics

**Question:** Your experiment has 10 different metrics. Three of them show p < 0.05. Is this a win?

**Strong answer:**

> "No — not without correction for multiple testing.
>
> At alpha = 0.05 with 10 independent metrics, we'd expect 0.5 false positives on average just by chance. Three significant results out of 10 is above that, but the excess is small.
>
> The right approach: pre-specify one primary metric before launch. The primary metric determines whether we ship. Secondary metrics provide context. If only secondary metrics are significant, that's interesting but not a ship decision.
>
> If we genuinely care about multiple outcomes equally, we should either reduce alpha (Bonferroni: use 0.05/10 = 0.005 per metric) or use a false discovery rate approach."

---

### Q7 — Novelty effect

**Question:** An experiment shows a significant lift in week 1 that disappears in weeks 2 and 3. How do you interpret this?

**Strong answer:**

> "This is a novelty effect — users interacted with the new feature more because it was new and unfamiliar, not because it was genuinely better.
>
> For this reason, I never make a ship recommendation based only on week 1 data, even if it's significant. I always look at the effect size over time to see whether it stabilises or decays.
>
> In this case: the effect decayed to zero by week 2–3. I would not ship based on this. The feature improved novelty-driven engagement, not genuine user value.
>
> The decision: do not ship. If the team believes the feature has long-term value that isn't captured in the short-term metric, that requires either a different metric or a longer test."

---

### Q8 — Interference in experiments

**Question:** You are testing a new recommendation algorithm on a marketplace. Users are randomly assigned to control or treatment. Is this experiment valid?

**Strong answer:**

> "It depends. The key risk in a marketplace is interference — also called spillover or SUTVA violation.
>
> If the recommendation algorithm affects what sellers list or how they price, then treating one buyer affects what untreated buyers see. The control group is contaminated. This can make a harmful change look beneficial (or vice versa).
>
> To test this properly: use cluster randomisation at a level where clusters don't interact. For example, randomise by geographic market if markets are fairly independent. Or randomise by supply-side cohort rather than demand-side.
>
> If cluster randomisation is not possible, run a holdout at the market level (one market sees treatment, one sees control) and use DiD to estimate the effect."

---

## Common mistakes

| Mistake | Better approach |
|---------|----------------|
| Choosing the metric after seeing results | Pre-specify before launch |
| Stopping when significant | Pre-specify duration |
| Ignoring SRM | Check day 1; do not interpret until resolved |
| Calling secondary metric wins | Primary metric determines ship decision |
| Extending the test ad hoc | Accept null or run a new pre-registered test |

---

---

## Self-score rubric

After answering each question, score yourself 1–5 on these dimensions:

| Dimension | 1 — Missing | 3 — Partial | 5 — Strong |
|-----------|------------|------------|-----------|
| Hypothesis has mechanism | No mechanism | Direction only | Mechanism stated clearly |
| Sample size reasoning | Skipped | Inputs named | Inputs + duration calculated |
| Guardrails addressed | Not mentioned | Named without mechanism | Named with mechanism |
| Null result handled correctly | "It doesn't work" | "Inconclusive" | "Inconclusive — check power, then accept null or re-design" |
| Pre-specification | Not mentioned | Mentioned in passing | Clearly explains why post-hoc metric choice is invalid |
| SRM handling | Ignored | Flagged | Flagged + steps to investigate + hold analysis |

**Target:** average ≥ 4 before interview day. For any dimension where you scored 1–2, re-read the corresponding section in [../03_statistics_and_experimentation/common_experiment_mistakes.md](../03_statistics_and_experimentation/common_experiment_mistakes.md).

---

*Cheatsheet: [../00_quick_reference/ab_testing_cheatsheet.md](../00_quick_reference/ab_testing_cheatsheet.md)*
*Statistics foundation: [../03_statistics_and_experimentation/README.md](../03_statistics_and_experimentation/README.md)*
