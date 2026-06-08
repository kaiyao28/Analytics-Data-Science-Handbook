# Product Metrics Cheatsheet

---

## Metric types at a glance

| Type | Definition | Example | When to use |
|------|-----------|---------|------------|
| Output metric | Measures business results | Revenue, DAU, paid conversions | Monitoring, goal-setting |
| Input metric | Measures actions that lead to results | Lessons completed, searches | Day-to-day optimisation |
| Leading indicator | Predicts future outcomes | Day-3 retention | Early signal, actionable |
| Lagging indicator | Confirms past outcomes | Annual revenue, LTV | Strategic measurement |
| Guardrail metric | Must not degrade | Refund rate, uninstall rate | Experiment safety net |

---

## North star by product type

| Product type | North star candidate | Why |
|-------------|---------------------|-----|
| Streaming (music/video) | Monthly hours consumed | Captures depth of engagement |
| Marketplace | Successful transactions | Measures two-sided value creation |
| Learning app | Learners completing first module | Predicts habit formation |
| Messaging | Messages sent between real connections | Filters out spam, captures real use |
| B2B SaaS | Weekly active teams | Reflects team-level adoption |
| E-commerce | Repeat purchase rate | Captures loyalty, not just acquisition |

A north star fails if it can be improved without improving user value.

---

## Guardrail examples by experiment type

| Optimising for | Guardrail metrics |
|----------------|------------------|
| Activation rate | Day-30 retention, app uninstall rate |
| Notification click rate | Opt-out rate, session depth |
| Checkout conversion | Refund rate, support contact rate |
| Engagement (sessions) | Retention, satisfaction score |
| Ad revenue | Time in app, content consumption quality |

---

## Five questions before choosing a metric

1. Does it measure actual user value or just activity?
2. Is the denominator unambiguous?
3. Is it sensitive enough to detect meaningful changes?
4. Can it be gamed? (What is the guardrail?)
5. Is the whole team aligned on the definition?

---

## Common mistakes

- Using page views or installs as success metrics — they do not predict outcomes
- "Active user" without a definition — what action makes someone active?
- Optimising an input metric that is not actually validated against the output metric
- Changing the metric definition mid-analysis

---

*Full detail: [../01_product_and_business_thinking/metrics.md](../01_product_and_business_thinking/metrics.md)*
