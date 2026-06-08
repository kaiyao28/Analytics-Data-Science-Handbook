# 05 · Python and Analysis Workflows

## Why this matters

Python extends what you can do beyond SQL: statistical testing, visualisation, simulation, modelling and reproducible notebooks. More importantly, it enforces a discipline that SQL resists: version-controlled, reproducible analysis that others can audit and extend.

This section focuses on practical analysis patterns, not machine learning. The goal is clean, reproducible code that answers product questions clearly.

---

## What you need to know

- Pandas: selecting, filtering, grouping, merging, pivoting
- Exploratory data analysis (EDA) workflow
- Statistical testing in Python (scipy.stats)
- Visualisation: matplotlib and seaborn basics
- Structuring analysis notebooks for reproducibility
- Common product analytics patterns: funnels, retention, experiment analysis

---

## Core concepts

**Reproducibility** — another analyst should be able to run your notebook from top to bottom and get exactly the same result. This requires: fixed random seeds, documented data sources, no manual steps, and cells that run in order.

**EDA before modelling** — always explore the data before any testing or modelling. Check: shape, dtypes, missing values, distributions, outliers and obvious anomalies. Skipping EDA is the leading cause of silent errors.

**Tidy data** — one observation per row, one variable per column. Most Pandas errors and unexpected results come from not enforcing this structure first.

**Vectorisation** — avoid loops over DataFrame rows. Use Pandas vectorised operations or `.apply()` for speed and readability. If you find yourself writing `for row in df.iterrows()`, there is almost always a better way.

---

## Practical example

Experiment analysis in Python:

```python
import pandas as pd
from scipy import stats

# Load experiment data
df = pd.read_csv('experiment_results.csv')
# Columns: user_id, group ('control'/'treatment'), converted (0/1), revenue

# Summarise by group
summary = (
    df.groupby('group')['converted']
    .agg(users='count', conversions='sum', rate='mean')
)
print(summary)

# Two-sample t-test on conversion rate
control = df[df['group'] == 'control']['converted']
treatment = df[df['group'] == 'treatment']['converted']

t_stat, p_value = stats.ttest_ind(control, treatment)
lift = (treatment.mean() - control.mean()) / control.mean()

print(f"\np-value:         {p_value:.4f}")
print(f"Control rate:    {control.mean():.4f}")
print(f"Treatment rate:  {treatment.mean():.4f}")
print(f"Relative lift:   {lift:.2%}")
```

---

## Common mistakes

**Running cells out of order.** A notebook that must be run in a specific non-top-to-bottom order will produce incorrect results for anyone who reruns it. Restart and run all before sharing.

**No random seed.** Any analysis involving sampling or random splitting must set a seed for reproducibility.

**Skipping EDA.** Starting with a model or a test before understanding the data leads to subtle, hard-to-detect errors.

**Using `.iterrows()` for row-level logic.** Almost always the wrong choice. Use `.apply()`, vectorised conditions or `.groupby()`.

**Overwriting raw data.** Never modify the original DataFrame loaded from a source. Assign transformations to new columns or new DataFrames.

**Not checking dtypes.** A numeric column stored as object (string) will produce silently wrong aggregations. Always check `df.dtypes` early in EDA.

---

## Interview relevance

Python is tested less frequently than SQL in analytics DS interviews, but common tasks include:

- Pandas manipulation: filtering, groupby, merge, pivot_table
- "Clean this dataset" exercises: handle nulls, cast types, remove duplicates
- Implement a statistical test from scratch or explain output from scipy/statsmodels

---

## Exercises

1. Given a DataFrame with columns (user_id, event_name, timestamp), write code to calculate the day-7 retention rate for users who signed up in a given month.
2. Simulate an A/B test: generate 1,000 users per group with conversion rates of 5% vs 6.5%. Run a t-test. Is the difference detected? What happens if you reduce the group size to 200?
3. Given a DataFrame with 30% missing values in one column, describe the decision framework you would use to determine whether to impute, remove or flag each case.

---

## Files in this folder

| File | Topic |
|------|-------|
| `pandas_basics.md` | Core Pandas operations for product analytics |
| `exploratory_analysis.md` | EDA workflow: shape, distributions, missing values, outliers |
| `experiment_analysis_python.md` | A/B test analysis: t-tests, proportion tests, confidence intervals |
| `reproducible_analysis.md` | Notebook structure, seeds, dependency management |

---

## Next

[06_dashboards_and_data_storytelling](../06_dashboards_and_data_storytelling/README.md) — learn to communicate findings clearly through dashboards and visualisation.
