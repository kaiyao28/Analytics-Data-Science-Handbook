# Product Sense Interview Questions

---

## What interviewers are testing

- Can you translate a vague product question into a precise metric?
- Do you think about guardrails without being prompted?
- Do you define the population and time window, not just the metric name?
- Can you reason about trade-offs between competing metrics?
- Do you end with a recommendation, not just a list of ideas?

## Answer framework

Use the product case framework for every question:
1. Clarify the question and context
2. State the product goal
3. Define the primary metric (specific, with denominator)
4. Add input and guardrail metrics
5. Name a key segment to monitor
6. Close with a recommendation or decision rule

---

## Questions

### Q1 — Defining a north star

**Question:** What would you choose as the north star metric for a subscription music streaming app? Justify your choice.

**What it tests:** understanding of north star criteria, product intuition.

**Strong answer structure:**
- State the criteria: reflects user value, predicts retention and revenue, aligns the team
- Propose: "Monthly hours listened per subscriber"
- Justify: this captures depth of engagement, not just logins; predicts churn better than session count; aligns product, growth and eng on the same number
- Name what it would miss and what guardrail handles it (e.g. listening minutes could be inflated by background autoplay — add active skip rate or track completion rate as a quality guardrail)

---

### Q2 — Measuring a new feature

**Question:** A social app launched a "stories" feature last month. How would you measure whether it is working?

**What it tests:** multi-metric thinking, population definition, guardrails.

**Strong answer structure:**
- Clarify: what does "working" mean to the team? Engagement? Acquisition? Retention?
- Primary metric: % of daily active users who post ≥1 story per week (creator engagement)
- Secondary: stories views per session, follower growth for active story creators
- Guardrails: existing feed engagement (we do not want stories to cannibalise the feed), app session depth, D30 retention
- Segment: new users (stories as an onboarding/discovery tool) vs existing users (stories as an engagement driver) — these may need separate metrics

---

### Q3 — Choosing between two metrics

**Question:** A growth team is debating whether to track "users who signed up" or "users who completed onboarding" as their primary metric. What would you recommend?

**What it tests:** understanding of input vs output metrics, activation, leading indicators.

**Strong answer:**
- "Users who signed up" measures acquisition volume — easy to move with ad spend, but does not predict whether users will become valuable
- "Users who completed onboarding" measures qualified activation — harder to inflate artificially, more predictive of retention and paid conversion
- Recommendation: use onboarding completion as the primary growth metric, and track signups as a leading funnel metric. But define "completed onboarding" precisely — what action counts?

---

### Q4 — Diagnosing a metric drop in an interview

**Question:** DAU on a mobile game dropped 15% over three weeks. Walk me through how you would investigate.

**What it tests:** metric change diagnosis framework (same as the case interview format 1).

**Strong answer:** Use the 7-step framework from [case_interview_framework.md](case_interview_framework.md).

Key points to hit: data quality check first, timing and correlated events, segmentation by platform and user type, decompose (is it new user acquisition or returning user retention?), form a hypothesis.

---

### Q5 — Guardrail metrics

**Question:** Your team is about to run an experiment to increase notification click rate. What guardrail metrics would you set?

**What it tests:** understanding of second-order effects, safety-net thinking.

**Strong answer:**
- Notification opt-out rate — if CTR rises because notifications are annoying, opt-outs will follow
- App uninstall rate — extreme annoyance leads to uninstalls
- Session depth post-notification — are users who click actually engaging, or immediately closing?
- Day-30 retention — notification over-sending can hurt long-term engagement
- Spam report rate (if the platform tracks this)

**Key point:** Higher CTR achieved through irrelevant or excessive notifications destroys long-term value. Guardrails catch this.

---

### Q6 — Funnel analysis question

**Question:** An e-commerce app's checkout completion rate is 45%. The PM wants to improve it. How would you analyse the funnel and identify where to focus?

**What it tests:** funnel analysis thinking, prioritisation, SQL intuition.

**Strong answer structure:**
- Define the funnel: product view → add to cart → checkout started → payment entered → order confirmed
- Measure conversion at each step — both step-to-step and overall
- Identify the step with the largest absolute user drop-off (not just lowest percentage)
- Segment each step by: platform (mobile vs desktop often differs dramatically), user type (guest vs signed-in), acquisition channel
- Form a hypothesis about the biggest drop: e.g. "payment entry to order confirmed loses 30% — likely payment failure or security friction"
- Propose a specific next investigation: payment error breakdown, field-level drop-off in the payment form

---

### Q7 — "Should we shut this feature down?"

**Question:** A feature has been live for six months and engagement is low — only 5% of users have used it. The PM wants to shut it down. What analysis would you do before deciding?

**What it tests:** nuanced thinking beyond a single metric, retention/revenue contribution.

**Strong answer structure:**
- Do not conclude from usage rate alone — 5% of users could be a meaningful segment
- Check: who are the 5% using it? Are they high-value users (high retention, high LTV)?
- Check: is the feature used repeatedly or only once (one-off utility vs habit)?
- Check: what happens to retention or revenue when users stop using it? (Causal question — observational only, flag the limitation)
- Check: was the feature properly surfaced? Discovery problem vs value problem
- Recommendation: if the 5% are disproportionately high-value users and the feature is retained, do not shut it down. If usage is flat, non-sticky, and the users are no different from non-users, consider sunsetting it.

---

### Q8 — Trade-off between metrics

**Question:** An experiment shows that showing more ads increases revenue by 8%, but D30 retention drops by 2pp. Should we ship?

**What it tests:** trade-off reasoning, long-term vs short-term thinking.

**Strong answer structure:**
- This is a genuine trade-off — do not pretend there is an obvious right answer
- Quantify: what is the LTV impact of a 2pp retention drop vs the 8% revenue gain?
- If LTV impact of retention loss > revenue gain: do not ship
- If revenue gain > LTV impact: possibly ship, but treat with caution and monitor long-term
- Consider: is the retention drop from all users or a specific segment? Could a more targeted ad strategy preserve revenue while protecting retention?
- Close: "I would not ship until we have modelled the LTV impact of the retention drop. A headline revenue uplift without that context is not enough to make the decision."

---

## Common mistakes

- Proposing a metric without specifying the denominator
- Forgetting guardrail metrics in any experiment design question
- Not ending with a recommendation
- Giving a metric name ("retention") without a definition ("% of users active 30 days after signup")

---

*Framework: [../01_product_and_business_thinking/product_case_framework.md](../01_product_and_business_thinking/product_case_framework.md)*
*Quick cheatsheet: [../00_quick_reference/product_metrics_cheatsheet.md](../00_quick_reference/product_metrics_cheatsheet.md)*
