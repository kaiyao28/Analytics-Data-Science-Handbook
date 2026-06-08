# Analytics Data Science Checklists

Practical checklists for every stage of analysis work. The goal is to build habits that catch errors before they become credibility problems.

---

## Before starting any analysis

Use before writing SQL or opening a notebook.

- [ ] What specific decision will this analysis support?
- [ ] Who is the stakeholder, and when do they need this?
- [ ] What is the primary metric?
- [ ] What are the guardrail metrics?
- [ ] What population should be included or excluded?
- [ ] What time period is relevant?
- [ ] What data sources are needed, and are they trustworthy?
- [ ] What assumptions am I making about the data?
- [ ] Is this the right question, or is there a better one to answer first?

---

## Before writing SQL

- [ ] Have I confirmed the grain of each table I am using?
- [ ] Could any table have duplicate rows? Do I need to deduplicate?
- [ ] Are timestamps stored in UTC? Do I need to convert to local time?
- [ ] Which join type is correct — and will a left join be silently converted to an inner join by my WHERE clause?
- [ ] Have I wrapped all denominators in `NULLIF(..., 0)`?
- [ ] Am I filtering before joining (in a CTE) rather than after (inflating row counts)?

---

## Before trusting a metric

- [ ] Is the metric definition written down and agreed upon?
- [ ] Is the denominator unambiguous — what population is included?
- [ ] Have I checked for missing data, nulls, or duplicates that affect the calculation?
- [ ] Is the time period correct? Am I using UTC or local time consistently?
- [ ] Could the metric be affected by a composition shift (the mix of users changing, not their behaviour)?
- [ ] Is the metric sensitive enough to detect the change I care about?
- [ ] Have I checked the raw event count alongside the metric? (A logging issue shows up here)

---

## Before launching an A/B test

- [ ] Is the hypothesis stated as: "if we do X, then Y will change because Z"?
- [ ] Is the primary metric defined and documented before launch?
- [ ] Are guardrail metrics defined?
- [ ] Has sample size been calculated for the minimum detectable effect?
- [ ] Has test duration been calculated (at least 1 full weekly cycle, ideally 2–3)?
- [ ] Is the randomisation unit correct (user, not session or device, for most product tests)?
- [ ] Is event logging in place and tested in a pre-prod environment before launch?
- [ ] Has a sample ratio mismatch check been planned for day 1 of the test?
- [ ] Is a pre-specified ship/no-ship criterion documented?
- [ ] Has the experiment been reviewed for novelty effect risk?

---

## Before interpreting an experiment result

- [ ] Has the test run for the full pre-specified duration? (Do not peek early.)
- [ ] Is there a sample ratio mismatch? If yes, stop here and investigate.
- [ ] Are results segmented by platform, country, user type and acquisition channel?
- [ ] Is the effect size practically significant, not just statistically significant?
- [ ] Have guardrail metrics been checked?
- [ ] Is the result stable across all weeks of the experiment (not just the final days)?
- [ ] Have I compared week 1 vs week 3 results to check for a novelty effect?
- [ ] Can I explain the result mechanistically? Does it make sense given the product change?

---

## Before sharing results

Use before sending any analysis to a stakeholder.

- [ ] Is the metric definition explicit and documented in the output?
- [ ] Are denominators stated clearly?
- [ ] Have I checked sample size? Is it sufficient for the conclusion I am drawing?
- [ ] Have I considered seasonality or calendar effects?
- [ ] Have I separated fact from interpretation — and labelled them differently?
- [ ] Is there a clear, specific recommendation?
- [ ] Have I quantified uncertainty (confidence intervals, not just point estimates)?
- [ ] Have I addressed the most likely objections proactively?
- [ ] Can a non-technical person understand the takeaway in 30 seconds?

---

## Before recommending a product launch

