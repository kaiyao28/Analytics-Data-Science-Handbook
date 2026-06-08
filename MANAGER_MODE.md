# Manager Mode

A routing guide for analytics managers using this handbook to coach and review analyst and data scientist work.

---

## How to use this guide

Each section below describes a specific review situation. For each: what to look for, the questions to ask, and the red flags that need correction vs coaching.

---

## 1. Reviewing an analysis

Before reading the analysis, ask yourself: does the structure tell you immediately what decision this informs?

**Questions to ask when reviewing:**
- What decision does this analysis support? (If not clear from the opening, send it back.)
- Is the metric precisely defined — including denominator, time window and population?
- Did they check data quality before drawing conclusions?
- Is there a recommendation, or just findings?
- Are uncertainty and caveats quantified, not just listed?

**Red flags:**
| Flag | Coaching prompt |
|------|----------------|
| Findings without recommendation | "What should we do based on this?" |
| Metric named but not defined | "How exactly is this calculated?" |
| No data quality check | "How do you know the logging is intact?" |
| Many caveats, no decision | "If you had to choose one path, which would it be?" |
| Correlation stated as causation | "What would need to be true for X to cause Y?" |

**What good looks like:** Analysis opens with the recommendation, supports it with 2–3 key findings, quantifies uncertainty ("we're 80% confident the effect is between X and Y"), and ends with a specific next step.

Reference: [CHECKLISTS.md](CHECKLISTS.md) — "Before sharing results" checklist

---

## 2. Reviewing an A/B test readout

This is where the most common analytical failures show up. Use this structure.

**Questions to ask:**
- Was the primary metric pre-specified before launch?
- Did the team check for SRM before looking at any metric results?
- Is the effect size reported alongside the p-value?
- Were guardrail metrics checked — all of them?
- Is the recommendation actionable and specific?

**Red flags:**
| Flag | Coaching prompt |
|------|----------------|
| "p < 0.05, so it worked" | "Is the effect size ≥ the MDE? Is it practically significant?" |
| No SRM check | "How do we know the groups were comparable?" |
| Secondary metric win as the headline | "Was this the pre-specified primary metric?" |
| Guardrails not mentioned | "What guardrails were set? Did they all pass?" |
| "Let's run it a bit longer" | "What are we testing by extending? Is this peeking?" |

**What good looks like:** Recommendation first. SRM confirmed clean. Primary metric result with CI. All guardrails with status. Segment breakdown. Novelty check. Specific ship / no-ship / investigate decision.

Reference: [08_communication_and_decision_making/experiment_readout_template.md](08_communication_and_decision_making/experiment_readout_template.md)

---

## 3. Reviewing SQL logic

Don't review SQL for style — review it for correctness and silent failures.

**Questions to ask:**
- What are the units of the result? (users, sessions, events?)
- What does the JOIN type assume about the data?
- Does the query handle users with zero events, or does it silently exclude them?
- Are there edge cases: users who appear in both groups, duplicate events, null values?

**Red flags:**
| Flag | Coaching prompt |
|------|----------------|
| INNER JOIN where LEFT JOIN is needed | "What happens to users with no events?" |
| No deduplication on user-level analysis | "Can a user appear more than once in this table?" |
| Implicit date assumptions | "What timezone is event_time in? What's the cutoff?" |
| COUNT(*) instead of COUNT(DISTINCT user_id) | "Are we counting users or events?" |

**What good looks like:** Query uses CTEs, each doing one thing. Join type is explicit and justified. Edge cases handled or documented. A simple sanity check runs (e.g. total vs expected row count).

Reference: [02_sql_for_analytics/sql_patterns.md](02_sql_for_analytics/sql_patterns.md)

---

## 4. Assessing product sense

Product sense is not about knowing the "right answer" — it is about structured thinking under ambiguity.

**Questions to ask in a coaching review:**
- Did they clarify the question before answering it?
- Did they define the metric precisely, or just name it?
- Did they consider guardrails without being prompted?
- Did they end with a recommendation?

**Red flags:**
| Flag | Coaching prompt |
|------|----------------|
| "I'd look at engagement" | "What exactly would you measure? What's the denominator?" |
| Only primary metric, no guardrails | "What could get worse if we optimise for this?" |
| Generic north star ("revenue") | "How does this metric behave differently from a volume metric?" |
| No recommendation | "Based on this, what would you tell the PM to do?" |

