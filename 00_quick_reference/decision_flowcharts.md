# Decision Flowcharts

Text-based decision trees for common analytics situations.

---

## Can I run an A/B test?

```
Is random assignment possible?
├── Yes → Can I randomly assign at the right unit (user, session)?
│         ├── Yes → Can I get enough sample in a reasonable time?
│         │         ├── Yes → Run an A/B test
│         │         └── No  → Consider a holdout or phased rollout
│         └── No  → Use cluster randomisation or a different unit
└── No  → Why not?
          ├── Already rolled out → Use DiD or synthetic control
          ├── Threshold-based assignment → Use RDD
          ├── Cannot withhold from anyone → Use matching or IV
          └── Too slow to measure → Use a leading-indicator proxy metric
```

---

## Which statistical test?

```
What are you comparing?

Two proportions (e.g. conversion rates)
→ Two-proportion z-test or chi-square test

Two means (e.g. revenue per user)
→ Two-sample t-test (check for outliers first)

Multiple groups (e.g. A/B/C test)
→ ANOVA + post-hoc correction (Bonferroni or Tukey)

Time-series before/after with control group
→ Difference-in-differences

Count of events per user (e.g. purchases)
→ Negative binomial or Poisson regression

Ranked outcomes (e.g. star ratings)
→ Mann-Whitney U test
```

---

## Should we ship?

```
Is there a sample ratio mismatch?
└── Yes → Stop. Fix the SRM. Do not interpret results yet.

Is the primary metric statistically significant?
├── No → Is the test adequately powered?
│         ├── No  → Run longer or accept inconclusive
│         └── Yes → Treat as null. Do not ship based on this.
└── Yes → Is the effect practically significant?
          ├── No  → Statistical significance alone is not enough to ship
          └── Yes → Are guardrail metrics stable?
                    ├── No  → Do not ship. Investigate guardrail harm.
                    └── Yes → Is the effect consistent across segments?
                              ├── No  → Consider partial rollout to segments where it works
                              └── Yes → Recommendation: ship
```

---

## What caused the metric change?

```
Did any data pipeline or logging change at the same time?
└── Yes → Investigate data quality first. Do not proceed to product hypotheses.

Did the metric change uniformly across all segments?
├── No  → The cause is segment-specific.
│         Which segment drives it? (platform, country, user type, channel)
└── Yes → The cause is product-wide.
          Did anything deploy around that time?
          ├── Yes → Test the release as primary hypothesis
          └── No  → Check: external events, seasonality, acquisition mix shift

Is it the rate that changed, or absolute numbers, or both?
├── Rate only, counts flat → Composition shift or denominator growth
├── Counts only, rate flat → Volume change (marketing, seasonality)
└── Both → True behavioural change — investigate product or external cause
```

---

## Choosing a metric

```
What decision does this metric need to support?

Experiment launch decision
→ Need a metric sensitive enough to move in the experiment window
→ Need a metric that reflects the hypothesis being tested

Long-term product health monitoring
→ Need a metric that predicts retention or revenue
→ Slow-moving metrics are acceptable here

Stakeholder alignment
→ Need a metric the whole team understands
→ Avoid derived ratios that require calculation to interpret
```

---

*See also: [CHECKLISTS.md](../CHECKLISTS.md) · [PROBLEM_INDEX.md](../PROBLEM_INDEX.md)*
