# Senior Judgment

The skills that separate senior analytics data scientists from capable mid-level analysts are mostly not statistical. They are about framing, communication and knowing when to push back.

---

## Junior vs senior framing

| Situation | Junior response | Senior response |
|-----------|----------------|-----------------|
| Given a metric to measure | Measures it | Asks "why this metric and not X?" before measuring |
| Experiment is inconclusive | Reports null result | Explains what the null result does and does not mean; recommends next step |
| PM wants to ship despite weak evidence | Flags the risk | Explains the specific risk, quantifies it, and proposes a monitoring plan that makes shipping safer |
| Two metrics conflict | Reports both | Identifies which conflict matters, models the trade-off, recommends |
| Stakeholder disagrees with finding | Rechecks the analysis | Separates data disagreement from interpretation disagreement; holds position with evidence |
| No clear answer exists | Says "we don't know" | Says "we don't know, and here is what we'd need to find out — here's my best guess in the meantime" |

---

## How to challenge the question respectfully

The most common senior mistake is answering the wrong question brilliantly. The most common junior mistake is not questioning the question at all.

**The challenge formula:**

> "Before I start — I want to make sure we're answering the right question. The question as stated is [X]. I'd like to understand: what decision will this analysis support? Because if the decision is [Y], we might want to measure [Z] instead, which would be more directly tied to that outcome."

**When to use it:**
- The metric you've been asked to measure is a proxy with known problems
- The question is framed around output rather than outcome
- The analysis scope seems wrong for the decision being made

**When NOT to challenge:**
- You have no better alternative
- The question is strategically decided and you're being asked for execution
- The challenge would be a delay, not an improvement

---

## How to handle ambiguous requests

Ambiguous requests are a test of seniority. The junior response is to either ask clarifying questions indefinitely or to start immediately without clarifying.

**The senior approach:**

1. Write down your interpretation of what is being asked
2. Write down what you will deliver
3. Share this before starting: "I'm going to interpret this as [X] and deliver [Y]. Is that right, or is there a different priority?"

This forces alignment without slowing things down. It also protects you: if the scope was wrong, you identified it before investing time.

**For genuinely ambiguous goals:**

> "There are two versions of this question. Version A is [short-answer version] and I can have that in two hours. Version B is [comprehensive version] and would take two days. Given [context], I'd recommend Version A first — does that work?"

---

## How to push back on a weak metric

Weak metrics are metrics that are easy to move but do not represent genuine user value. They are the most common way teams optimise for the wrong thing.

**Signs of a weak metric:**
- Can be improved artificially without helping users (e.g. clicks, page views)
- Measures activity, not value (e.g. session count vs task completion)
- Is easy to game by the feature being tested
- Does not predict the business outcome the team cares about

**How to push back:**

> "I want to flag a concern about the primary metric. [Metric] can be moved in ways that don't benefit users — for example, [specific mechanism]. If we ship based on this and [outcome] doesn't improve, we'll have shipped something that looks like a win but isn't. Could we add [better metric] as a co-primary, or measure [outcome proxy] as the north star?"

**When to stand firm:**

If the metric is genuinely weak and a better one exists, hold the position even if it's uncomfortable. A wrong metric decision has consequences that outlast the conversation.

---

## Communicating uncertainty without sounding indecisive

The failure mode is either false certainty ("this will definitely work") or paralysis ("there are too many unknowns to recommend anything").

**The formula for confident uncertainty:**

> "My best estimate is [X]. I'm [high/medium/low] confidence because [reason]. The main risk is [Y]. If [Z] happens, that changes the recommendation."

**Worked example:**

Weak: "Retention could go up or down depending on various factors, and we'd need more data to be sure."

Strong: "My best estimate is that retention improves by 1–2pp based on the segment analysis. I'm medium confidence — the signal is consistent but the sample in the test cohort was small. The main risk is that the improvement is novelty-driven, which would mean it decays by month 2. I'd recommend shipping and monitoring D60 retention."

**The test:** After reading your recommendation, would a non-technical PM know exactly what you think should happen, and why you might be wrong?

---

## How to recommend against launching

This is one of the most important senior skills and one of the hardest to practice. Teams want to ship. Recommending against it feels like slowing things down.

**The structure:**

1. Name what is good about the result (do not start with the negative)
2. Name specifically what the evidence shows and does not show
3. State what the risk of shipping is, and how large it is
4. Offer a path forward that isn't "wait indefinitely"

> "The primary metric improved meaningfully and I understand the team wants to ship. The issue is [specific problem — SRM, guardrail, underpowered test]. Shipping on this would mean [specific risk]. I'd recommend [specific alternative: rerun with fix, monitor guardrail for 2 weeks, redesign the specific element that caused the guardrail]. That delays shipping by [X] but reduces the risk of [outcome]."

**Common no-ship situations:**

| Situation | What to say |
|-----------|-------------|
| SRM detected | "The groups weren't comparable, so any metric result could be wrong. We need to fix the assignment mechanism and rerun." |
| Guardrail fired | "The primary metric improved but [guardrail] degraded significantly. The net effect on user health or revenue is unclear — possibly negative." |
| Underpowered null | "The null result doesn't tell us the feature doesn't work. It tells us the test wasn't sensitive enough to detect it. If we ship, we're making the decision on incomplete evidence." |
| Novelty effect | "The week 1 lift is real but decayed to near-zero by week 3. Shipping based on week 1 data would likely produce no long-term improvement." |

---

## How to prioritise analysis requests

Senior analysts are asked for more than they can deliver. Prioritisation is a judgment call, not just a task queue.

**The prioritisation framework:**

1. **Decision urgency:** Is there a decision being made in the next 48 hours that needs this?
2. **Decision reversibility:** Is this a one-way or two-way door? High-reversibility decisions need less analysis.
3. **Evidence gap:** Would more analysis materially change the decision? If the team will ship regardless, analysis is low-value.
4. **Analytical leverage:** Can a two-hour version get 80% of the value of a two-day version?

**How to say no (or not yet):**

> "I want to make sure we get to the right answer here. My current priority is [X] which is time-sensitive. I can either do a quick version of your request by [date] or a thorough version by [later date]. Which is more useful?"

Do not say "I'll add it to the queue" without giving a specific date. That is not a real answer.

---

## Mini exercises

1. A PM sends this message: "Can you measure how much our new feature is increasing engagement?" Write the clarifying response you would send before starting any analysis.

2. An experiment shows p = 0.07. The PM says: "That's basically significant — let's ship." Write the response that holds the position without being dismissive.

3. Your analysis shows that a proposed new metric (story_views) is weakly correlated with retention (r = 0.12). The feature team wants to use it as their north star. Write the pushback.

4. A stakeholder asks for "a deep dive on churn" with no other context. Write your scoping message.

---

*Career levels: [../CAREER_LEVELS.md](../CAREER_LEVELS.md)*
*Stakeholder pushback scenarios: [stakeholder_questions.md](stakeholder_questions.md)*
*Checklist for analysis review: [../ANALYSIS_REVIEW_CHECKLIST.md](../ANALYSIS_REVIEW_CHECKLIST.md)*
