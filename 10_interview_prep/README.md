# 10 · Interview Prep

## Why this matters

Analytics DS interviews test a specific, learnable set of skills: SQL, product sense, experimental design, statistics and communication under time pressure. Most questions follow predictable patterns. Preparation is highly effective.

This section gives you structured frameworks, question banks and worked examples for each interview format.

---

## What you need to know

- The four main question types in analytics DS interviews
- How to structure a product sense answer
- How to approach a metric change question
- How to answer A/B testing design and analysis questions
- How to handle SQL questions efficiently and accurately
- How to communicate uncertainty and recommendations clearly under pressure

---

## Open this if...

| You need to... | Go to |
|----------------|-------|
| Interview in under 30 minutes | [../00_quick_reference/interview_panic_sheet.md](../00_quick_reference/interview_panic_sheet.md) |
| Do a timed mock loop with self-scoring | [mock_interview_loops.md](mock_interview_loops.md) |
| See what a gold standard answer looks like | [gold_standard_answers.md](gold_standard_answers.md) |
| Practice SQL questions | [sql_questions.md](sql_questions.md) |
| Practice product sense and metric questions | [product_sense_questions.md](product_sense_questions.md) |
| Practice A/B testing questions | [ab_testing_questions.md](ab_testing_questions.md) |
| Practice statistics questions | [statistics_questions.md](statistics_questions.md) |
| Understand the case interview format | [case_interview_framework.md](case_interview_framework.md) |

---

## Interview formats

**SQL questions** — write or debug a query from a schema. Tests: joins, window functions, aggregations, deduplication, funnel and retention logic. See `sql_questions.md`.

**Product sense questions** — "How would you measure the success of X?" or "What is the north star metric for Y?" Tests: metric definition, prioritisation, trade-off thinking. See `product_sense_questions.md`.

**Experiment design questions** — "How would you design an A/B test for Z?" Tests: hypothesis formulation, metric choice, sample size reasoning, guardrail metrics. See `ab_testing_questions.md`.

**Statistics questions** — conceptual questions on p-values, confidence intervals, distributions, bias. See `statistics_questions.md`.

**Case questions** — end-to-end analysis problems, typically starting with "a metric dropped." Tests structured diagnosis, root cause thinking and recommendation quality. See `case_interview_framework.md`.

---

## Core principles

**Define before you solve.** For any metric or product question, define your terms before proposing a method. "What counts as active?" should be your first question every time.

**Structure before depth.** Interviewers reward a clear structure over a detailed-but-unstructured answer. State your framework first, then fill it in.

**Disaggregate before concluding.** Before drawing a conclusion, break data down by segment: platform, country, user type, cohort. This separates cause from symptom.

**State your assumptions explicitly.** If you do not have data, say so. State what you would assume, why and what you would check to validate it.

**End with a recommendation.** Every case question ends with a decision. Give one, even if the evidence is imperfect.

---

## The metric change framework

The most common interview question type. Use this structure every time:

```
1. Verify the data
   Is the change real, or is it a pipeline/logging issue?

2. Establish timing
   When exactly did the change begin?

3. Look for correlated events
   What released, changed or happened at that time?

4. Disaggregate
   By platform / country / user type / cohort / acquisition channel

5. Identify the driver
   Is it numerator, denominator or composition?

6. Form a hypothesis
   "The most likely explanation is X because Y"

7. State the next step
   "To confirm, I would look at Z"
```

---

## Common interview mistakes

**Starting with the answer.** Interviewers assess your reasoning process, not just your conclusions. State your framework before your answer.

**Getting into SQL too fast.** For product questions, clarify what you are measuring before writing a query.

**Vague statements.** "I would look at retention" is weak. "I would look at day-30 retention for users acquired via paid channels in the last 90 days, segmented by platform" is strong.

**Forgetting the recommendation.** Even if the data is ambiguous, end with a specific recommendation and the condition under which you would change it.

**Silence.** Think out loud. Interviewers cannot assess reasoning they cannot hear.

---

## Interview relevance

This entire section is interview prep. Cross-reference with:

- [Case studies](../09_case_studies/README.md) for end-to-end problem practice
- [Statistics and experimentation](../03_statistics_and_experimentation/README.md) for conceptual questions
- [SQL for analytics](../02_sql_for_analytics/README.md) for query practice

---

## If you only have one day

Read `case_interview_framework.md`. Work through five SQL questions from `sql_questions.md`. Answer three questions from `product_sense_questions.md` out loud, timed.

---

## Files in this folder

| File | Topic |
|------|-------|
| `sql_questions.md` | SQL questions with schemas and worked answers |
| `product_sense_questions.md` | Product sense and metrics questions with frameworks |
| `ab_testing_questions.md` | Experiment design and analysis questions |
| `statistics_questions.md` | Statistics and probability questions |
| `case_interview_framework.md` | Step-by-step framework for metric change and open case questions |
| `mock_interview_loops.md` | Four timed practice loops with self-scoring rubrics |
| `gold_standard_answers.md` | Six annotated model answers with what makes them strong |
