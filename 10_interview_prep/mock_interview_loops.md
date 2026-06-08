# Mock Interview Loops

Four timed practice loops. Each simulates one interview format. Complete the whole loop — including the self-score — before reviewing answers.

---

## How to use this

1. Set a timer. Stick to it.
2. Write your answer out before looking at the answer structure.
3. Self-score honestly using the rubric.
4. If you scored 3 or below, go to the review link before the next loop.

Do one loop per session. Rotating across loops over four days covers every format.

---

## Loop 1 — SQL (45 minutes total)

**Warm-up (5 min):** Without looking anything up, write the SQL syntax for:
- A window function that calculates a 7-day rolling sum
- An anti-join using LEFT JOIN
- A query that finds each user's first event

Use schema: `users(user_id, signup_date, country)`, `events(user_id, event_type, event_time)`

---

**Q1 (10 min):** Write a query that returns, for each week, the number of new users who signed up and the number of users who were active (had any event) in the same week.

**Q2 (12 min):** A product manager asks: "What fraction of users who added an item to cart in the last 30 days completed a purchase within 24 hours?" Write the query.

Use schema: `events(user_id, event_type, event_time)` where event types include `add_to_cart` and `purchase_completed`.

**Q3 (12 min):** Write a query that, for each user, returns the number of days between their signup date and their first purchase. Include users who have never purchased (show NULL for them).

---

**Self-score: SQL loop**

Score yourself 1–5 on each dimension:

| Dimension | 1 | 3 | 5 |
|-----------|---|---|---|
| Syntax correctness | Major errors or blank | Minor syntax issues | Runs correctly |
| Logic | Wrong approach | Right idea, minor gap | Correct and efficient |
| Edge cases | Ignored | Mentioned but not handled | Handled in query |
| Speed | Needed > time limit | Close to time | Well within limit |

**If average < 3:** Review [sql_questions.md](sql_questions.md) Q1–Q5, then redo the warm-up next session.

**If average 3–4:** Re-do Q2 and Q3 focusing on the edge case you missed.

---

## Loop 2 — Product sense (40 minutes total)

**Warm-up (5 min):** State three examples of north star metrics from real products you use. For each: name the metric precisely (with denominator), and name one guardrail.

---

**Q1 (10 min):** "A food delivery app has seen the number of orders per active user decline 12% over the past two months. How would you investigate this?"

Hit: data quality, timing, segmentation by user type, decompose (fewer orders per session vs fewer sessions), form a hypothesis.

**Q2 (10 min):** "How would you measure whether a newly launched 'group order' feature is successful? Define three metrics."

Hit: define the population, state a primary metric precisely, add secondary + guardrail.

**Q3 (10 min):** "The team wants to test a 10% price increase on premium subscriptions. What metrics would you track? What guardrails?"

Hit: immediate impact (paid conversion rate), downstream impact (retention, cancellation), guardrails (support contacts, NPS change if tracked).

---

**Self-score: Product sense loop**

| Dimension | 1 | 3 | 5 |
|-----------|---|---|---|
| Framework used | None | Partial | Full structured answer |
| Metric precision | Vague name only | Name + direction | Name + numerator + denominator + window |
| Guardrails | Missing | One mentioned | Two or more, with mechanism |
| Recommendation | None | Yes, vague | Specific, with condition |

**If average < 3:** Review [product_sense_questions.md](product_sense_questions.md) and [case_interview_framework.md](case_interview_framework.md).

**If average 3–4:** Focus on making metric definitions more precise.

---

## Loop 3 — A/B testing (45 minutes total)

**Warm-up (5 min):** Recite from memory the six steps for designing an A/B test. Then state the four inputs to a sample size calculation.

---

**Q1 (12 min):** "Design an experiment to test whether adding customer reviews to a product page increases add-to-cart rate."

State: hypothesis, randomisation unit, primary metric, two guardrails, sample size inputs, expected duration, launch criterion, two risks.