- [ ] Was the primary metric pre-specified? Or was it chosen after seeing results?
- [ ] Is the effect both statistically and practically significant?
- [ ] Are guardrail metrics stable?
- [ ] Is the effect consistent across major segments (platform, country, user type)?
- [ ] Has a novelty effect check been done?
- [ ] Is the result consistent across the full test duration?
- [ ] Are there any unresolved data quality concerns?
- [ ] Is there a monitoring plan for the first 30 days post-launch?

---

## Before using a causal inference method

Use when running DiD, matching, RDD or synthetic control instead of an experiment.

- [ ] Why can we not run an A/B test? Is the reason valid?
- [ ] Which observational method fits the design (DiD, RDD, matching)?
- [ ] What are the key assumptions of this method?
- [ ] Have I plotted pre-period trends to check the parallel trends assumption (for DiD)?
- [ ] Have I checked covariate balance between treated and control groups?
- [ ] Could there be spillover effects (one group's treatment affecting another's outcome)?
- [ ] Am I claiming causality, or a credible estimate under stated assumptions?
- [ ] Have I stated explicitly what would invalidate my conclusion?

---

## Before publishing a dashboard

- [ ] Is the dashboard title a specific question or statement, not just a category name?
- [ ] Does every chart have a clear label, unit and time range?
- [ ] Is the data source and refresh frequency documented?
- [ ] Are metric definitions accessible (tooltip or linked doc)?
- [ ] Have filters and defaults been tested?
- [ ] Has a second person checked the numbers against a known source?
- [ ] Does the dashboard answer the question it was built for?
- [ ] Have you removed charts no one will use?

---

## Diagnosing an unexpected metric change

Use when a key metric moves unexpectedly.

1. **Is the change real?** Check for pipeline failures, logging bugs, SRM or instrument errors.
2. **When did it start?** Find the exact date or hour.
3. **What changed at that time?** Product releases, experiments, external events, schema changes.
4. **Which segments are affected?** Platform, country, user type, cohort, acquisition channel.
5. **Is it numerator, denominator, or composition?** Rate metrics can move without behaviour change.
6. **What do correlated metrics say?** Related metrics confirm or contradict the hypothesis.
7. **State the most likely explanation** as a hypothesis with supporting evidence.
8. **Define the next analysis** that would confirm or rule it out.

---

## Common red flags

Stop and investigate before continuing if you see any of these:

| Red flag | What it likely means |
|----------|---------------------|
| Sample ratio mismatch in an experiment | Assignment bug — do not interpret metric results |
| Metric jumps exactly at midnight or on the first of a month | Timezone conversion error or pipeline batch issue |
| Metric only changes for one platform/country | Platform-specific bug or data logging issue |
| p-value exactly at 0.05 | Possible p-hacking; check whether metric was chosen after seeing results |
| Denominator is larger than total users in that period | Double-counting from a fanout join |
| Average is much higher than median | Outliers are dominating; check distribution before reporting mean |
| Metric improves but a correlated metric diverges unexpectedly | Possible instrumentation error or definition mismatch |
| A/B test effect gets stronger every time you check | Peeking bias — do not declare results until the pre-specified end date |

---

## What good analysis looks like

| Dimension | What good looks like |
|-----------|---------------------|
| Question | Specific, tied to a decision |
| Metric | Defined precisely, denominator documented |
| Data quality | Source known, grain understood, quality checked |
| Method | Appropriate for the question, assumptions stated |
| Result | Fact and interpretation clearly separated |
| Uncertainty | Quantified with confidence intervals, not hidden |
| Recommendation | Specific, actionable, honest about limitations |
| Communication | Stakeholder understands the takeaway without follow-up questions |

---

*Related sections: [01 · Product thinking](01_product_and_business_thinking/README.md) · [03 · Experimentation](03_statistics_and_experimentation/README.md) · [04 · Causal inference](04_causal_inference/README.md) · [08 · Communication](08_communication_and_decision_making/README.md)*
