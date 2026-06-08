# Case Study: Onboarding Redesign — Did We Improve Activation Without Harming Retention?

**Product context:** A subscription learning app (users complete lessons, build streaks, earn certificates)
**Team role:** Analytics data scientist embedded with the Growth team

---

## 1. Business context

The product team redesigned the new-user onboarding flow. The old flow was a 6-step setup wizard collecting preferences. The new flow skips most setup and takes users directly to a recommended first lesson within 90 seconds.

The hypothesis: reducing friction in the first session will increase the proportion of new users who complete their first lesson (activation), which is the strongest predictor of 30-day retention.

---

## 2. Business question

> Did the new onboarding flow improve activation without harming retention or paid conversion?

---

## 3. Metric definitions

Before any analysis is run, the team documents:

| Metric | Definition | Type |
|--------|-----------|------|
| Activation rate | % of new users who complete ≥1 lesson within 7 days of signup | Primary |
| Day-30 retention | % of activated users still active 30 days after signup | Secondary |
| 7-day paid conversion | % of new users who start a paid subscription within 7 days | Secondary |
| App uninstall rate | % of assigned users who uninstall within 14 days | Guardrail |

**Why this primary metric:** Lesson completion in week 1 is the most reliable predictor of whether a user builds a habit. A user who opens the app but never completes a lesson almost never converts or retains.

**Why this guardrail:** A shorter onboarding might feel abrupt to some users. If the uninstall rate rises, the flow is hurting the product experience for a meaningful segment even if activation improves overall.

---

## 4. Experiment design

**Randomisation unit:** Individual user (not session — a user should always see the same experience)

**Assignment:** 50/50 split, new users only, assigned at first app open

**Minimum detectable effect:** 3 percentage point lift in activation rate (baseline: 32%)

**Sample size calculation:**
```
Baseline activation rate: 32%
MDE: 3pp (9.4% relative lift)
Alpha: 0.05
Power: 0.80
→ Required: ~2,800 users per group
→ At ~400 new users/day: 7 days minimum
→ Actual run: 21 days (3 full weeks, accounting for weekly seasonality)
```

**Pre-specified ship criterion:** Ship if (a) activation rate improves ≥ 2pp AND (b) uninstall rate does not increase significantly.

---

## 5. Data needed

From the data warehouse:

```sql
-- experiment_assignments: who was assigned and when
-- events: onboarding_completed, lesson_completed, purchase_started,
--         purchase_completed, app_uninstalled
-- users: signup timestamp, country, acquisition_channel, plan_type
-- purchases: revenue for conversion metrics
```

See [../02_sql_for_analytics/experiment_analysis.sql](../02_sql_for_analytics/experiment_analysis.sql) for the template query structure.

---

## 6. Step 1 before interpretation: SRM check

Before reading any metric results, check whether the actual split matches the intended 50/50.

```sql
SELECT variant, COUNT(*) AS users,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct
FROM experiment_assignments
WHERE experiment_id = 'onboarding_v2'
GROUP BY 1;
```

Expected output:

| variant | users | pct |
|---------|-------|-----|
| control | 4,312 | 49.9% |
| treatment | 4,331 | 50.1% |

This passes. If the split were 45/55 or worse, the team would stop and investigate the assignment mechanism before reading any metrics.

---

## 7. Primary metric result

| Variant | Users | Activated | Activation rate |
|---------|-------|-----------|----------------|
| Control | 4,312 | 1,380 | 32.0% |
| Treatment | 4,331 | 1,646 | 38.0% |

**Lift:** +6.0 percentage points (+18.8% relative)
**p-value:** 0.001
**95% CI for lift:** [+4.1pp, +7.9pp]

The treatment improved activation rate by 6pp. This is statistically significant and practically meaningful — it exceeds the pre-specified MDE of 3pp.

---

## 8. Secondary and guardrail metrics

