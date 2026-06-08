# Career Levels in Analytics Data Science

What separates junior from senior from staff is not knowledge of more techniques. It is the ability to frame better questions, make decisions under ambiguity, and improve the systems around you.

---

## Level comparison

| Level | Main value | Typical work | What good looks like | Common failure mode |
|-------|-----------|-------------|----------------------|---------------------|
| **Junior** | Reliable execution | SQL queries, dashboards, simple metric tracking | Accurate, well-checked, clearly labelled work | Answers the literal question without questioning it |
| **Mid-level** | Owns analytical workstreams | Metric design, experiment readouts, root cause analysis | Chooses the right method and explains the trade-off | Produces analysis but stops before the decision |
| **Senior** | Shapes product decisions | Ambiguous problems, causal strategy, roadmap influence | Frames the problem, guides stakeholders, recommends action | Over-engineers solutions; loses sight of the decision |
| **Staff/Lead** | Builds systems and standards | Metrics layer, experiment quality, analytics governance | Makes teams better, not just projects better | Becomes a bottleneck; holds all the judgment |
| **Manager** | Builds people and operating model | Prioritisation, coaching, stakeholder alignment | Improves team quality, speed and decision impact | Manages tasks only, not judgment development |

---

## How responsibilities change

### From junior to mid-level

**Junior:** Given a clearly defined question and data. Responsible for accuracy and clarity of output.

**Mid-level:** Given a fuzzy question and expected to clarify it. Responsible for choosing the right method, not just executing one.

The key shift: you stop waiting to be told what to measure and start proposing what to measure and why.

**What to practise:**
- Before writing SQL, write down: "The question I'm answering is X. The metric I'm measuring is Y. The denominator is Z."
- When given a vague request, ask: "What decision will this analysis inform?"
- Present findings with a recommendation, not just results.

---

### From mid-level to senior

**Mid-level:** Owns the analysis. Delivers clear outputs with correct methods.

**Senior:** Owns the decision context. Helps stakeholders understand what question to ask before answering it.

The key shift: you move from "here is what the data shows" to "here is what we should do, and here is the uncertainty we're accepting."

**What to practise:**
- Push back on the metric definition before accepting the question.
- Tell stakeholders when you don't have enough data to answer the question — and what you'd need.
- Quantify uncertainty explicitly: "We're 80% confident the effect is between X and Y."
- Recommend against launching when the evidence doesn't support it.

---

### From senior to staff/lead

**Senior:** Solves hard analytical problems. Has strong judgment on individual decisions.

**Staff/Lead:** Improves how the team as a whole approaches problems. Builds standards, frameworks and systems that make everyone better.

The key shift: your leverage becomes the team's quality, not your own output.

**What to practise:**
- Write documentation that helps others make decisions you would have made.
- Define the team's experiment review criteria, metric standards, and data quality checks.
- Identify patterns in where the team's analyses go wrong and fix the root cause, not just individual instances.
- Spend time unblocking others and reviewing work, not just doing it yourself.

---

### From senior to manager

**Senior:** Has deep analytical judgment. Influences decisions through quality of work.

**Manager:** Has people judgment. Influences decisions through the quality of people and processes.

The key shift: your success is measured by the team's output, not yours. The analysis you are most proud of is one you helped someone else do well.

**What to practise:**
- Review analysis to develop judgment, not just to catch errors.
- Ask "why did you approach it this way?" before correcting it.
- Separate coaching conversations from task reviews.
- Build a rubric for what good looks like — so the team can self-assess without you.

---

## What to practise at each level in this handbook

