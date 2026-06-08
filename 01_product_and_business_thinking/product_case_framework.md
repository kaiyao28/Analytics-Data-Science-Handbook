# Product Case Framework

## Why it matters

Open-ended product questions are among the most common formats in analytics DS interviews — and among the most revealing in real work. The difference between a weak and strong answer is almost never about domain knowledge. It is about structure: defining the problem before proposing a solution, separating metric choice from method choice, and always ending with a recommendation.

---

## When to use this framework

- "How would you measure the success of [feature]?"
- "A metric is declining. How do you investigate?"
- "Should we launch this feature?"
- "Design an experiment for [change]."
- "What is the north star metric for [product]?"

---

## The six-step framework

### Step 1: Clarify the question

Before answering, ask:
- What product are we talking about? (If not specified, state your assumption)
- Who are the users? (New users? Power users? A specific segment?)
- What stage is the product at? (New feature? Mature? Declining?)
- What decision does this analysis need to support?
- What constraints exist (time, data availability)?

In an interview, clarifying for 60 seconds before answering is a signal of good judgment, not stalling.

---

### Step 2: Define the goal

State the business or product goal the analysis serves.

> "The goal is to evaluate whether the new onboarding flow increases the proportion of new users who reach activation within 7 days of signup."

This step forces you to think about *what outcome the team cares about* before jumping to a metric.

---

### Step 3: Define the metrics

Choose exactly:
- **One primary metric**: the single number that answers the core question
- **Secondary metrics**: supporting signals that add context
- **Guardrail metrics**: what must not get worse

Defining metrics before the analysis is a discipline, not a formality. Choosing the metric after seeing results is p-hacking.

---

### Step 4: Define the population and time period

- Which users are in scope? (New users only? All users? Mobile only?)
- What is the relevant time period?
- What should be excluded? (Test accounts, internal users, bot traffic, users from countries without the feature)

A metric defined without a population is ambiguous. "Conversion rate is 12%" means nothing without knowing whose conversion rate and in which time window.

---

### Step 5: Choose the analysis approach

- Is this an experiment (A/B test) or an observational analysis?
- What SQL or Python will extract the data?
- What statistical method answers the question? (t-test, proportion test, regression, DiD)
- What is the minimum detectable effect, and is the expected sample size sufficient?

---

### Step 6: Interpret and recommend

- What does the result mean in product terms?
- Is the effect practically significant, not just statistically significant?
- What is the specific recommendation?
- What uncertainty remains, and how does it affect the recommendation?

---

## Applied example

**Question:** Should we launch the redesigned mobile checkout?

| Framework step | Answer |
|----------------|--------|
| Clarify | Mobile e-commerce checkout. All users who start checkout. Decision: ship or iterate. |
| Goal | Increase checkout completion rate without increasing refund rate |
| Primary metric | Checkout completion rate (purchases completed / checkout sessions started) |
| Guardrail metrics | Refund rate, customer support contacts per order |
| Population | All users who started a checkout session during the test period, mobile app only |
| Approach | A/B test, 3-week duration, 15,000 per group, alpha = 0.05, power = 0.80 |
| Recommendation | Ship if primary metric improves ≥ 0.3pp AND guardrails stable |

---

## Weak vs strong answer

**Question:** How would you measure the success of a new follow-suggestions feature on a social app?

**Weak answer:**
> "I would look at engagement metrics and see whether users are following more people."

Why weak: no defined metric, no population, no time window, no guardrails, no recommendation criteria.

**Strong answer:**
> "The goal is to get new users to follow enough people that their feed is worth returning to — that is the core value hypothesis of the feature. I would define the primary metric as: proportion of new users who follow at least 5 people within 7 days of signup.
>
> Secondary metrics: number of connections made per new user, day-7 session depth (are they reading the feed?).
>
> Guardrail: feed engagement rate for existing users. If their feed gets polluted by low-quality suggestions, engagement may drop.
>
> I would run an A/B test on new users only (existing users already have connections), pre-specify 10% relative lift as the MDE, and measure at 4 weeks to account for novelty effect. If the primary metric improves and guardrails are stable, the recommendation is to ship."

Why stronger: specific metric with a clear denominator, time window defined, guardrail identified, experiment designed, recommendation criteria stated.

---

## Common mistakes in product case answers

**Jumping straight to a metric.** Define the goal first. The metric is a consequence of the goal, not a starting point.

**No guardrail metrics.** Every metric can be gamed or can improve at the cost of something else. Always name the guardrail.

**Vague population.** "Users" is not enough. Specify new vs existing, platform, market, and time period.

**Not ending with a recommendation.** Even if the scenario is hypothetical, close with: "If X is true, I would recommend Y."

---

## Mini exercise

You are the analytics DS for a B2B SaaS product. A new team collaboration feature was launched last month.

Using the six-step framework, write out your full answer to:

> "How would you evaluate whether the new collaboration feature is working?"

Target: one page, structured using the six steps above.

---

*See also: [metrics.md](metrics.md) · [metric_change_diagnosis.md](metric_change_diagnosis.md) · [../03_statistics_and_experimentation/ab_testing.md](../03_statistics_and_experimentation/ab_testing.md)*
