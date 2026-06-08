# Glossary

Practical definitions of key terms used throughout this handbook. Where a term has a common misuse, it is noted.

---

## A

**Activation** — the point at which a new user first experiences the core value of a product. Usually defined as a specific action (e.g. sending a first message, completing a first purchase). Activation is a lagging proxy for product-market fit in the onboarding funnel.

**A/B test** — a controlled experiment that randomly assigns users to a control group and one or more treatment groups to measure the causal effect of a change. Validity depends on random assignment, not just random-looking results.

**Average revenue per user (ARPU)** — total revenue divided by total users in a period. Sensitive to how "user" is defined; always clarify denominator.

---

## C

**Causal inference** — methods for estimating the causal effect of an intervention when a randomised experiment is not available or not feasible.

**Churn** — the proportion of users who stop using a product within a defined time period. Definition varies: explicit cancellation, non-renewal, or inactivity for N days. Always specify.

**Cohort analysis** — tracking a group of users who share a common characteristic (usually sign-up date) over time to understand retention, revenue or behaviour patterns.

**Confidence interval** — a range of values that, if the experiment were repeated many times, would contain the true parameter with the stated probability (e.g. 95%). Not "the probability the true value is in this range" — that is a common misinterpretation.

**Confounding variable** — a variable that affects both the treatment and the outcome, creating a spurious association between them. The core problem that randomisation solves.

**Conversion rate** — the proportion of users who complete a desired action out of those who had the opportunity to do so. Numerator and denominator must be defined precisely.

---

## D

**DAU/MAU ratio** — daily active users divided by monthly active users. A measure of engagement stickiness. Values above 50% are generally strong.

**Difference-in-differences (DiD)** — a causal inference method comparing the change in outcomes over time between a treatment group and a control group. Requires the parallel trends assumption.

---

## E

**Effect size** — the magnitude of the difference between groups, independent of sample size. Statistical significance does not imply practical significance; always report effect size alongside p-values.

**Engagement** — a broad term for how actively users interact with a product. Always replace with a specific metric in analysis: session depth, actions per session, days active per month.

---

## F

**False positive (Type I error)** — rejecting a true null hypothesis. Controlled by the significance level (alpha). At alpha = 0.05, 1 in 20 null results will appear significant by chance.

**False negative (Type II error)** — failing to reject a false null hypothesis. Related to statistical power. Underpowered tests have high false negative rates.

**Funnel** — a sequence of steps a user goes through to complete a goal. Each step has a conversion rate. Funnels can be strict (must complete in order) or loose (any path to the end state).

---

## G

**Guardrail metric** — a metric that must not degrade during an experiment, even if the primary metric improves. Prevents shipping changes with harmful side effects.

---

## I

**Input metric** — a metric that represents actions or activities that lead to outcomes. More controllable than output metrics and typically more useful for teams to optimise against.

**Intent-to-treat (ITT)** — an analysis approach that includes all randomly assigned participants regardless of whether they actually received the treatment. Preferred in most product experiments.

---

## L

**Lagging indicator** — a metric that measures outcomes after they have occurred. Less actionable but often more meaningful (e.g. revenue, retention).

**Leading indicator** — a metric that predicts future outcomes. More actionable but sometimes a weaker proxy (e.g. email open rate predicting purchase).

---

## M

**MECE** — mutually exclusive and collectively exhaustive. A principle for structuring analysis and communication: categories should not overlap, and together they should cover everything.

**Metric** — a quantitative measure of something that matters. Good metrics are precise, measurable, actionable and aligned with goals. Avoid vanity metrics that look good but do not predict outcomes.

---

## N

**North star metric** — the single metric that best captures the core value a product delivers to its users. Should align the whole team, not just one function.

**Novelty effect** — a short-term increase in engagement caused by the newness of a feature, not its sustained value. A major reason to run experiments for longer than the minimum.

---

## P

**p-value** — the probability of observing a test statistic as extreme as the one observed, assuming the null hypothesis is true. Common misinterpretation: it is not the probability that the null hypothesis is true, nor the probability the result is due to chance.

**Power** — the probability of correctly detecting a true effect when it exists. Conventionally set to 80% (beta = 0.20). Low power means real effects often go undetected.

**Practical significance** — whether an effect size is large enough to matter in practice. A result can be statistically significant (unlikely under the null) but practically negligible.

---

## R

**Regression discontinuity (RDD)** — a causal inference method that exploits a sharp threshold in an assignment variable (e.g. age, score, date) to estimate causal effects near the threshold.

**Retention** — the proportion of users who return to a product after their first visit within a defined time window. Specify the window: day 1, day 7, day 30, month 3.

---

## S

**Sample ratio mismatch (SRM)** — when the actual ratio of users in experiment groups does not match the intended assignment ratio. Always indicates a data quality problem. Invalidates the experiment.

**Significance level (alpha)** — the threshold for rejecting the null hypothesis. Conventionally 0.05. Set before the experiment, not after seeing results.

**Surrogate metric** — a short-term metric used as a proxy for a long-term outcome that is harder to measure directly. Use with caution; surrogates can diverge from the outcome they are meant to predict.

---

## U

**Uplift modelling** — estimating the causal effect of an intervention at the individual level. Identifies "persuadables" — users who respond to a treatment — as distinct from those who would act regardless or not at all.

---

## W

**Window function** — a SQL function that performs a calculation across a set of rows related to the current row without collapsing the result. Essential for running totals, rankings, period-over-period analysis and session logic.
