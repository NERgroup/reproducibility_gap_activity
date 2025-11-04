# reproducibility_gap_activity

**Goal:** Learn to identify and fix common reproducibility issues in small data workflows — and submit your fixes via GitHub so they can be reviewed.

Welcome to the **Reproducibility Gap Activity!**  
You’ll work in pairs to diagnose and fix reproducibility issues in R-based mini-projects. Each pair works in a separate folder to avoid merge conflicts. You will complete the Git/GitHub workflow from **inside RStudio** (no terminal required).

---

## Workflow Summary (RStudio-only)

**Fork on GitHub → Clone your fork in RStudio (New Project ▸ Version Control ▸ Git) → Create a branch in the RStudio Git pane → Work only in your assigned folder → Commit & Push from RStudio → Open a Pull Request back to the instructor repo on GitHub**

---

## Learning Goals

By the end of this activity, you will:
- Recognize common reproducibility “gaps” in R projects.
- Practice version control with Git and GitHub (forks, branches, PRs) **from within RStudio**.
- Understand how clear organization, relative paths, and documentation support open science and reproducibility.

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

    data/         # small dataset(s)
    scripts/      # R scripts with reproducibility gaps
    results/      # output folder (e.g., plots)
    README.md     # your notes on what you fixed and how to run

Each project intentionally includes several reproducibility gaps, such as:
- Missing or uninstalled packages
- Absolute (hard-coded) file paths
- Hidden dependencies between scripts
- Unset random seeds
- Outdated variable names or missing data files
- Incomplete or unclear documentation

---

## Instructions (RStudio-only workflow)

### 1) Form pairs and choose your folder
- Work with a partner and use your assigned folder (e.g., `pair3_project`).
- **Do not edit files outside your assigned folder.**

### 2) Fork the repository on GitHub
- In your web browser, open the instructor repository.
- Click **Fork** (top-right) to create your own copy under your GitHub account.

### 3) Clone **your fork** in RStudio (no terminal)
- In RStudio: **File ▸ New Project ▸ Version Control ▸ Git**
  - **Repository URL:** paste the URL of **your fork** (from your GitHub account)
  - Choose a local directory and click **Create Project**
- RStudio opens the project and enables the **Git** pane.

### 4) Create a branch for your pair (in RStudio)
- In the **Git** pane, open the **Branch** menu (or gear icon) → **New Branch…**
- **Name:** `pairX` (replace with your assigned pair number/name)
- Click **Create** (RStudio will switch you to this branch)

### 5) Explore your assigned project folder
- Work **only** inside `pairX_project/`.
- Review `scripts/`, `data/`, `results/`, and your folder’s `README.md`.
- Note script order (e.g., `scripts/01_load_data.R` → `scripts/02_plot_results.R`).

### 6) Run the scripts (expect breaks)
- Run scripts in order and note where things fail or are unclear:
  - Missing packages?
  - Files not found (path issues)?
  - Objects used before they are created?
  - Random results that change between runs?
  - Documentation gaps?

### 7) Fix reproducibility gaps
Examples in R (use relative paths and make the workflow deterministic and documented):

    # Packages: add library() calls; optionally include commented installs
    # install.packages(c("readr","dplyr","ggplot2","here"))
    library(readr); library(dplyr); library(ggplot2); library(here)

    # Paths: replace absolute paths with relative paths
    # BAD (absolute): readr::read_csv("/Users/name/Desktop/kelp_data.csv")
    dat <- readr::read_csv("data/kelp_data.csv")
    # or with here():
    dat <- readr::read_csv(here::here("data", "kelp_data.csv"))

    # Hidden dependencies: explicitly source prerequisites
    source("scripts/01_load_data.R")

    # Randomness: set a seed before random operations
    set.seed(42)

Other good practices:
- Add brief, clear comments and usage notes.
- Standardize names or fix outdated references.
- Ensure outputs are written to `results/` **via code**, not manual export.

**Goal:** Someone else can clone your fork, follow your folder’s instructions, and reproduce the same outputs.

### 8) Document what you changed (in your folder’s README.md)
Record:
- Pair members’ names
- Issues identified
- Changes made and why
- How to run the workflow (order of scripts, any notes)

**Example entry:**

    Pair 2: Sammy Slug & Otter Friend
    - Added ggplot2 and dplyr libraries
    - Replaced absolute path with relative path to data/kelp_data.csv
    - Added set.seed(42) for reproducible sampling
    - Updated README with run instructions (01 → 02)

### 9) Commit and Push (in RStudio)
- In the **Git** pane, stage your changed files (check the boxes).
- Click **Commit**, write a clear message (e.g., `Fix reproducibility gaps in pair3_project: packages, paths, seed, docs`), then **Commit**.
- Click **Push** (up arrow).  
  - If prompted to **Publish branch**, accept (this sets the upstream for your `pairX` branch on your fork).

### 10) Open a Pull Request (PR) on GitHub
- Go to your fork on GitHub. Click **Contribute → Open pull request**  
  (or go to the instructor repo → **Pull requests → New pull request**, then choose your fork/branch as the compare).
- **Base repository:** instructor repo (branch `main`)  
- **Head repository:** your fork, branch `pairX`  
- **Title:** `Fixed reproducibility gaps – Pair X`  
- **Description:** brief summary of problems found and fixes applied.  
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
