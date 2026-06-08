# Analytics Data Science Handbook

A practical handbook for learning analytics and product data science: metrics, SQL, experimentation, causal inference, dashboards, communication and case studies.

---

## Start here

| Need | Open |
|------|------|
| I have an interview soon | [INTERVIEW_MODE.md](INTERVIEW_MODE.md) |
| I need help with real work | [WORK_MODE.md](WORK_MODE.md) |
| I am not sure where to start | [PROBLEM_INDEX.md](PROBLEM_INDEX.md) |
| I need quick recall | [00_quick_reference/](00_quick_reference/) |
| I want the full learning path | [ROADMAP.md](ROADMAP.md) |

---

## Example: diagnosing a metric drop

If activation drops, do not jump straight to modelling.

1. Check data freshness and whether tracking changed.
2. Split by platform, country, acquisition channel and user type.
3. Decompose: is it the numerator (fewer activations) or denominator (more signups)?
4. Check product, marketing and seasonal changes that week.
5. Form 2–3 specific hypotheses with mechanisms.
6. Recommend one diagnostic query or product action per hypothesis.

The full framework: [01_product_and_business_thinking/metric_change_diagnosis.md](01_product_and_business_thinking/metric_change_diagnosis.md)

---

## Purpose

This handbook teaches the thinking, skills and judgment needed to work effectively as an analytics or product data scientist. It is not a textbook. It is not a link dump. It is a structured, practical guide you can read, practise from and return to throughout your career.

---

## Who this is for

- Aspiring analytics or product data scientists
- Data analysts moving into a more senior or science-focused role
- Software engineers or BI analysts transitioning into data science
- Anyone preparing for analytics DS interviews
- Practitioners who want to sharpen product intuition and statistical rigour

---

## What analytics data scientists do

Analytics and product data scientists sit at the intersection of product, engineering and business. Their core job is to help organisations make better decisions using data.

Day to day this means:

- Translating product questions into measurable metrics
- Designing and analysing experiments
- Diagnosing changes in metrics
- Building dashboards and self-serve analytics
- Communicating uncertainty and risk to stakeholders
- Recommending what to build, change or stop

What separates excellent practitioners from average ones is **judgment**: knowing which question to answer, which method to use, and how to communicate the answer clearly.

---

## Start here

If you are new to analytics data science, follow this order:

1. [Product and business thinking](01_product_and_business_thinking/README.md) — understand what question you are answering
2. [SQL for analytics](02_sql_for_analytics/README.md) — extract and transform data
3. [Statistics and experimentation](03_statistics_and_experimentation/README.md) — measure with rigour
4. [Dashboards and data storytelling](06_dashboards_and_data_storytelling/README.md) — communicate findings clearly
5. [Causal inference](04_causal_inference/README.md) — answer harder questions without experiments
6. [Python and analysis workflows](05_python_and_analysis_workflows/README.md) — build reproducible analysis
7. [Machine learning for analytics](07_machine_learning_for_analytics/README.md) — add predictive capability
8. [Communication and decision making](08_communication_and_decision_making/README.md) — write and present well
9. [Case studies](09_case_studies/README.md) — apply everything end to end
10. [Interview prep](10_interview_prep/README.md) — practise with real questions

Do not try to read everything at once. For each topic: read the concept, study the example, then complete one exercise.

---

## Minimum viable path (2 weeks)

If you only have two weeks:

| Days | Topic |
|------|-------|
| 1-2 | Metrics, funnels, retention |
| 3-4 | SQL joins and window functions |
| 5-6 | Funnel and cohort SQL |
| 7-8 | A/B testing basics |
| 9-10 | Experiment readout template |
| 11-12 | One full case study |
| 13-14 | Five SQL questions and five product sense questions |

---

## First practical path

The fastest way to understand how analytics data scientists actually work:

| Step | Task | Where |
|------|------|-------|
| 1 | Define the product question and metric | [01 Product thinking](01_product_and_business_thinking/README.md) |
| 2 | Write SQL to extract the data | [02 SQL](02_sql_for_analytics/README.md) |
| 3 | Check data quality | [CHECKLISTS.md](CHECKLISTS.md) |
| 4 | Apply the right statistical method | [03 Statistics](03_statistics_and_experimentation/README.md) |
| 5 | Write a clear recommendation | [08 Communication](08_communication_and_decision_making/README.md) |
| 6 | See it done end to end | [09 Case studies](09_case_studies/README.md) |

---

## Repository structure

