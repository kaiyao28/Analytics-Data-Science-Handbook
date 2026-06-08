# 07 · Machine Learning for Analytics

## Why this matters

Most analytics DS roles do not require building production ML systems. But they do require knowing when a model is the right tool, what it can and cannot tell you, and how to evaluate whether it is actually working.

Applied correctly, ML extends what analytics can do: predicting who will churn before they do, scoring users for targeting, ranking items for personalisation. Applied carelessly, it creates expensive, unmaintainable systems that do not clearly improve on simpler alternatives.

---

## What you need to know

- When ML adds value over simpler rule-based or statistical analysis
- How to frame a product problem as an ML problem
- Classification for analytics: churn prediction, propensity scoring, intent classification
- Uplift modelling: who benefits from an intervention
- Model evaluation beyond accuracy
- Communicating model results and limitations to stakeholders

---

## Core concepts

**Propensity model** — predicts the probability of a user taking an action (churning, converting, upgrading). Output is a score used for targeting, prioritisation or personalisation.

**Uplift model** — predicts not just who will do something but who will do it *because of* an intervention. The target is the incremental effect. This is the right framing for most targeting problems.

**Persuadables** — the segment that responds to a treatment. Distinct from "sure things" (would act regardless) and "lost causes" (will not act regardless). Uplift models identify persuadables.

**Precision vs recall trade-off** — increasing the precision of a classifier (fewer false positives) usually reduces recall (more false negatives). The right balance depends on the cost of each error type in the specific product context.

**Data leakage** — using information in model features that would not be available at prediction time. Produces optimistic evaluation that does not hold in production. The most common cause of "the model works in testing but not live."

**Calibration** — a well-calibrated model that outputs 70% probability is correct about 70% of the time. Miscalibrated models produce unreliable scores. Important when the score is used for decisions, not just ranking.

---

## Practical example

A subscription app wants to reduce churn.

**Naive approach:** email every user with a discount.

**Better approach using ML:**
1. Build a churn propensity model: predict 30-day churn probability for each active user
2. Build an uplift model: predict which users respond positively to the discount offer
3. Target users in the "persuadables" quadrant: high churn risk AND high uplift
4. Validate with an A/B test: does targeting persuadables improve retention vs broad targeting?

The uplift model prevents wasting budget on users who would churn regardless ("lost causes") and users who would stay anyway ("sure things").

---

## Common mistakes

**Using accuracy as the only evaluation metric.** For imbalanced classes (e.g. 5% churn rate), a model that predicts "no churn" for everyone is 95% accurate. Use AUC-ROC, precision at K, recall and F1.

**Predicting the outcome instead of the uplift.** A churn propensity model tells you who to worry about. An uplift model tells you who to target. These are different questions requiring different approaches.

**Not testing the model with an A/B test before scaling.** Always validate that acting on model predictions improves the business metric it was designed for.

**Ignoring the feedback loop.** Intervening on model predictions changes the distribution the model was trained on. Monitor for score drift over time.

**Overcomplicating.** A logistic regression with interpretable features that business stakeholders trust often outperforms a gradient boosted tree that is a black box. Simpler models are easier to debug, maintain and explain.

---

## Interview relevance

ML questions in analytics DS interviews focus on judgment, not implementation:

- When would you use ML vs simpler analysis?
- How do you evaluate a churn model?
- What is the difference between a propensity model and an uplift model?
- How do you handle class imbalance?
- What is data leakage and how do you detect it?

The expected standard is conceptual clarity and product judgment, not deep ML engineering knowledge.

---

## Exercises

1. A marketplace wants to predict which sellers are likely to become inactive in the next 30 days. Frame this as an ML problem: define the label, candidate features, evaluation metric and what you would do with the model output.
2. A churn model has AUC = 0.85 but the team reports it "does not work." What questions would you ask to understand why?
3. Explain the difference between a propensity model and an uplift model to a non-technical product manager in three sentences.

---

## Files in this folder

| File | Topic |
|------|-------|
| `when_ml_is_useful.md` | Decision framework: when ML beats simpler analysis |
| `churn_prediction.md` | Framing, features, evaluation and deployment for churn models |
| `uplift_modelling.md` | Uplift model types, persuadables segmentation, validation |
| `recommendation_and_ranking.md` | How recommendation and ranking systems work in product analytics |
| `model_evaluation.md` | Evaluation metrics beyond accuracy: AUC, precision/recall, calibration |

---

## Next

[08_communication_and_decision_making](../08_communication_and_decision_making/README.md) — learn to communicate findings and drive decisions clearly.