| Level | Recommended starting point | Key files |
|-------|---------------------------|-----------|
| Junior | Follow the learning path | [ROADMAP.md](ROADMAP.md), [02_sql_for_analytics/](02_sql_for_analytics/), [03_statistics_and_experimentation/](03_statistics_and_experimentation/) |
| Mid-level | Master the decision workflow | [01_product_and_business_thinking/](01_product_and_business_thinking/), [CHECKLISTS.md](CHECKLISTS.md), [09_case_studies/](09_case_studies/) |
| Senior | Build judgment | [08_communication_and_decision_making/senior_judgement.md](08_communication_and_decision_making/senior_judgement.md), [WORK_MODE.md](WORK_MODE.md), [03_statistics_and_experimentation/common_experiment_mistakes.md](03_statistics_and_experimentation/common_experiment_mistakes.md) |
| Staff/Lead | Build systems | [ANALYSIS_REVIEW_CHECKLIST.md](ANALYSIS_REVIEW_CHECKLIST.md), [08_communication_and_decision_making/](08_communication_and_decision_making/) |
| Manager | Coach others | [MANAGER_MODE.md](MANAGER_MODE.md), [10_interview_prep/gold_standard_answers.md](10_interview_prep/gold_standard_answers.md) |

---

## Common failure modes by level

### Junior

**The prompt-follower:** Executes exactly what was asked, even when the question is wrong or the metric is broken. Produces technically correct analysis of the wrong thing.

> Weak: "You asked me to measure clicks, so I measured clicks."
> Strong: "Clicks are easy to inflate with dark patterns — can we use task completion instead?"

**The precision-over-speed trap:** Spends four days on a perfect analysis when a four-hour version would have been good enough to make the decision.

---

### Mid-level

**The analyst without a recommendation:** Produces a thorough analysis and ends with "here are the options" or "it depends." Stakeholders are left without a decision.

> Weak: "Retention could be dropping because of X, Y or Z. Further investigation is needed."
> Strong: "The most likely cause is X because Y. I recommend doing Z. If we see W in the next two weeks, that changes the recommendation."

**The method-first trap:** Chooses a method because it's sophisticated, not because it fits the question. Uses a DiD when a simple pre/post would have answered the question and been easier to explain.

---

### Senior

**The caveat accumulator:** Adds so many caveats that the recommendation becomes useless. Every uncertainty is surfaced, none is quantified.

> Weak: "Given the limitations of the data, the possible confounders, and the uncertainty in the metric, we could potentially consider shipping, but there are risks."
> Strong: "Ship. Primary metric passed, guardrails stable. The main risk is novelty effect — monitor week 3–4 retention and revert if D30 drops more than 2pp."

**The over-engineer:** Builds a complex causal model when the question could have been answered by a two-week experiment. Optimises for technical elegance over decision speed.

---

### Staff/Lead

**The single point of failure:** All hard analytical questions escalate to them. The team has become dependent on one person's judgment rather than internalising a standard.

**The standard-setter without buy-in:** Publishes a metrics taxonomy or experiment governance framework that no one uses, because it was written without involving the team.

---

### Manager

**The task manager:** Runs the team like a project management system — tracks outputs, not growth. Team members know what to do but not how to improve.

**The brilliant-but-blocked manager:** Does the best analytical work on the team, creates bottlenecks, and cannot delegate because no one is good enough yet.

---

## Weak vs strong across levels: the same question

**Question:** "Conversion dropped 15% last week. Why?"

| Level | Typical approach |
|-------|-----------------|
| Junior | Pulls conversion numbers week-over-week, reports the drop |
| Mid-level | Disaggregates by platform and channel, checks for data quality issues, identifies the likely driver |
| Senior | Does the above + checks whether the drop is real (tracking), frames it as "here is the most likely cause, here is what we'd need to confirm it, here is what to do now" |
| Staff/Lead | Notices this is the third time this question has taken a week to answer, and builds a metric health dashboard so it can be answered in hours |
| Manager | Asks "why did this take us a week to diagnose?" and coaches the team through a better process rather than solving it themselves |

---

*Work routing: [WORK_MODE.md](WORK_MODE.md)*
*Interview prep: [10_interview_prep/README.md](10_interview_prep/README.md)*
*Manager coaching: [MANAGER_MODE.md](MANAGER_MODE.md)*
*Analysis review: [ANALYSIS_REVIEW_CHECKLIST.md](ANALYSIS_REVIEW_CHECKLIST.md)*
