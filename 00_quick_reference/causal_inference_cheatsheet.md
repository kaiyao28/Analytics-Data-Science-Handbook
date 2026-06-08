# Causal Inference Cheatsheet

Use when a randomised experiment is not possible.

---

## Method selection

| Situation | Method | Key requirement |
|-----------|--------|----------------|
| Treatment applied to some regions/groups at a point in time | Difference-in-differences (DiD) | Parallel pre-trends |
| Assignment based on a threshold (score, date, age) | Regression discontinuity (RDD) | Sharp threshold, units near it are comparable |
| Need to match treated and untreated users | Propensity score matching | Overlap in covariates, no hidden confounders |
| Natural variation in treatment exposure | Instrumental variable (IV) | Valid instrument (affects treatment, not outcome directly) |

---

## Key assumptions by method

**Difference-in-differences:**
- Parallel trends: without treatment, both groups would have trended the same
- No spillover between treated and control units
- Always plot pre-period trends before trusting DiD

**Regression discontinuity:**
- Units just above and just below the threshold are comparable
- No manipulation of the assignment variable around the threshold
- Effect only estimated near the threshold — not for the full population

**Matching:**
- No unmeasured confounders (selection on observables)
- Sufficient overlap between treated and untreated groups
- Always check covariate balance after matching

---

## DiD formula

```
DiD = (Treatment_post − Treatment_pre) − (Control_post − Control_pre)
```

This removes the common time trend, leaving only the treatment effect — *if parallel trends holds*.

---

## Common mistakes

| Mistake | Why it matters |
|---------|---------------|
| Not checking parallel pre-trends | DiD is invalid without them |
| Claiming causality from regression with controls | Controls ≠ causal identification |
| Matching without checking covariate balance | Matched groups may still differ on unmeasured variables |
| Ignoring network spillovers | SUTVA violation — one user's treatment affects others |
| Overstating certainty | Observational estimates rest on unverifiable assumptions |

---

## Opening line for an interview question

> "Since we can't run an experiment here, I would use [method]. The key assumption I would need to validate is [assumption]. If that assumption held, the estimate would be credible. If it didn't, I would [alternative or caveat]."

---

*Full detail: [../04_causal_inference/README.md](../04_causal_inference/README.md)*