**What good looks like:** Clarify the goal → define the primary metric precisely → name guardrails with mechanisms → identify a key segment to watch → close with a recommendation or condition.

Reference: [01_product_and_business_thinking/product_case_framework.md](01_product_and_business_thinking/product_case_framework.md)

---

## 5. Assessing communication quality

The test: could a busy PM read this and know immediately what to do?

**Checklist:**
- [ ] Recommendation is in the first two sentences
- [ ] Key numbers are translated into business terms, not just statistical ones
- [ ] Caveats are quantified, not just listed
- [ ] Next step is specific (not "further investigation may be required")
- [ ] No passive hedging ("could potentially suggest")

**Developmental feedback patterns:**

| If the analyst writes... | Coaching prompt |
|--------------------------|----------------|
| "There are several possible explanations..." | "Which one do you think is most likely, and why?" |
| "The p-value was 0.03" | "What does that mean for whether we should ship?" |
| "Further research is needed" | "What specific research? By when? What would it change?" |
| A five-page doc for a one-sentence decision | "What's the one-paragraph version?" |

Reference: [08_communication_and_decision_making/README.md](08_communication_and_decision_making/README.md)

---

## 6. Running a weekly analytics critique session

A critique session is not a code review. It is a structured discussion of analytical judgment.

**Format (45 minutes):**

1. **Author presents (5 min):** What question did you answer, what did you find, what did you recommend?
2. **Team questions (15 min):** Focus on methodology, assumptions and edge cases. No "what about Y instead?" — only questions, no suggestions.
3. **Structured feedback (15 min):** What was strong? What would you do differently?
4. **Author responds (5 min):** What would they change? What would they keep?
5. **Facilitator summary (5 min):** What is the team's standard for this type of analysis?

**Ground rules:**
- Criticise the analysis, not the analyst
- "Why did you approach it this way?" before "I would have done X"
- Focus on judgment gaps, not formatting preferences
- Every session ends with one team standard documented

**What to bring to a critique session:**
- An analysis where you made a judgment call you'd like input on
- A case where results were surprising or ambiguous
- A request you weren't sure how to scope

---

## 7. Junior-to-senior growth rubric

Use this to assess and develop analysts over time. Score 1–4 for each dimension.

| Dimension | 1 — Developing | 2 — Capable | 3 — Strong | 4 — Exceptional |
|-----------|---------------|------------|-----------|-----------------|
| **Problem framing** | Takes the question as given | Clarifies before starting | Reframes the question when needed | Shapes what question gets asked |
| **Metric quality** | Names metrics, doesn't define | Defines with denominator | Anticipates edge cases | Proposes a metric framework |
| **Data quality** | Checks if asked | Checks consistently | Catches issues others miss | Builds preventive checks |
| **Statistical judgment** | Applies methods by recipe | Understands trade-offs | Flags risks proactively | Advises others on method choice |
| **Decision quality** | Presents findings | Includes recommendation | Quantifies uncertainty | Frames for the decision-maker |
| **Stakeholder communication** | Reports back | Communicates clearly | Manages pushback | Influences the agenda |
| **Self-sufficiency** | Needs guidance on scope | Works within defined scope | Proposes scope | Defines scope for others |

**How to use this rubric:**
- Score before a 1:1 to calibrate your view
- Share the rubric with the analyst — self-assessment often differs from manager assessment in instructive ways
- Focus on the 1–2 dimensions that are limiting their impact, not all seven
- Revisit quarterly

---

## Key handbook files for managers

| Purpose | File |
|---------|------|
| Understanding career expectations | [CAREER_LEVELS.md](CAREER_LEVELS.md) |
| Reviewing analyses with a checklist | [ANALYSIS_REVIEW_CHECKLIST.md](ANALYSIS_REVIEW_CHECKLIST.md) |
| Understanding senior judgment gaps | [08_communication_and_decision_making/senior_judgement.md](08_communication_and_decision_making/senior_judgement.md) |
| Calibrating against gold standard answers | [10_interview_prep/gold_standard_answers.md](10_interview_prep/gold_standard_answers.md) |
| Common experiment failures | [03_statistics_and_experimentation/common_experiment_mistakes.md](03_statistics_and_experimentation/common_experiment_mistakes.md) |
| Stakeholder communication scenarios | [08_communication_and_decision_making/stakeholder_questions.md](08_communication_and_decision_making/stakeholder_questions.md) |
