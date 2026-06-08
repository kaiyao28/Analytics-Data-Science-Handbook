# 09 · Case Studies

## Why this matters

Reading about analysis is different from doing it. These case studies are end-to-end walkthroughs of realistic product problems, showing how the concepts from earlier sections combine in practice.

Each case study includes the business context, the data available, the analytical approach, the finding and the recommendation. Some include deliberate mistakes to identify.

---

## What you need to know

Before working through these, you should have read:

- [01 · Product and business thinking](../01_product_and_business_thinking/README.md)
- [02 · SQL for analytics](../02_sql_for_analytics/README.md)
- [03 · Statistics and experimentation](../03_statistics_and_experimentation/README.md)

The later case studies also draw on causal inference and communication.

---

## Cases in this folder

| Case | Product context | Key skills |
|------|-----------------|-----------|
| [activation_drop.md](activation_drop.md) | Sudden drop in activation rate | Metric diagnosis, data quality, SQL |
| [checkout_ab_test.md](checkout_ab_test.md) | A/B test with SRM and guardrail failure | SRM, guardrails, result communication |
| [onboarding_activation_ab_test.md](onboarding_activation_ab_test.md) | Full onboarding A/B test | End-to-end experiment, novelty check |

### Planned additions

| Case | Product context | Key skills |
|------|-----------------|-----------|
| `retention_decline.md` | Gradual decline in day-30 retention | Cohort analysis, root cause investigation |
| `marketplace_liquidity.md` | Falling supply-side liquidity | Marketplace metrics, funnel analysis, causal framing |
| `subscription_churn.md` | Rising churn in a subscription product | Churn diagnosis, ML framing, DiD setup |

---

## How to use these case studies

**As a learner:** Read the problem statement. Stop before the analysis section. Write your own approach: what metric, what SQL or Python, what method, what recommendation. Then compare with the walkthrough. The gap between your answer and the walkthrough is your learning opportunity.

**For interview preparation:** Each case maps to a common interview question format. Practise talking through your answer out loud before reading the solution.

**As a template:** The structure of each case — business problem → data available → analytical approach → finding → recommendation — is a reusable template for communicating your own analyses.

---

## Common mistakes in case study answers

**Jumping to the analysis without defining the question.** Always start by stating the metric, scope and time period before running anything.

**Only looking in one dimension.** Good diagnosis explores multiple breakdowns: platform, country, user type, acquisition cohort, feature version.

**Stating findings without a recommendation.** Every case study ends with a decision the team needs to make. Your job is to recommend one.

**Claiming causality from observational data.** "Users who completed onboarding retained better" is an observation. It does not prove onboarding caused retention. Be precise about what you can and cannot conclude.

**Ignoring data quality.** Before interpreting a metric change, always check whether the change could be a data or logging issue.

---

## Interview relevance

These cases mirror real analytics DS interview formats:

- "A metric dropped 20%. How do you diagnose it?" → [activation_drop.md](activation_drop.md)
- "Walk me through an A/B test analysis" → [checkout_ab_test.md](checkout_ab_test.md)
- "Design and analyse an onboarding experiment" → [onboarding_activation_ab_test.md](onboarding_activation_ab_test.md)

Practise answering without reading the solution first. The goal is not to memorise the walkthrough — it is to develop the habit of structured thinking on unfamiliar problems.

---

## Exercises

Before reading any case study solution:

1. Read the problem statement
2. Write down: (a) the metric you would analyse, (b) the segments you would break down by, (c) the SQL or Python approach you would use, (d) what a good outcome looks like
3. Then read the walkthrough and note where your thinking diverged

---

## Next

[10_interview_prep](../10_interview_prep/README.md) — practise with structured interview questions and frameworks.
