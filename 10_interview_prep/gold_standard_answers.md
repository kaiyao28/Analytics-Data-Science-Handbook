# Gold Standard Answers

Six model answers to the most common analytics DS interview questions. Each is annotated with what makes it strong and what weaker versions miss.

Use these to calibrate your own answers. Don't memorise them — understand why they work, then adapt to any variation.

---

## 1. Product metric design

**Question:** "How would you define the north star metric for a B2B SaaS project management tool?"

---

**Gold standard answer:**

> "I'd start by asking what user behaviour most strongly predicts whether a team renews their subscription. For a project management tool, the core value proposition is teams completing work on time and collaborating effectively — not just logging in.
>
> My proposal: **active projects with at least one update in the last 7 days per team account** — a team-level engagement metric rather than an individual user metric, since the purchasing decision is made at the team level.
>
> Why this instead of DAU or logins? Logins are easy to inflate artificially and do not capture whether users are getting value. 'Active projects' measures whether the tool is embedded in real workflows.
>
> I'd add two guardrails: task completion rate per project (we want projects moving forward, not just being updated), and team seat expansion (if teams are unhappy, they reduce seats).
>
> The north star I'd *avoid*: total tasks created. Teams can dump their entire backlog on day one without ever completing a project, inflating the metric while signalling nothing about retention."

---

**What makes it strong:**
- Opens by grounding in the business outcome (renewal), not just user behaviour
- Proposes a specific metric with a precise definition
- Justifies why this metric instead of the obvious alternative
- Adds guardrails without being asked
- Explicitly names a trap and explains why it fails

**What weaker answers miss:**
- Just naming "engagement" without a denominator
- Choosing a metric that sounds plausible but is easy to game (e.g. tasks created, logins)
- Not connecting the metric to the business model (B2B SaaS renews by team, not individual)

---

## 2. Metric drop diagnosis

**Question:** "DAU on a consumer app dropped 18% this week compared to last week. Walk me through how you would investigate."

---

**Gold standard answer:**

> "Before I form any hypothesis, I need to verify the data is real.
>
> First: is the data pipeline working? Is the logging intact? I'd check whether other metrics also dropped proportionally — if total events dropped 18% but sessions only dropped 2%, that's a logging bug, not a real decline.
>
> Second: timing. Did anything change this week? Product releases, notification changes, app store updates. Is it a holiday week or an unusual calendar event that would shift usage patterns?
>
> If the data is real and there's no obvious timing event, I'd disaggregate the drop:
> - Platform: is it iOS, Android, or desktop? A platform-specific drop points to an app update or OS change.
> - User type: new users vs returning users. If new users dropped, it's an acquisition or activation problem. If returning users dropped, it's a retention or re-engagement problem.
> - Geography: concentrated in one region? Could point to a local event, a competitor launch, or a country-specific bug.
>
> Then I'd decompose DAU mathematically: DAU = (new users) + (retained users) + (resurrected users). Which component changed?
>
> Based on the disaggregation, I'd form a specific hypothesis: for example, 'returning iOS users dropped 30% after last Tuesday's app update, suggesting the update introduced a bug or removed a feature that affected re-engagement.'
>
> The next step: verify the hypothesis by looking at crash rates, session depth, and any feedback or ratings change around the update date."

---

**What makes it strong:**
- Data quality check is first, not buried later
- Timing before forming a hypothesis
- Multiple disaggregation cuts (platform, user type, geography)
- Mathematical decomposition (DAU = new + retained + resurrected)
- Closes with a specific, falsifiable hypothesis and a next step
- Does not conclude prematurely — "18% drop probably means users churned" is not a framework

**What weaker answers miss:**
- Starting with "maybe users are unhappy"
- Skipping data quality check
- Only checking one segment
- Not decomposing DAU mathematically
- Ending with a vague list of possibilities instead of a specific hypothesis

---

## 3. A/B test design

**Question:** "Design an experiment to test whether adding a progress bar to the onboarding flow increases activation rate."

---

**Gold standard answer:**

