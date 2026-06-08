# 06 · Dashboards and Data Storytelling

## Why this matters

Analysis that is not communicated effectively does not change decisions. Dashboards and data storytelling are how analysts create impact at scale — one good dashboard replaces hundreds of one-off requests and gives stakeholders the context they need to act.

Poor dashboards are worse than none: they create false confidence, generate endless follow-up questions and erode trust in data.

---

## What you need to know

- The difference between exploratory and operational dashboards
- How to define the question a dashboard is meant to answer
- Principles of clear data visualisation
- How to write a data insight (not just a data finding)
- What a metric layer is and why it matters
- Common dashboard mistakes and how to avoid them

---

## Core concepts

**Operational dashboard** — monitors known metrics on a recurring basis. Designed to detect anomalies and track trends. Should be stable in structure. Users know what to look for.

**Exploratory dashboard** — supports investigation of an open question. More flexible, more filters, less permanent. Users are looking for something they do not yet know.

**Metric layer** — a shared, version-controlled layer that defines key metrics consistently across dashboards, SQL and code. Prevents different teams from using subtly different definitions of the same metric.

**Signal vs noise** — a dashboard with 40 charts communicates nothing. Every chart forces a cognitive decision on the reader. Ruthlessly curate: show only what drives decisions.

**Data-ink ratio** — maximise the proportion of visual elements that encode information. Remove gridlines, heavy borders, redundant tick marks and decorative colours that add no meaning.

**The insight vs the finding** — a finding is "conversion dropped 12%." An insight is "conversion dropped 12% because mobile checkout broke on iOS 17." Dashboards surface findings; you supply the insight.

---

## Practical example

A product team asks for a dashboard to track performance of a new onboarding flow.

**Weak version:** 12 charts covering every event in the onboarding sequence, all shown as daily time series with no labels or targets. Title: "Onboarding Dashboard."

**Better version:**
- Three primary metrics: completion rate, median time to complete, day-7 retention by signup cohort
- One data quality chart: daily event volume to detect instrumentation failures
- One breakdown: completion rate by platform (mobile vs desktop)
- Refresh: daily. Default view: last 90 days.
- Title: "Onboarding Flow Health — is the new flow performing as expected?"

The reader opens it and immediately knows whether things are working.

---

## Common mistakes

**Building for the builder, not the reader.** You understand every chart because you built it. Others do not. Test with someone who was not involved.

**Too many metrics.** If everything is tracked, nothing is prioritised. Decide what matters before building, not by adding everything and editing later.

**No context for the numbers.** A conversion rate of 12% is meaningless without a target, baseline or benchmark. Always add a reference point.

**Stale metric definitions.** Metric definitions evolve, but dashboards often do not. Undocumented or outdated definitions cause silent divergence between teams.

**Putting the burden of interpretation on the reader.** A chart without a title that states the conclusion makes the reader do work they should not have to do. Write titles that say what the chart shows, not just what it contains.

---

## Interview relevance

Dashboard and visualisation questions appear in analytics DS interviews as part of product sense:

- "Design a dashboard for this product or feature"
- "What metrics would you track to monitor the health of [feature]?"
- "This dashboard shows a drop — walk me through how you investigate it"

Interviewers want to see: a clear purpose for the dashboard, appropriate metric selection, and awareness of the difference between monitoring (routine) and diagnosis (investigation).

---

## Exercises

1. A PM asks you to "build a dashboard for retention." Write five clarifying questions before you start building.
2. Critique this dashboard setup: 15 charts, no titles that state conclusions, no metric definitions, daily granularity for a metric that matters on a monthly timescale. List five specific improvements.
3. Write a one-sentence insight (not finding) for: "Mobile checkout conversion increased from 3.2% to 4.1% in the week after the redesign, while desktop remained flat at 7.8%."

---

## Files in this folder

| File | Topic |
|------|-------|
| `dashboard_design.md` | Principles of dashboard design: purpose, structure, layout |
| `data_visualisation_principles.md` | Chart selection, colour, labelling, avoiding misleading visuals |
| `metric_layer.md` | What a metric layer is, why it matters, how to implement one |
| `dashboard_spec_template.md` | Template for speccing a dashboard before building it |

---

## Next

[07_machine_learning_for_analytics](../07_machine_learning_for_analytics/README.md) — learn when and how to apply predictive models in an analytics role.
