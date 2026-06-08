# Handling Stakeholder Questions

These are the questions and pushback situations data scientists face most often. Each entry has the question, what the stakeholder usually actually means, and how to respond.

---

## "Can we just run the test a bit longer to see if it becomes significant?"

**What they mean:** The result was almost significant and they want to ship. They hope more data will push p below 0.05.

**What not to say:** "Sure, a few more days won't hurt."

**What to say:**
> "I understand the instinct, but extending after we've already peeked at the results changes the statistical properties. If we keep looking until we cross p = 0.05, we'll eventually get there by chance even if the feature has no real effect — this is called peeking, and it inflates our false positive rate significantly.
>
> The honest options are: (1) accept the null — this result doesn't meet the bar we set; (2) design a new experiment with a smaller MDE and a pre-specified end date. The second option is valid, but it's a new experiment, not an extension of this one."

---

## "The data must be wrong — I know this feature works."

**What they mean:** The result contradicts their expectation or intuition. They want you to find a bug that explains it away.

**What not to say:** "I'll check again" (without having verified it already).

**What to say:**
> "Let me walk you through the methodology so we can check together. [Walk through: data source, population filter, metric definition, time window, assignment mechanism.] The result is consistent across three independent checks.
>
> I'd like to understand what you're seeing that contradicts this. Sometimes stakeholders have information — a product change, a data quality issue, a segment behaviour — that the numbers don't capture yet. If there's something specific, let's investigate that. But based on what's here, the data is telling us [finding]."

Then: document that you checked. If they still disagree, escalate the methodology question, not the conclusion.

---

## "This is just a correlation — there must be a causal reason we're seeing this."

**What they mean:** They want you to explain the mechanism, not just report the number.

**This is a reasonable ask.** They're right that knowing why matters.

**What to say:**
> "Good point — let me share what the data suggests about mechanism. [Insert: segment breakdown that points to where the effect is concentrated, or timing evidence that connects to a product change.] This is consistent with the hypothesis that [mechanism], though to confirm causality we'd need [additional evidence or a test specifically designed to isolate that mechanism]."

Always distinguish what the data supports from what it implies but doesn't prove.

---

## "Why do we need an experiment? We already know users want this."

**What they mean:** The feature feels obviously good. Running a test feels like bureaucracy.

**What to say:**
> "I agree the directional hypothesis makes sense. But 'obviously good' features have hurt metrics before — usually because of a second-order effect we didn't anticipate. [Specific example if you have one: notifications, recommendations, something local.]
>
> An experiment gives us two things an intuition doesn't: (1) an actual measurement of how much it helps, which we need to prioritise against other work; (2) a safety check on guardrails. A two-week test with 1,000 users per group is a low cost for that confidence."

If they push back further: "What would it take to convince you it had a negative effect?" — this usually helps calibrate the real question.

---

## "But the result was positive in mobile — can't we ship there?"

**What they mean:** The overall result was null but one segment looks good. They want to cherry-pick the win.

**What to say:**
> "I understand the appeal, but the mobile segment result comes with a caveat: we didn't pre-specify mobile as the primary analysis unit. When you look at many segments after the fact, some will be significant by chance alone — at alpha = 0.05, 1 in 20 truly-null comparisons will appear significant.
>
> The right path is to run a new test targeted at mobile users specifically, with mobile as the pre-specified primary population. If the hypothesis is 'this feature works better on mobile,' that's a testable claim we can design a clean experiment for."

---

## "This is a small effect — why does it matter?"

**What they mean:** The lift looks small in percentage terms. They want to know if it's worth acting on.

**This is a legitimate question** — translate statistical into business terms:
> "3.1 percentage points sounds small, but at our current checkout traffic of 12,000 sessions per day, this represents approximately 370 additional purchases per day, or £2.1M annual revenue at our average order value. Whether that's worth the engineering cost is a business decision — but the magnitude is real."

If the answer is genuinely "not worth it," say that clearly:
> "You're right — at our current traffic, this 0.2pp improvement represents about 8 additional conversions per day. At average AOV this is around £18,000 annually. Given the implementation complexity, I'd agree this doesn't meet the bar for shipping."

---

## "Can you just send me the raw data?"

**What they mean:** They want to explore the data themselves, often because they don't trust the analysis or want a specific breakdown you haven't provided.

**What to say:**
> "Of course — I'll share the query and the underlying table. Before you explore it, there are two things worth knowing: [1. specific filter applied, e.g. 'this excludes bot traffic'; 2. metric definition, e.g. 'checkout completion is defined as purchase_completed events, not order initiated']. Happy to walk through the methodology so your exploration builds on the right foundation."

Sharing data and methodology is almost always the right move. Document what you shared and when.

---

## How to disagree respectfully

If a stakeholder pushes a conclusion the data does not support, the goal is to be helpful and honest — not to win.

The structure that works:
1. Acknowledge what they want and why it makes sense
2. State what the data actually shows
3. Offer the path forward that is both honest and useful

> "I understand the pressure to ship — the direction looks promising and the team has put a lot into this. What the data is telling us is [X]. I don't want to report a conclusion the analysis doesn't support, but I do want to help you move forward. Here's what I'd suggest..."

You are not the last line of defence against bad decisions. Your job is to give honest analysis and a clear recommendation. The decision owner decides.

---

*Communication templates: [../00_quick_reference/communication_templates.md](../00_quick_reference/communication_templates.md)*
*Experiment readout: [experiment_readout_template.md](experiment_readout_template.md)*
*Decision memo: [decision_memo_template.md](decision_memo_template.md)*
