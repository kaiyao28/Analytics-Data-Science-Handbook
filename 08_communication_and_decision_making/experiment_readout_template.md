# Experiment Readout Template

Use this template for any A/B test result communication. Fill in each section in order. Do not bury the recommendation.

---

## [Template]

```
## [Experiment name] — Readout

**Recommendation:** [Ship / Do not ship / Needs more investigation]

---

### Setup

| Field | Value |
|-------|-------|
| Hypothesis | If we [change], then [metric] will [direction] because [mechanism] |
| Randomisation unit | [user / session / device] |
| Primary metric | [metric name + precise definition] |
| Guardrail metrics | [list] |
| Run dates | [start] – [end] |
| Sample size | [n per group] |

---

### Primary metric

| Group | Rate | n |
|-------|------|---|
| Control | X% | n |
| Treatment | X% | n |
| Delta | +/− Xpp | — |
| 95% CI | [lower, upper] | — |
| p-value | X.XXX | — |

**MDE met?** [Yes / No — MDE was Xpp, observed delta was Xpp]

---

### Guardrail metrics

| Metric | Control | Treatment | Delta | p-value | Status |
|--------|---------|-----------|-------|---------|--------|
| [metric 1] | X% | X% | +/−X | X.XX | [Stable / ⚠ Degraded] |
| [metric 2] | X% | X% | +/−X | X.XX | [Stable / ⚠ Degraded] |

---

### SRM check

| Group | Expected | Actual | % |
|-------|----------|--------|---|
| Control | X | X | X% |
| Treatment | X | X | X% |

**SRM present?** [No — chi-squared p = X.XX / Yes — investigation needed]

---

### Segment breakdown

| Segment | Delta | p-value | Note |
|---------|-------|---------|------|
| Mobile | +Xpp | X.XX | [consistent / heterogeneous] |
| Desktop | +Xpp | X.XX | |
| New users | +Xpp | X.XX | |
| Returning users | +Xpp | X.XX | |

---

### Novelty check

| Period | Delta |
|--------|-------|
| Week 1 | +Xpp |
| Week 2 | +Xpp |
| Week 3 | +Xpp |

**Novelty effect present?** [No — effect stable / Yes — effect decayed]

---

### Key risks and caveats

1. [Any limitation of the analysis]
2. [Any interpretation caveat]

---

### Next steps

- [Ship / Monitor X metric for Y weeks]
- [Follow-up test idea, if applicable]
```

---

## Worked example: checkout button redesign

```
## Checkout Button Redesign — Readout

**Recommendation: Ship**

---

### Setup

| Field | Value |
|-------|-------|
| Hypothesis | If we increase button contrast, checkout completion will rise because low contrast reduces visibility on mobile |
| Randomisation unit | User |
| Primary metric | Checkout completion rate (purchases / checkout sessions started) |
| Guardrails | Refund rate, support contact rate |
| Run dates | 2025-03-01 – 2025-03-21 |
| Sample size | 8,400 per group |

---

### Primary metric

| Group | Rate | n |
|-------|------|---|
| Control | 32.1% | 8,420 |
| Treatment | 35.2% | 8,389 |
| Delta | +3.1pp | — |
| 95% CI | [+1.8pp, +4.4pp] | — |
| p-value | 0.003 | — |

**MDE met?** Yes — MDE was 2.5pp, observed delta 3.1pp.

---

### Guardrail metrics

| Metric | Control | Treatment | Delta | p-value | Status |
|--------|---------|-----------|-------|---------|--------|
| Refund rate | 4.8% | 5.1% | +0.3pp | 0.28 | Stable |
| Support contacts / order | 0.12 | 0.13 | +0.01 | 0.41 | Stable |

---

### SRM check

| Group | Expected | Actual | % |
|-------|----------|--------|---|
| Control | 8,405 | 8,420 | 50.1% |
| Treatment | 8,405 | 8,389 | 49.9% |

**SRM present?** No — chi-squared p = 0.84

---

### Novelty check

| Period | Delta |
|--------|-------|
| Week 1 | +3.4pp |
| Week 2 | +2.9pp |
| Week 3 | +3.1pp |

**Novelty effect present?** No — effect stable across weeks.

---

### Key risks and caveats

1. Analysis covers desktop + mobile combined. Mobile effect is slightly larger (+3.8pp) but consistent direction.
2. Revenue impact estimated at ~£1.1M annually at current traffic. Actual impact subject to traffic mix.

---

### Next steps

- Ship to 100% of users.
- Monitor refund rate for 4 weeks post-launch as standard guardrail.
```

---

*Quick-reference templates: [../00_quick_reference/communication_templates.md](../00_quick_reference/communication_templates.md)*
*Experiment analysis SQL: [../02_sql_for_analytics/experiment_analysis.sql](../02_sql_for_analytics/experiment_analysis.sql)*
*Full case study: [../09_case_studies/onboarding_activation_ab_test.md](../09_case_studies/onboarding_activation_ab_test.md)*
