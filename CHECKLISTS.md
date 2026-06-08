# Analytics Data Science Checklists

Practical checklists to use at every stage of analysis work. Print them, paste them, bookmark them — the goal is to build the habit of checking before sharing.

---

## Before starting analysis

Use this before writing any SQL or code.

- [ ] What specific decision will this analysis support?
- [ ] Who is the stakeholder, and when do they need this?
- [ ] What is the primary metric?
- [ ] What are the guardrail metrics?
- [ ] What time period is relevant?
- [ ] What population should be included or excluded?
- [ ] What data sources are needed, and are they reliable?
- [ ] What assumptions am I making about the data?
- [ ] Is this the right question, or is there a better one to answer?

---

## Before sharing results

Use this before sending any analysis to a stakeholder.

- [ ] Is the metric definition explicit and documented?
- [ ] Are the denominators correct and clearly stated?
- [ ] Have I checked the sample size? Is it sufficient?
- [ ] Have I checked for missing data, nulls, or duplicates?
- [ ] Have I considered seasonality or calendar effects?
- [ ] Have I separated fact from interpretation?
- [ ] Is there a clear, specific recommendation?
- [ ] Have I quantified uncertainty (confidence intervals, not just point estimates)?
- [ ] Have I addressed the most likely objections in the write-up?
- [ ] Can a non-technical person understand the takeaway in 30 seconds?

---

## Before launching an A/B test

- [ ] Is the hypothesis clearly stated (if we do X, then Y will change because Z)?
- [ ] Is the primary metric defined before launch?
- [ ] Are guardrail metrics defined?
- [ ] Has sample size been calculated for the minimum detectable effect?
- [ ] Has test duration been calculated, accounting for weekly seasonality?
- [ ] Is the randomisation unit correct (user, session, device)?
- [ ] Has the experiment been reviewed for novelty effect risk?
- [ ] Is event logging in place and tested before launch?
- [ ] Has a sample ratio mismatch check been planned?
- [ ] Is a pre-specified ship/no-ship criterion documented?

---

## Before interpreting an experiment result

- [ ] Has the test run for the full pre-specified duration?
- [ ] Is there a sample ratio mismatch? (If yes, stop — investigate before interpreting.)
- [ ] Are results segmented? (Device, country, user type, acquisition channel)
- [ ] Is the effect size practically significant, not just statistically significant?
- [ ] Have guardrail metrics been checked?
- [ ] Is the result stable throughout the experiment, or only at the end?
- [ ] Have I checked for novelty effect by comparing early vs late period results?
- [ ] Can I explain the result mechanistically? Does it make sense given the product change?

---

## Diagnosing a metric change

Use when a key metric unexpectedly moves up or down.

1. **Is the change real?** Check for data pipeline issues, logging bugs, SRM or instrumentation errors before concluding anything.
2. **When did it start?** Identify the exact date or hour the change began.
3. **What changed at that time?** Product releases, experiments, external events, data migrations.
4. **Which segments are affected?** Break down by platform, country, user type, cohort, acquisition channel.
5. **Is it the numerator, denominator or both?** Rate metrics can move due to composition shifts, not actual behaviour change.
6. **What are correlated metrics saying?** Related metrics can confirm or contradict the hypothesis.
7. **What is the most likely explanation?** State it as a hypothesis.
8. **What would confirm or rule out that hypothesis?** Define the next analysis before running it.

---

## Before publishing a dashboard

- [ ] Is the dashboard title a clear statement of what it shows?
- [ ] Does every chart have a label, unit and time range?
- [ ] Is the data source and refresh frequency documented?
- [ ] Are metric definitions accessible (tooltip or linked documentation)?
- [ ] Have filters and their defaults been tested with real users?
- [ ] Has a second person reviewed for data correctness?
- [ ] Does the dashboard answer the specific question it was built for?
- [ ] Have you removed charts that no one will use?

---

## What good analysis looks like

| Dimension | What good looks like |
|-----------|---------------------|
| Question | Specific, tied to a decision |
| Metric | Defined precisely, denominator documented |
| Data | Source known, quality checked |
| Method | Appropriate for the question, assumptions stated |
| Result | Fact and interpretation clearly separated |
| Uncertainty | Quantified, not hidden |
| Recommendation | Specific and actionable |
| Communication | Stakeholder can understand it without asking follow-up questions |
