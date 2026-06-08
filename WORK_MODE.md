# Work Mode

Open this when you have a real analytics problem and need to know where to start.

---

## Diagnosing an unexpected metric change

**Start with:**
1. [CHECKLISTS.md → Diagnosing an unexpected metric change](CHECKLISTS.md)
2. [01_product_and_business_thinking/metric_change_diagnosis.md](01_product_and_business_thinking/metric_change_diagnosis.md)
3. [02_sql_for_analytics/sql_patterns.md → Period-over-period comparison](02_sql_for_analytics/sql_patterns.md)

**SQL to run:** period-over-period by segment, funnel at each step, raw event count check

**Expected output:** Root cause memo — when it started, what caused it, which segment drives it, recommendation

---

## Designing an experiment

**Start with:**
1. [CHECKLISTS.md → Before launching an A/B test](CHECKLISTS.md)
2. [00_quick_reference/ab_testing_cheatsheet.md](00_quick_reference/ab_testing_cheatsheet.md)
3. [03_statistics_and_experimentation/README.md](03_statistics_and_experimentation/README.md)

**Expected output:** Experiment design document — hypothesis, randomisation unit, primary metric, guardrails, sample size calculation, duration, pre-specified launch criterion

---

## Analysing an A/B test result

**Start with:**
1. [CHECKLISTS.md → Before interpreting an experiment result](CHECKLISTS.md)
2. [02_sql_for_analytics/experiment_analysis.sql](02_sql_for_analytics/experiment_analysis.sql)
3. [09_case_studies/onboarding_activation_ab_test.md](09_case_studies/onboarding_activation_ab_test.md) — for a worked example

**Expected output:** Experiment readout — SRM, primary metric, guardrails, segment breakdown, novelty check, recommendation

**Template:** [00_quick_reference/communication_templates.md → Experiment readout](00_quick_reference/communication_templates.md)

---

## Defining success metrics for a new feature

**Start with:**
1. [01_product_and_business_thinking/product_case_framework.md](01_product_and_business_thinking/product_case_framework.md)
2. [01_product_and_business_thinking/metrics.md](01_product_and_business_thinking/metrics.md)
3. [00_quick_reference/product_metrics_cheatsheet.md](00_quick_reference/product_metrics_cheatsheet.md)

**Expected output:** Metrics plan — primary metric with denominator, 1–2 input metrics, guardrails, population definition, time window

---

## Writing a recommendation or readout

**Start with:**
1. [00_quick_reference/communication_templates.md](00_quick_reference/communication_templates.md) — templates for experiment readout, decision memo, null result explanation
2. [CHECKLISTS.md → Before sharing results](CHECKLISTS.md)
3. [08_communication_and_decision_making/README.md](08_communication_and_decision_making/README.md)

**Principle:** Lead with the recommendation. Evidence follows. State uncertainty explicitly.

---

## Answering a stakeholder question about a metric

**Before answering:**
1. [CHECKLISTS.md → Before trusting a metric](CHECKLISTS.md) — check definition, denominator, data quality
2. [01_product_and_business_thinking/metrics.md](01_product_and_business_thinking/metrics.md) — metric type and trade-offs

**Common situation:** stakeholder asks "why did X change?" → use the metric diagnosis workflow above

---

## Building a dashboard

**Start with:**
1. [CHECKLISTS.md → Before publishing a dashboard](CHECKLISTS.md)
2. [06_dashboards_and_data_storytelling/README.md](06_dashboards_and_data_storytelling/README.md)
3. [00_quick_reference/decision_flowcharts.md → Choosing a metric](00_quick_reference/decision_flowcharts.md)

**Five clarifying questions before building:** What decision does this dashboard support? Who is the audience? What is the refresh frequency? What is the primary metric? What should trigger an alert or investigation?

---

## Writing SQL for a product analysis

**Start with:**
1. [CHECKLISTS.md → Before writing SQL](CHECKLISTS.md)
2. [00_quick_reference/sql_cheatsheet.md](00_quick_reference/sql_cheatsheet.md)
3. Pick the template:
   - Funnel: [02_sql_for_analytics/funnel_analysis.sql](02_sql_for_analytics/funnel_analysis.sql)
   - Retention: [02_sql_for_analytics/retention_analysis.sql](02_sql_for_analytics/retention_analysis.sql)
   - Cohort revenue: [02_sql_for_analytics/cohort_analysis.sql](02_sql_for_analytics/cohort_analysis.sql)
   - Experiment: [02_sql_for_analytics/experiment_analysis.sql](02_sql_for_analytics/experiment_analysis.sql)

---

## Using causal inference when A/B testing is not possible

**Start with:**
1. [CHECKLISTS.md → Before using a causal inference method](CHECKLISTS.md)
2. [00_quick_reference/causal_inference_cheatsheet.md](00_quick_reference/causal_inference_cheatsheet.md)
3. [04_causal_inference/README.md](04_causal_inference/README.md)

**Expected output:** Observational study design — method, key assumption, pre-trend check, explicit limitations

---

*For interview preparation: [INTERVIEW_MODE.md](INTERVIEW_MODE.md)*
*For a problem-first index: [PROBLEM_INDEX.md](PROBLEM_INDEX.md)*
*For checklists: [CHECKLISTS.md](CHECKLISTS.md)*