**Q2 (10 min):** "Your experiment ran for three weeks. Results: primary metric +2.8pp, p = 0.04. Secondary metric A +1.2pp, p = 0.18. Secondary metric B -0.4pp, p = 0.37. What do you recommend?"

**Q3 (12 min):** "Six days into an experiment, your team notices the split is 48.1% control / 51.9% treatment. Daily traffic is 2,000 users per variant. Is this a problem? What do you do?"

---

**Self-score: A/B testing loop**

| Dimension | 1 | 3 | 5 |
|-----------|---|---|---|
| Hypothesis quality | No mechanism stated | Direction stated | Mechanism stated clearly |
| Sample size / duration | Not addressed | Inputs named | Inputs + duration calculated |
| Result interpretation | Wrong conclusion | Correct conclusion, incomplete | Correct + practical significance + guardrails |
| SRM handling | Ignored or wrong | Flagged as problem | Flagged + steps to investigate + hold analysis |

**If average < 3:** Review [ab_testing_questions.md](ab_testing_questions.md) and [../03_statistics_and_experimentation/ab_testing.md](../03_statistics_and_experimentation/ab_testing.md).

**If average 3–4:** Focus on always stating the mechanism in your hypothesis and always checking guardrails in your recommendation.

---

## Loop 4 — Metric diagnosis (40 minutes total)

**Warm-up (5 min):** Recite the 7-step metric change diagnosis framework from memory. Then name the three steps you should always do first (before forming a hypothesis).

---

**Q1 (10 min):** "Weekly active users on a desktop productivity app dropped 8% this week compared to last week. Walk me through your investigation."

Hit: data quality, day of week, correlated events (holiday? product change?), segment by OS/plan/country, decompose (new vs returning users).

**Q2 (10 min):** "Your company's checkout conversion rate increased 3% after a recent redesign. The CEO wants to know if the redesign caused it. How do you answer?"

Hit: distinguish correlation from causation, is this an A/B test result or observational? If observational, other things changed too. Acknowledge the limitation before claiming attribution.

**Q3 (10 min):** "A mobile app's D7 retention increased from 22% to 26% over three months. What could explain this, and what questions would you ask before attributing it to the new onboarding flow launched eight weeks ago?"

Hit: cohort composition change (different acquisition mix?), seasonality, other changes in the period, was onboarding change assigned randomly? What does the pre/post overlap look like?

---

**Self-score: Metric diagnosis loop**

| Dimension | 1 | 3 | 5 |
|-----------|---|---|---|
| Framework | No structure | Partial structure | All 7 steps referenced |
| Data quality first | Skipped | Mentioned in passing | Always first before hypothesis |
| Segmentation | None | One cut | Multiple meaningful cuts |
| Causality caution | Claimed causation from correlation | Noted it is observational | Clearly distinguished, stated limitation |

**If average < 3:** Review [case_interview_framework.md](case_interview_framework.md) and [../01_product_and_business_thinking/metric_change_diagnosis.md](../01_product_and_business_thinking/metric_change_diagnosis.md).

**If average 3–4:** Focus on the data quality and causality caution dimensions — these are the most common gaps.

---

## Loop rotation schedule

| Day | Loop | Focus |
|-----|------|-------|
| 1 | SQL | Window functions, funnel logic |
| 2 | Product sense | Metric design, guardrails |
| 3 | A/B testing | Design, SRM, interpretation |
| 4 | Metric diagnosis | Framework, causation vs correlation |
| 5 | SQL (repeat) | Speed + edge cases |
| 6 | A/B testing (repeat) | Tricky cases |

---

*Full question banks: [sql_questions.md](sql_questions.md), [ab_testing_questions.md](ab_testing_questions.md), [product_sense_questions.md](product_sense_questions.md)*
*Gold standard answers: [gold_standard_answers.md](gold_standard_answers.md)*
*30-minute prep: [../00_quick_reference/interview_panic_sheet.md](../00_quick_reference/interview_panic_sheet.md)*