> "Hypothesis: if we add a progress bar to the onboarding flow, activation rate will increase because users who see their progress are less likely to abandon mid-flow — the Zeigarnik effect suggests people feel compelled to complete tasks once they've started.
>
> Randomisation unit: user, assigned at the start of the onboarding flow. We want consistency — a user who sees a progress bar on step 1 should see it on all subsequent steps.
>
> Primary metric: activation rate — the percentage of users who complete the defined activation event (let's say adding their first project) within 7 days of signup.
>
> Guardrails: D30 retention and paid conversion. An onboarding change could game activation with superficial completions that don't stick — guardrails catch this.
>
> Sample size: I need to know the baseline activation rate (say 28%), decide the MDE (I'd propose 3pp — the smallest lift we'd consider worth the engineering cost), alpha = 0.05, power = 0.80. This gives approximately 3,200 users per group. If we sign up 400 new users per day, that's 8 days of data minimum. I'd run 21 days to cover 3 weekly cycles.
>
> Launch criterion: ship if activation rate increases by ≥ 3pp and both guardrails are stable.
>
> Key risks: novelty (new users may engage with the bar out of curiosity early on — I'd check that the effect holds in weeks 2–3), and SRM (I'd check the assignment split on day 1).
>
> I'd also note: the activation event definition matters here. If we define activation too loosely, progress bar completion inflates the metric without creating genuinely retained users. Pre-agreeing on the activation definition is part of the experiment design."

---

**What makes it strong:**
- Hypothesis includes a specific mechanism (Zeigarnik effect)
- Randomisation unit justified, not just named
- Primary metric precisely defined with a time window
- Guardrails with mechanism (not just names)
- Full sample size calc with the four inputs and duration
- Pre-specified launch criterion
- Two specific risks with how each would be detected

**What weaker answers miss:**
- Hypothesis without a mechanism
- Not specifying what "activation" means
- Skipping the sample size calculation
- Not mentioning guardrails
- Not specifying a launch criterion

---

## 4. A/B test interpretation

**Question:** "Your experiment ran for 21 days. Primary metric: +2.1pp, p = 0.03. Secondary metric A: +0.8pp, p = 0.21. Secondary metric B: -1.4pp, p = 0.04. What do you do?"

---

**Gold standard answer:**

> "Let me work through this in order.
>
> First: the SRM check. I'd confirm the assignment split was close to 50/50. If not, these results are unreliable regardless of the p-values.
>
> Assuming the SRM is clean: the primary metric increased 2.1pp with p = 0.03. That passes the significance threshold. But I need to check two more things: is 2.1pp ≥ the pre-specified MDE? And was the primary metric specified before launch?
>
> Assuming both are yes — the primary metric passed.
>
> Now the problem: Secondary metric B declined 1.4pp with p = 0.04. This is statistically significant. Whether it is a guardrail or a secondary metric determines the decision:
>
> - If B was pre-specified as a guardrail: this is a hard stop. The feature improved the primary metric at the cost of something we said we must not degrade. I would not ship.
> - If B was a secondary metric: the degradation is a signal worth investigating, not an automatic veto. I'd look at the magnitude and whether there is a plausible mechanism for the harm.
>
> Secondary metric A is not significant (p = 0.21) and I would not treat that as evidence for or against shipping.
>
> My recommendation: if B is a guardrail — do not ship; investigate the B mechanism before any redesign. If B is a secondary — do not ship without understanding the B result; it represents a real signal even if not an automatic veto.
>
> What I would *not* do: declare a win because the primary passed and ignore B."

---

**What makes it strong:**
- SRM check before anything else
- Checks MDE and pre-specification of primary metric — not just p-value
- Clearly distinguishes guardrail vs secondary metric and what each implies
- Does not ignore the secondary result
- Does not claim secondary is fine just because it wasn't pre-specified
- Specific recommendation with condition, not a hedge

**What weaker answers miss:**
- Saying "it worked — p = 0.03 < 0.05, ship it"
- Ignoring secondary metric B entirely
- Not asking whether B was pre-specified as a guardrail
- Not mentioning practical significance (is 2.1pp ≥ MDE?)

---

## 5. SQL: explaining your approach

**Question:** "Walk me through how you would write a query to find the D7 retention rate for users who signed up last month."

---

**Gold standard answer:**

> "D7 retention is the percentage of users who were active on day 7 after signup — specifically, whether they had any activity exactly 7 days later (point-in-time), or within a window.
>
> I'd start by defining which users are in the cohort: those who signed up in the previous calendar month. Then for each of those users, I'd check whether they have any event between day 6 and day 8 after their signup date — or exactly day 7 depending on the definition.
>
> In SQL:
>
> ```sql
> WITH cohort AS (
>   SELECT user_id, signup_date
>   FROM users
>   WHERE signup_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')
>     AND signup_date <  DATE_TRUNC('month', CURRENT_DATE)
> ),
> retained AS (
>   SELECT DISTINCT c.user_id
>   FROM cohort c
>   JOIN events e ON c.user_id = e.user_id
>   WHERE e.event_time::date = c.signup_date + INTERVAL '7 days'
> )
> SELECT
>   COUNT(DISTINCT c.user_id) AS cohort_size,
>   COUNT(DISTINCT r.user_id) AS retained_count,
>   ROUND(100.0 * COUNT(DISTINCT r.user_id) / COUNT(DISTINCT c.user_id), 1) AS d7_retention_pct
> FROM cohort c
> LEFT JOIN retained r ON c.user_id = r.user_id;
> ```
>
> A few things I'd note: the LEFT JOIN ensures we count users who did not return — they show up in the denominator but not the numerator. I'd also flag that this is point-in-time retention (exactly day 7) not rolling retention (any day within week 1) — which definition you want depends on the context. And I'd double-check the signup_date definition in the users table to make sure it's the right event."

---

**What makes it strong:**
- Starts by clarifying the definition before writing any SQL
- Writes clean, readable SQL with CTEs
- Explains each CTE's purpose
- Explicitly notes the LEFT JOIN reason
- Flags the point-in-time vs rolling distinction
- Shows awareness of data quality (checking the signup_date definition)

**What weaker answers miss:**
- Writing a INNER JOIN that silently drops non-retained users from the denominator
- Not clarifying point-in-time vs rolling
- Not explaining the query structure before writing it

---

## 6. Causal inference without an A/B test

**Question:** "A new feature was rolled out to all users at once. Three months later, retention improved 8%. How would you determine whether the feature caused this?"

---

**Gold standard answer:**

> "This is a challenging causal question because there's no control group — the feature was rolled out to everyone simultaneously.
>
> The first thing I'd acknowledge: we cannot definitively establish causality without a comparison group. An 8% retention improvement over three months is consistent with the feature, but also with seasonality, a concurrent marketing campaign, cohort composition change, or general product improvements.
>
> That said, there are approaches that can provide partial evidence:
>
> **1. Pre/post with placebo check:** Compare retention before vs after the rollout — but also check whether metrics that should not be affected by this feature also changed. If everything improved simultaneously, there's likely a confounding factor.
>
> **2. Segment-based DiD:** If the feature was more used by certain user segments (e.g. power users who are more likely to discover it), compare power users vs casual users before and after. This is a difference-in-differences approach. The limitation: power users and casual users may have different trends for other reasons.
>
> **3. Usage-based comparison:** Compare users who adopted the feature vs users who did not. The problem: adopters self-select — they are likely more engaged to begin with. This will almost certainly overstate the feature's impact. I'd flag this explicitly and treat the result as an upper bound.
>
> **4. Synthetic control:** If you have multiple products or markets, construct a counterfactual from similar products/markets that did not change.
>
> My recommendation: present the pre/post finding as observational — 'retention increased 8% in the three months after rollout' — while being explicit that this cannot be attributed to the feature without a valid control group. Use the DiD or usage-based analysis to build a supporting case, but acknowledge the limitations. Design the next similar rollout as a staged experiment so you do not face the same question again."

---

**What makes it strong:**
- Immediately acknowledges the absence of a control group and what that means
- Does not pretend the 8% is causal
- Names three specific methods with their assumptions and limitations
- Explicitly names the selection bias in the usage-based approach
- Closes with a forward-looking recommendation (design the next rollout as an experiment)
- Does not refuse to answer — gives the most informative answer possible given the constraints

**What weaker answers miss:**
- Claiming "the feature caused the improvement because retention went up"
- Only describing A/B testing (which is not possible here)
- Proposing a method without naming its limitations
- Not recommending how to avoid the same problem in the future

---

*Practice using these formats in mock loops: [mock_interview_loops.md](mock_interview_loops.md)*
*Full question banks: [sql_questions.md](sql_questions.md), [ab_testing_questions.md](ab_testing_questions.md)*
*Cheatsheets: [../00_quick_reference/](../00_quick_reference/)*
