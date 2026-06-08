# Statistics Interview Questions

---

## What interviewers are testing

- Do you understand core concepts precisely, not just approximately?
- Can you explain statistical concepts to a non-technical audience without distorting them?
- Do you know when and why to use which test?
- Can you identify the most common misconceptions (especially around p-values)?
- Do you understand the practical trade-offs in experiment design?

## Answer framework

For any statistics question: define the concept precisely → give a concrete example → note the most common misinterpretation → state the practical implication.

---

## Questions

### Q1 — p-value

**Question:** Explain what a p-value is. What is the most common mistake people make when interpreting it?

**Definition:**
The p-value is the probability of observing a test statistic as extreme as the one we observed, *assuming the null hypothesis is true*.

**Concrete example:**
An experiment shows conversion improved from 4.0% to 4.5%, p = 0.03. This means: if the button change truly had no effect, there is a 3% chance of seeing a 0.5pp difference this large by random variation alone.

**Most common misinterpretation:**
"P = 0.03 means there is a 97% chance the result is real." This is wrong. The p-value says nothing about the probability that the null hypothesis is true or that the result is real.

**Practical implication:**
At alpha = 0.05, 1 in 20 truly null experiments will appear significant. This is why pre-registration and single primary metrics matter.

---

### Q2 — Confidence interval

**Question:** What is a 95% confidence interval? What does it not mean?

**Definition:**
A 95% CI is constructed so that if we ran the experiment many times and calculated a CI each time, 95% of those intervals would contain the true parameter value.

**What it does not mean:**
"There is a 95% probability that the true value is in this interval." Once the interval is calculated, the true value is either in it or not — probability doesn't apply to a fixed interval.

**Why it matters:**
CIs communicate effect size and precision. A CI of [+0.1%, +2.0%] tells a different story than [+0.1%, +15%] even if both exclude zero.

---

### Q3 — Type I vs Type II errors

**Question:** What are Type I and Type II errors, and why is the trade-off between them important in product experiments?

| Error | Definition | In experimentation | Rate controlled by |
|-------|-----------|-------------------|-------------------|
| Type I | False positive — rejected a true null | Shipped a feature that didn't work | Alpha (significance level) |
| Type II | False negative — missed a real effect | Did not ship a feature that worked | Beta (1 − power) |

**Trade-off:**
Lowering alpha (e.g. 0.01 instead of 0.05) reduces false positives but requires a larger sample to maintain power. Raising alpha increases false positives but makes it easier to detect real effects.

**Practical implication:**
In most product experiments, the cost of a Type I error (shipping something that doesn't work) is lower than in medical trials. But in irreversible decisions or high-risk changes, lower alpha makes sense.

---

### Q4 — Statistical power

**Question:** What is statistical power, and why does it matter for experiment design?

**Definition:**
Power is the probability of correctly detecting a true effect of the specified size. Power = 1 − beta. Conventionally set to 80%.

**Why it matters:**
An underpowered test produces null results that prove nothing. If power is 30% for the effect size you care about, a null result means you had a 70% chance of missing a real improvement. You cannot conclude the feature did not work.

**Practical implication:**
Always calculate the required sample size before launching, using a realistic MDE. Never run a test "and see what happens." If you get a null result from an underpowered test, the only valid conclusion is: "the test was inconclusive."

---

### Q5 — Effect size vs statistical significance

**Question:** An experiment shows p = 0.001. Does that mean the result is important?

**No.** Statistical significance and practical significance are different things.

- Statistical significance says the result is unlikely to be random.
- Practical significance says the effect size is large enough to matter.

With a very large sample, even a 0.001% conversion lift will be statistically significant — but it may not be worth the engineering cost to ship.

**Always report both:**
> "The treatment increased conversion from 4.000% to 4.003% (p = 0.0001). The effect is statistically significant but represents approximately 3 additional conversions per day — we would recommend not shipping based on this alone."

---

### Q6 — Multiple testing

**Question:** A team runs 20 experiments simultaneously, each at alpha = 0.05. How many false positives should they expect?

**Answer:** On average, 1 false positive (0.05 × 20 = 1). If all 20 null hypotheses are true, each has a 5% chance of a false positive.

**Correction approaches:**
- **Bonferroni:** divide alpha by the number of tests (0.05/20 = 0.0025 per test). Conservative.
- **Benjamini-Hochberg (FDR):** controls the expected proportion of false positives among significant results. Less conservative.

**Practical context:**
This is why choosing a single pre-specified primary metric matters. Running 10 metrics and declaring victory on the one that hits p < 0.05 is multiple testing.

---

### Q7 — When to use which test

**Question:** When would you use a two-sample t-test vs a proportion test vs a Mann-Whitney U test?

| Situation | Test |
|-----------|------|
| Comparing two means (revenue per user, session length) | Two-sample t-test (assumes approximate normality for large n) |
| Comparing two proportions (conversion rates) | Two-proportion z-test or chi-square test |
| Non-normal distribution, small sample, or ranked outcome | Mann-Whitney U test (non-parametric) |
| Multiple variants | ANOVA + post-hoc correction |
| Count outcomes (purchases per user, messages sent) | Negative binomial or Poisson regression |

**Practical note:**
For large samples (n > 1,000), the central limit theorem means the t-test is robust to non-normality. Outliers in revenue metrics can still cause issues — consider capping or log-transforming before testing.

---

### Q8 — Variance and experiment sensitivity

**Question:** Your experiment metric is "revenue per user" and results are noisy. How would you improve the sensitivity of the experiment?

**Options:**

1. **CUPED (Controlled-experiment Using Pre-Experiment Data):** use pre-experiment values of the metric as a covariate to reduce variance. Widely used at tech companies.
2. **Trim outliers:** cap revenue at the 99th percentile to reduce the variance driven by high-value outliers.
3. **Use a ratio metric:** revenue per converted user instead of revenue per user — reduces noise if the conversion rate is very low.
4. **Increase sample size:** straightforward but requires more time.
5. **Stratified sampling:** assign users to variants in proportion to their predicted value — ensures balanced groups on key covariates.

---

## Common mistakes

- Treating p < 0.05 as proof of an effect
- Confusing a CI with "the probability the true value is in this range"
- Ignoring practical significance — statistical significance alone is not enough to ship
- Running multiple tests on the same data without correction
- Accepting a null result as proof of no effect without checking power

---

*A/B testing application: [ab_testing_questions.md](ab_testing_questions.md)*
*Core foundation: [../03_statistics_and_experimentation/README.md](../03_statistics_and_experimentation/README.md)*
