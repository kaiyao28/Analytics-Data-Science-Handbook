# 08 · Communication and Decision Making

## Why this matters

An excellent analysis that is poorly communicated does not change decisions. Communication is not a soft skill — it is a core technical skill for data scientists. How you frame uncertainty, structure a recommendation and respond to stakeholder pushback directly determines whether your work has impact.

This section covers writing, framing and presenting analytical work to stakeholders. It also includes templates you can use directly.

---

## What you need to know

- How to write a clear data insight (not just a data finding)
- How to communicate uncertainty without undermining your recommendation
- How to write an experiment readout
- How to structure a decision memo
- How to respond when a stakeholder challenges your result
- How to explain "we do not know" constructively

---

## Open this if...

| You need to... | Go to |
|----------------|-------|
| Write an experiment readout right now | [../00_quick_reference/communication_templates.md](../00_quick_reference/communication_templates.md) |
| See a worked good vs weak write-up | [Practical example below](#practical-example) |
| Write a decision memo | `decision_memo_template.md` |
| Learn how to write a clear data insight | `insight_writing.md` |
| Handle stakeholder pushback | `stakeholder_questions.md` |

---

## Core concepts

**Pyramid principle** — start with the conclusion, then support it with evidence. Technical people tend to write chronologically: here is what I did, here is what I found. Stakeholders prefer the inverse: here is what you should do, here is why. Lead with the answer.

**Confidence, not certainty.** Data analysis rarely produces certainty. The job is to reduce uncertainty and quantify what remains. Present ranges, not just point estimates. Say "we are 95% confident the effect is between X and Y" not "the effect is Z."

**Separating fact from interpretation.** "Conversion dropped 15%" is a fact. "Users found the new flow confusing" is an interpretation. Never present interpretations as facts — flag them as hypotheses.

**The recommendation.** Every analysis should end with a specific, actionable recommendation. "It depends" is rarely acceptable as a final answer. If it genuinely depends, state what it depends on and give a recommendation for each scenario.

---

## Practical example

**Weak experiment write-up:**
> "We ran the A/B test for three weeks. The treatment group had a conversion rate of 4.5% vs 4.0% for control. The p-value was 0.03."

**Better experiment write-up:**
> "The redesigned checkout increased conversion by 0.5 percentage points (4.0% → 4.5%), a 12.5% relative improvement. The result is statistically significant (p = 0.03) and consistent across mobile and desktop. Guardrail metrics (refund rate, support contacts) were stable. Estimated annual revenue impact: £1.2M at current traffic.
>
> **Recommendation: ship.**"

The second version answers the question the stakeholder actually has: *should we ship it?*

---

## Common mistakes

**Burying the recommendation.** Putting it at the end of a long document means busy stakeholders stop reading before they reach it. Lead with the recommendation.

**Reporting p-values without translation.** Most stakeholders do not know what p = 0.03 means. Translate: "we are confident this result is not random, and the magnitude of the improvement is commercially meaningful."

**Hedging until the recommendation disappears.** "This could suggest that perhaps..." communicates nothing. Quantify your uncertainty and then give a clear directional recommendation.

**Not anticipating objections.** Think about what the stakeholder will push back on and address it before they ask. It demonstrates rigour and saves time.

**Confusing outputs with outcomes.** "We ran 12 experiments this quarter" is an output. "Checkout conversion improved by 15% this quarter" is an outcome. Report outcomes.

---

## How to respond to "the data must be wrong"

This is a common and important situation. A stakeholder disagrees with your result. Steps:

1. **Stay curious, not defensive.** Ask what they are seeing that contradicts the data. They may know something you do not.
2. **Check the data together.** Walk through your methodology step by step. Is there a metric definition disagreement? A population filter issue?
3. **Separate disagreement about data from disagreement about interpretation.** "The number is wrong" and "I interpret it differently" are different problems.
4. **If the data is correct, hold your position respectfully.** "I've checked this three ways and the result is consistent. Here's what would need to be true for the conclusion to be different."

---

## Interview relevance

Communication is assessed in every senior analytics DS interview through case questions:

- "Walk me through how you would present this result to a VP"
- "The experiment result is inconclusive. How do you communicate that?"
- "The PM disagrees with your recommendation. What do you do?"

The best answers separate fact from interpretation, quantify uncertainty and give a clear recommendation while being honest about its limitations.

---

## Exercises

1. Rewrite this finding using the pyramid principle: "We looked at the last 90 days. Retention is declining. We checked multiple segments. The decline is concentrated in paid-channel users. Paid-channel users have lower day-30 retention (22%) than organic users (41%). We think the issue might be related to ad targeting."
2. Write a one-paragraph experiment readout for a test where p = 0.18 and the direction is positive but not statistically significant.
3. A stakeholder says "this feature definitely works — everyone on the team loves it." How do you respond?

---

## Files in this folder

| File | Topic |
|------|-------|
| `insight_writing.md` | How to write data insights: structure, examples, common mistakes |
| `experiment_readout_template.md` | Structured template for communicating experiment results |
| `decision_memo_template.md` | One-page format for framing a product decision |
| `stakeholder_questions.md` | How to handle difficult stakeholder questions and pushback |
| `executive_summary_examples.md` | Worked examples of clear, concise executive summaries |

---

## Next

[09_case_studies](../09_case_studies/README.md) — apply everything end to end through realistic product problems.