| Metric | Control | Treatment | Change | Concern? |
|--------|---------|-----------|--------|---------|
| Day-30 retention | 19.1% | 21.4% | +2.3pp | No — improved |
| 7-day paid conversion | 4.2% | 4.8% | +0.6pp (p=0.08) | No — directional positive, not significant |
| Uninstall rate (14d) | 8.3% | 8.9% | +0.6pp (p=0.21) | Borderline — not significant, worth monitoring |

The uninstall rate increase is not statistically significant, but it is directionally unfavourable. Worth flagging and monitoring post-launch.

---

## 9. Segment check

Always verify that the treatment effect is consistent across major segments.

| Segment | Control activation | Treatment activation | Lift |
|---------|--------------------|---------------------|------|
| iOS | 33.1% | 39.4% | +6.3pp |
| Android | 30.8% | 36.5% | +5.7pp |
| US | 35.2% | 41.0% | +5.8pp |
| Non-US | 29.3% | 35.4% | +6.1pp |
| Organic | 36.1% | 43.0% | +6.9pp |
| Paid | 27.9% | 32.8% | +4.9pp |

The effect is consistent across platforms, markets and acquisition channels. No meaningful heterogeneity — the lift is broad-based.

---

## 10. Novelty effect check

Check whether the effect was concentrated in the first few days (novelty) or stable throughout.

| Week | Control activation | Treatment activation | Lift |
|------|--------------------|---------------------|------|
| Week 1 | 31.8% | 37.9% | +6.1pp |
| Week 2 | 32.4% | 38.2% | +5.8pp |
| Week 3 | 31.8% | 37.9% | +6.1pp |

The effect is stable across all three weeks. This is not a novelty effect.

---

## 11. Common traps in this analysis

**Trap 1: Interpreting the paid conversion result as a win.**
The 7-day paid conversion increase (4.2% → 4.8%) has p = 0.08. This does not cross the pre-specified significance threshold and is a secondary metric. Do not lead with it in the readout.

**Trap 2: Dismissing the uninstall rate increase.**
p = 0.21 is not significant, but it deserves a monitoring note. "Not significant" is not the same as "no effect." The confidence interval includes a meaningful increase.

**Trap 3: Comparing activated users to non-activated users across variants.**
If you compare "users who activated in treatment" to "users who activated in control," you are comparing self-selected groups — this is not a causal comparison. Always compare at the level of the randomised unit (all assigned users).

**Trap 4: Running the analysis at day 5 of a 21-day test.**
Even if the effect looks large at day 5, peeking inflates your false positive rate. The analysis above was run at the end of the full 21-day window, as pre-specified.

---

## 12. Recommendation

**Recommendation: ship the new onboarding flow.**

Evidence:
- Activation rate improved by +6pp (+18.8% relative), significantly exceeding the pre-specified MDE
- Effect is consistent across platforms, markets and acquisition channels
- Day-30 retention improved directionally (+2.3pp)
- No significant harm to the guardrail metric

**One monitoring note:** the uninstall rate showed a small, non-significant increase. Recommend tracking this metric for the first 30 days post-launch on the full user base to confirm it remains within acceptable bounds.

**Estimated impact:** At current volume of ~400 new users/day, a 6pp activation lift represents ~24 additional activated users per day. Based on the observed relationship between activation and paid conversion, the expected incremental paid conversion uplift is ~$X per month (to be calculated with updated LTV figures).

---

## 13. Reader exercise

Before reading section 11, work through this yourself:

1. The team asks: "Should we also check whether users who saw the new onboarding completed *more* lessons, not just more activations?" How would you answer — and what is the analytical risk in that question?
2. A stakeholder says: "The uninstall rate went up 0.6pp. I'm worried." How do you respond?
3. The PM wants to ship only on iOS first. From the data above, is there analytical support for a phased launch? What would you check before agreeing?

---

*See also: [../03_statistics_and_experimentation/README.md](../03_statistics_and_experimentation/README.md) · [../02_sql_for_analytics/experiment_analysis.sql](../02_sql_for_analytics/experiment_analysis.sql) · [../08_communication_and_decision_making/experiment_readout_template.md](../08_communication_and_decision_making/experiment_readout_template.md)*
