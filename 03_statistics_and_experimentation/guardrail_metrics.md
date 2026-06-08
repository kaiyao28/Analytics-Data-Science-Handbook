# Guardrail Metrics

Guardrail metrics protect against shipping changes that look good on the primary metric but cause harm elsewhere. Defining them before launch — and checking them at the end — is one of the clearest marks of rigorous experiment practice.

---

## What a guardrail metric is

A guardrail is a metric that must not degrade as a result of the experiment. It is not the thing you are trying to improve; it is the thing you are trying to protect.

A feature that improves its primary metric but degrades a guardrail is not a win. The ship decision should require guardrails to be stable or positive.

---

## Why guardrails are not optional

Product metrics have second-order effects. A change that makes one number go up often affects something else downstream:

| Primary metric optimised | Likely second-order risk |
|--------------------------|--------------------------|
| Notification click rate | Opt-outs, uninstalls, D30 retention |
| Checkout conversion | Refund rate, support contacts |
| Session count | Session depth, D30 retention |
| Paid conversion | Average order value, D60 retention |
| Feature adoption | Engagement with related features |

Without guardrails, these harms go undetected until they show up in the north star — months later and much harder to attribute.

---

## How to choose guardrails

A good guardrail is:
1. **Directionally meaningful** — if it moves negatively, that represents real harm to users or the business
2. **Sensitive enough to detect moderate harm** within the experiment window
3. **Not redundant with the primary metric** — it should capture something the primary metric does not

### Selecting guardrails by experiment type

**Onboarding / activation experiments:**
- D7 and D30 retention
- Revenue per user in the first 30 days
- Paid conversion rate

**Engagement experiments (sessions, DAU, time spent):**
- D30 and D90 retention
- Session depth (pages per session, actions per session)
- Notification opt-out rate (if notifications are involved)

**Notification experiments:**
- Opt-out rate
- App uninstall rate (for mobile)
- Session depth post-click (are users who click actually engaging?)
- Spam report rate

**Checkout / payment experiments:**
- Refund rate
- Support contact rate
- Order completion rate (downstream of checkout)

**Content / feed ranking experiments:**
- Diversity / repeat creator consumption
- Report and block rates
- D30 retention

---

## What to do when a guardrail fires

A guardrail "fires" when it degrades significantly in the treatment group.

**Step 1: Confirm it is real.** Run the same statistical test you would for any metric. Is the degradation significant? How large is the confidence interval?

**Step 2: Investigate the mechanism.** Why would this feature cause this guardrail to degrade? Is there a causal story, or could this be noise?

**Step 3: Decide on a path forward.** Options:

| Situation | Action |
|-----------|--------|
| Primary metric up, guardrail clearly down | Do not ship. The experiment revealed a harmful trade-off. |
| Primary metric up, guardrail borderline | Segment the guardrail to understand who is affected. Consider a partial rollout. |
| Primary metric up, guardrail neutral | Ship, with monitoring plan. |
| Primary metric null, guardrail down | Definitely do not ship. |

**Never:** ignore a guardrail degradation because the primary metric looks good. Document it in the readout regardless.

---

## Example: Guardrail analysis from a real experiment readout

Experiment: new checkout payment form (from [ab_testing.md](ab_testing.md))

| Metric | Control | Treatment | Delta | p-value | Decision |
|--------|---------|-----------|-------|---------|----------|
| Checkout completion (primary) | 32.1% | 35.2% | +3.1pp | 0.003 | Ship signal |
| Refund rate (guardrail) | 4.8% | 5.1% | +0.3pp | 0.28 | Stable — not significant |
| Support contacts / order (guardrail) | 0.12 | 0.13 | +0.01 | 0.41 | Stable |
| Latency P95 ms (guardrail) | 310ms | 318ms | +8ms | 0.09 | Monitor |

Recommendation: ship. Primary metric improved beyond MDE. Guardrails stable. Latency slightly elevated but not significant — add to monitoring dashboard.

---

## The guardrail vs the secondary metric

**Guardrail:** a metric that must stay stable. It constrains the ship decision. A degradation is a hard stop.

**Secondary metric:** a metric that provides context. Its behaviour is informative but not decisive. It cannot override a primary metric failure, and a secondary win does not justify shipping when the primary metric is null.

---

## Interview answer structure

For "What guardrails would you set for this experiment?":

1. Name two or three specific metrics (not vague categories)
2. Explain why each one is at risk from this particular change
3. State what degradation looks like (direction + rough magnitude)
4. State what you would do if a guardrail fired

**Weak:** "I'd watch for any negative side effects."
**Strong:** "I'd set notification opt-out rate and D30 retention as guardrails. If we're trying to increase notification CTR with more urgent messaging, opt-outs are the most direct risk — if users find them annoying, they'll turn off notifications entirely, which destroys long-term re-engagement. D30 retention is a backstop for any harm that doesn't show up in the short term."

---

## Mini exercise

A social media team is running an experiment to increase likes per post. Propose:

1. Three guardrail metrics and the mechanism that puts each at risk.
2. A concrete definition for each guardrail (not just the name — include numerator, denominator).
3. What would you do if likes/post increased 12% but the "report content" rate also increased 8% (p = 0.02)?

---

*Back to overview: [ab_testing.md](ab_testing.md)*
*Common mistakes: [common_experiment_mistakes.md](common_experiment_mistakes.md)*
*Cheatsheet: [../00_quick_reference/ab_testing_cheatsheet.md](../00_quick_reference/ab_testing_cheatsheet.md)*