| Folder | What you will learn |
|--------|---------------------|
| [00_quick_reference](00_quick_reference/) | Cheatsheets and frameworks for interviews and real work |
| [01_product_and_business_thinking](01_product_and_business_thinking/) | Metrics, funnels, retention, metric diagnosis |
| [02_sql_for_analytics](02_sql_for_analytics/) | SQL patterns, joins, window functions, product queries |
| [03_statistics_and_experimentation](03_statistics_and_experimentation/) | Hypothesis testing, A/B testing, power analysis |
| [04_causal_inference](04_causal_inference/) | DiD, matching, RDD, when experiments are not possible |
| [05_python_and_analysis_workflows](05_python_and_analysis_workflows/) | Pandas, EDA, reproducible analysis |
| [06_dashboards_and_data_storytelling](06_dashboards_and_data_storytelling/) | Dashboard design, visualisation, metric layer |
| [07_machine_learning_for_analytics](07_machine_learning_for_analytics/) | Churn, uplift, ranking, model evaluation |
| [08_communication_and_decision_making](08_communication_and_decision_making/) | Insight writing, decision memos, stakeholder communication |
| [09_case_studies](09_case_studies/) | End-to-end walkthroughs of realistic product problems |
| [10_interview_prep](10_interview_prep/) | SQL, product sense, A/B testing, statistics questions |

Supporting files:

| File | Purpose |
|------|---------|
| [INTERVIEW_MODE.md](INTERVIEW_MODE.md) | One-page interview reference for all question types |
| [WORK_MODE.md](WORK_MODE.md) | Routing guide for real analytics work situations |
| [PROBLEM_INDEX.md](PROBLEM_INDEX.md) | Navigate by situation, not by topic |
| [ROADMAP.md](ROADMAP.md) | Learning paths for 2 weeks, 1 month and 3 months |
| [CHECKLISTS.md](CHECKLISTS.md) | Before-you-start and before-you-share checklists |
| [CAREER_LEVELS.md](CAREER_LEVELS.md) | Junior → senior → manager expectations and failure modes |
| [MANAGER_MODE.md](MANAGER_MODE.md) | For managers coaching analytics teams |
| [ANALYSIS_REVIEW_CHECKLIST.md](ANALYSIS_REVIEW_CHECKLIST.md) | 10-section checklist for reviewing any analysis |
| [GLOSSARY.md](GLOSSARY.md) | Definitions of key terms |

---

## Four ways to use this handbook

| Mode | Use when | Start with |
|------|----------|------------|
| Quick reference | You need an answer fast | [00_quick_reference/](00_quick_reference/) |
| Learning path | You are building foundations | [ROADMAP.md](ROADMAP.md) |
| Interview practice | You are preparing for interviews | [INTERVIEW_MODE.md](INTERVIEW_MODE.md) |
| Career growth | You want to move from junior to senior | [CAREER_LEVELS.md](CAREER_LEVELS.md) |

---

## How to use this repo

**Learning:** Follow the start-here order. Read each folder README before diving into individual files.

**Reference at work:** Open [WORK_MODE.md](WORK_MODE.md) or [PROBLEM_INDEX.md](PROBLEM_INDEX.md) to find the right file for your situation.

**Interview prep:** Open [INTERVIEW_MODE.md](INTERVIEW_MODE.md) for a full reference, or [00_quick_reference/interview_panic_sheet.md](00_quick_reference/interview_panic_sheet.md) for the 30-minute version.

**Career growth:** Read [CAREER_LEVELS.md](CAREER_LEVELS.md) to understand what good looks like at your target level, then use [ANALYSIS_REVIEW_CHECKLIST.md](ANALYSIS_REVIEW_CHECKLIST.md) to audit your own work.

**Managing a team:** Open [MANAGER_MODE.md](MANAGER_MODE.md) for coaching and review frameworks.

---

## What makes someone excellent at analytics data science

Technical skills are necessary but not sufficient. Excellent practitioners also:

- **Ask the right question** before picking a method
- **Define the metric precisely** before pulling data
- **Check their assumptions** before drawing conclusions
- **Separate fact from interpretation** in their writing
- **Quantify uncertainty** rather than hiding it
- **Say "we don't know"** when that is the correct answer
- **Recommend a decision**, not just a finding

This handbook tries to teach all of these.

---

## Disclaimer

This is an independent learning resource, not affiliated with or endorsed by any company. Examples are fictional and for educational purposes only.

---

*Contributions welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).*
