# Decision Memo Template

A decision memo answers one question: **what should we do, and why?** It is not an analysis write-up. Keep it to one page.

---

## [Template]

```
## [Decision title]

**Date:** [YYYY-MM-DD]
**Author:** [name]
**Decision owner:** [name or team]

---

### The decision

[One sentence: what action is being decided?]

Example: "Should we ship the new checkout flow to 100% of users?"

---

### Context

[2–3 sentences: what led to this decision being needed? What changed?]

---

### Options considered

| Option | Description | Key trade-off |
|--------|-------------|---------------|
| A — Ship | Roll out to 100% of users | Higher conversion; small latency increase |
| B — Partial rollout | Ship to mobile users only | Lower risk; requires separate mobile analysis |
| C — Do not ship | Revert to current state | No regression risk; no improvement |

---

### Recommendation

**[Option X]** — [one-sentence rationale]

Supporting data:
- [primary metric result or finding]
- [guardrail status or key risk addressed]
- [any additional supporting evidence]

---

### Risks and monitoring

| Risk | Likelihood | Mitigation |
|------|-----------|-----------|
| [risk 1] | Low / Medium / High | [action] |
| [risk 2] | Low / Medium / High | [action] |

**If this goes wrong:** [what you would do, and how quickly you would detect it]

---

### Open questions

- [Any question that must be answered before shipping, if applicable]

---

### Sign-off

| Role | Person | Status |
|------|--------|--------|
| Data | [name] | Approved |
| Product | [name] | Pending |
| Engineering | [name] | Pending |
```

---

## What makes a strong memo

**Lead with the recommendation.** The decision owner does not have time to read to the end. Put what you recommend on line one.

**Name the options explicitly.** Even if one option is obviously wrong, naming it shows you considered it and builds trust.

**Quantify the trade-offs.** "Slightly higher latency" is weak. "P95 latency increased 8ms (2.5% relative)" is strong.

**Write the monitoring plan before you ship.** If something goes wrong, you want to know within days, not weeks. The memo should name the metric, the threshold, and who watches it.

---

## Weak vs strong recommendation

**Weak:**
> "Based on the experiment results, the new checkout button performed well. There are trade-offs to consider. We recommend moving forward with caution."

**Strong:**
> "Recommendation: ship to 100%. The checkout button redesign increased conversion by 3.1pp (p = 0.003), exceeding the pre-specified MDE of 2.5pp. Guardrails (refund rate, support contacts) were stable. Estimated annual revenue impact is £1.1M at current traffic. Risk: P95 latency increased 8ms — engineering will monitor for one week post-launch."

The strong version answers: what to do, why, what the downside is, and how you will catch it if it goes wrong.

---

*Quick-paste templates: [../00_quick_reference/communication_templates.md](../00_quick_reference/communication_templates.md)*
*Experiment readout: [experiment_readout_template.md](experiment_readout_template.md)*
