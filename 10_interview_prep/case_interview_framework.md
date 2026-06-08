# Case Interview Framework

A step-by-step guide for the three most common analytics DS case question formats.

---

## Format 1: "A metric dropped X%" (diagnosis case)

This is the most common case question. It tests structured thinking and data intuition.

### Step-by-step

```
Step 1 → Data quality
   "Before I draw any conclusions, I want to check whether the change
    is real or an artefact of a data quality issue."

   Check: pipeline run status, raw event counts, logging changes,
          schema changes, instrumentation changes.

Step 2 → Timing
   "When exactly did the drop begin — date, hour?"
   Step change → specific event. Gradual → trend or quality issue.

Step 3 → Correlated events
   "What else changed at that time?"
   Product releases, experiments, marketing, external events.

Step 4 → Disaggregate
   "Which segment is driving this?"
   Platform / country / user type / acquisition channel / cohort.

Step 5 → Decompose
   "Is it numerator, denominator, or composition?"
   Rate drops when denominator grows — even if numerator is flat.

Step 6 → Hypothesis
   "Based on [evidence], my best hypothesis is [X] because [Y]."

Step 7 → Next step
   "To confirm, I would [specific query or analysis]."
   "While investigating, the team should [operational response]."
```

### Weak vs strong answer

**Question:** DAU dropped 22% yesterday.

**Weak:**
> "I would segment by platform and country to see where the drop is."

**Strong:**
> "First I want to check whether this is a real drop or a data issue — did the pipeline run, are raw event counts normal, did any logging change yesterday?
>
> If the data is clean, I'd find the exact hour it started. Then I'd check what deployed at that time.
>
> Next, I'd segment: is the drop on iOS? Android? A specific country? New or returning users? If it's isolated to one segment, the cause is segment-specific.
>
> I'd also decompose: is it fewer daily users, or the same users not being counted correctly?
>
> Based on that, I'd form a hypothesis with supporting evidence and tell the team what to look at next — and whether there's anything to do operationally while we investigate."

---

## Format 2: "How would you measure success?" (metrics case)

Tests: metric definition, trade-off thinking, guardrails.

### Step-by-step

```
Step 1 → Clarify
   "What product? Who are the users? What decision does this support?"

Step 2 → State the product goal
   "The goal is [X]."
   Define the goal before the metric — the metric follows from it.

Step 3 → Primary metric
   One metric, specific denominator, time window.
   "% of new users who complete ≥1 lesson within 7 days of signup."

Step 4 → Input metrics
   1–2 metrics the team can directly influence.

Step 5 → Guardrail metrics
   1–2 metrics that must not get worse.

Step 6 → Key segment
   "I would watch [X] segment separately because [Y]."
```

### Strong answer example

**Question:** How would you measure the success of a new onboarding flow for a B2B SaaS product?

> "The goal is to get new teams to reach their first collaboration moment — that is the activation event that predicts whether they will become long-term customers.
>
> My primary metric would be: % of new teams who complete at least one collaborative action within 14 days of signup. 14 days because enterprise teams move slower than consumer apps.
>
> For input metrics I would track: time to first invite and time to first shared document — these are leading indicators.
>
> For guardrails: team activation rate for subsequent members (we do not want the admin to set up but the rest of the team to not join) and 30-day account retention.
>
> I would also segment by company size, because the onboarding path that works for a 3-person team may not work for a 50-person team."

---

## Format 3: "Design an A/B test" (experiment design case)

Tests: hypothesis, randomisation, metric, power, duration, guardrails.

### Step-by-step

```
Step 1 → Hypothesis
   "If we do X, Y will change because Z."

Step 2 → Randomisation unit
   Usually user. Justify it.
   "I would randomise at the user level because we want to avoid a user
    seeing both experiences."

Step 3 → Primary metric (one, pre-specified)
   "I would define this before launch, not after seeing results."

Step 4 → Guardrail metrics
   "I would also track [Y] and [Z] to make sure we don't improve
    the primary metric at the cost of user experience."

Step 5 → Sample size
   "I would need: baseline rate, MDE (smallest meaningful lift),
    alpha = 0.05, power = 0.80. With those inputs I can calculate
    the required sample and convert to days."

Step 6 → Duration
   "I would run for at least 2–3 full weekly cycles to account
    for day-of-week effects."

Step 7 → Launch criterion
   "I would pre-specify: ship if primary metric improves by ≥ X
    AND guardrails are stable."

Step 8 → Risks
   "Key risks: novelty effect, interference/spillover, SRM."
```

---

## Format 4: Handling a null result

**Question:** The A/B test came back with p = 0.18. The PM wants to ship anyway.

### Strong answer

> "P = 0.18 means there is an 18% chance of seeing this result if the feature had no effect. That is above our pre-specified alpha of 0.05.
>
> Importantly, this does not mean the feature did not work — it means we don't have enough evidence to be confident it worked. The honest summary is: inconclusive.
>
> What I would check: was the test adequately powered? If power was 80% for the effect size we cared about, and the result is p = 0.18, then either the effect is smaller than our MDE or it does not exist.
>
> I would also look at the confidence interval: if the upper bound of the CI includes effects large enough to matter, it might be worth a longer test. If the upper bound is already small, extending the test is unlikely to change the conclusion.
>
> My recommendation to the PM: I would not ship based on this result. The data does not support it. I would propose either redesigning the feature and retesting, or accepting the null and moving resources to a higher-signal idea."

---

## Practice plan

| Level | Activity | Time |
|-------|---------|------|
| Getting started | Answer each format out loud, untimed | 30 min per format |
| Building speed | Set a 5-minute timer per question | One session per day |
| Interview ready | Do one full case from [09_case_studies/](../09_case_studies/README.md) end to end | 45 min |
| Advanced | Record yourself answering — watch for structure gaps | As needed |

---

*See also: [INTERVIEW_MODE.md](../INTERVIEW_MODE.md) · [00_quick_reference/interview_panic_sheet.md](../00_quick_reference/interview_panic_sheet.md) · [09_case_studies/README.md](../09_case_studies/README.md)*
