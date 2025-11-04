# reproducibility_gap_activity
Goal: Learn to identify and fix common reproducibility issues in small data workflows.

Welcome to the **Reproducibility Gap Activity!**  
In this activity, you’ll work in pairs to identify and fix common reproducibility issues that occur in open science workflows.

---

## Learning Goals

By the end of this activity, you will:

- Recognize common reproducibility “gaps” in R projects.  
- Practice version control with Git and GitHub.  
- Understand how clear organization and documentation support open science.

---

## Repository Structure

This repository contains several small example R projects.  
Each pair of students will work in one folder only.

reproducibility-gap-activity/

├── pair1_project/

├── pair2_project/

├── pair3_project/

├── pair4_project/

├── pair5_project/

└── README.md


Each `pairX_project` folder includes:

data/ # small dataset
scripts/ # R scripts with reproducibility gaps
results/ # output folder (e.g., plots)
README.md # your notes on what you fixed and how to run


Each project intentionally includes several reproducibility gaps, such as:

- Missing or uninstalled packages
- Absolute (hard-coded) file paths
- Hidden dependencies between scripts
- Unset random seeds
- Outdated variable names or missing data files
- Incomplete or unclear documentation

---

## Instructions

### 1) Form pairs and choose your folder
- Work with a partner and use your assigned folder (e.g., `pair3_project`).
- **Do not edit files outside your assigned folder.**

### 2) Clone the repository using:

GitHub Desktop / RStudio (**File ▸ New Project ▸ Version Control ▸ Git**) with the same URL.

### 3) Open your project in RStudio
- In RStudio, set your working directory to your assigned folder.
- Prefer relative paths (e.g., `readr::read_csv("data/kelp_data.csv")`) instead of absolute paths.

### 4) Explore the project
- Review `scripts/`, `data/`, `results/`, and your folder’s `README.md`.
- Note intended script order (e.g., `scripts/01_load_data.R` → `scripts/02_plot_results.R`).

### 5) Run the scripts (expect breaks)
- Run scripts in order.
- Track what breaks or is unclear:
  - Missing packages?
  - File not found (path issues)?
  - Objects used before they’re created?
  - Random results that change between runs?
  - Documentation gaps?

### 6) Fix reproducibility gaps

Common fixes include:

- **Packages:** add `library()` calls; optionally include commented installs:

install.packages(c("readr","dplyr","ggplot2","here"))
library(readr); library(dplyr); library(ggplot2); library(here)

**Goal:** someone else can clone the repo, follow your folder’s instructions, and reproduce the same output.

### 7) Document what you changed
Edit your folder’s `README.md` and record:
- Pair members’ names
- Issues identified
- Changes made and why
- How to run the workflow (order of scripts, any notes)

Example entry:

Pair 2: Sammy Slug 

-Added ggplot2 and dplyr libraries
-Replaced absolute path with relative path to data/kelp_data.csv
-Added set.seed(42) for reproducible sampling
-Updated README with run instructions 


### 8) Commit and push your changes

-Add a commit note indicating your group name and folder such as "Fix reproducibility gaps in pair3_project"


###
###--------------------------------------------------------------------------------------------------------
### Facilitator Instructions
### 9) Open a Pull Request (PR)
- On GitHub, go to **Pull requests ▸ New pull request**.
- Title: `Fixed reproducibility gaps – Pair X`
- Description: brief summary of problems found and fixes applied.
- Ensure only your pair’s folder is changed.

---

## Wrap-Up Discussion Prompts

1. Which gaps were easiest vs. hardest to fix, and why?
2. What structures or docs would have prevented these issues?
3. What will you adopt in your own projects starting this week?

---

## Tips

- Stay inside your assigned folder to avoid merge conflicts.
- Prefer **relative paths** everywhere.
- Commit early and often with clear messages.
- If you finish early, improve clarity (comments, README, function extraction).
- Ask for help — the goal is learning, not perfection.

---

## Attribution

Created for the UCSC 200A class
by Joshua Smith, Nearshore Ecology Research Group (NERGlab)












