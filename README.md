# 🏏 IPL Cricket Analytics Dashboard (2008–2024)

<div align="center">

![Python](https://img.shields.io/badge/Python-3.13-3776AB?style=for-the-badge&logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.4-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Advanced-FF6B00?style=for-the-badge&logo=databricks&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Pandas](https://img.shields.io/badge/Pandas-Data_Analysis-150458?style=for-the-badge&logo=pandas&logoColor=white)
![Kaggle](https://img.shields.io/badge/Kaggle-Dataset-20BEFF?style=for-the-badge&logo=kaggle&logoColor=white)

**An end-to-end cricket analytics platform analyzing 16 seasons of IPL data**
**260,000+ ball-by-ball records · 15 SQL queries · 6-page live dashboard**

[🔴 Live Dashboard](https://drive.google.com/file/d/1X9AQVPW2GJBZZYuTBm7ESiVO8HPvwMkr/view?usp=sharing) · [📁 View Dataset](https://github.com/Jatin22sharma/IPL-Cricket-Analytics-Dashboard-2008-2024-/tree/main/01_data) · [📄 SQL Queries](https://github.com/Jatin22sharma/IPL-Cricket-Analytics-Dashboard-2008-2024-/tree/main/03_sql_analysis)

</div>

---

## 📌 Project Overview

This project answers the questions every cricket fan argues about:

> *"Who is the greatest IPL batsman of all time? Does winning the toss actually matter? Which ground is the most batsman-friendly? And which bowler is truly the most economical?"*

I built a complete analytics system — loading real IPL data into a MySQL database, writing 15 advanced SQL queries, analysing patterns with Python, and delivering insights through a 6-page IPL-themed Power BI dashboard with team colors, player photos and stadium backgrounds.

---

## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────┐    ┌─────────────────┐    ┌──────────────────┐
│  Kaggle Dataset │───▶│   Python     │───▶│  MySQL Database │───▶│   Power BI       │
│                 │    │  (load_data  │    │  ipl_db         │    │  Live 6-page     │
│  matches.csv    │    │   .py)       │    │  matches table  │    │  IPL Dashboard   │
│  1,095 matches  │    │              │    │  deliveries     │    │  Team colors     │
│                 │    │  SQLAlchemy  │    │  table          │    │  Player photos   │
│  deliveries.csv │    │  + PyMySQL   │    │  260K+ rows     │    │  Stadium BG      │
│  260K+ rows     │    │              │    │                 │    │                  │
└─────────────────┘    └──────────────┘    └─────────────────┘    └──────────────────┘
```

---

## 🔑 Key Findings

| Finding | Insight |
|---|---|
| 🏆 **Most successful team** | Chennai Super Kings — 5 IPL titles (2010, 2011, 2018, 2021, 2023) |
| 🏏 **All-time top scorer** | Virat Kohli — 8,014 runs across 252 matches |
| ⚡ **Most wickets** | Yuzvendra Chahal — 205 wickets across 159 matches |
| 🪙 **Toss advantage** | Chasing teams win 54% of matches — toss matters but doesn't guarantee victory |
| 🏟️ **Highest scoring ground** | Himachal Pradesh Cricket Association Stadium — avg 184 runs in 1st innings |
| 💥 **Six hitting king** | Chris Gayle — 359 sixes, the most in IPL history |
| 🎯 **Most economical bowler** | Anil Kumble — 6.65 economy rate (min 50 overs) |
| 📈 **IPL growth** | Runs scored grew ~40% from 2008 to 2024 |

---

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|---|---|---|
| **Dataset** | Kaggle IPL Dataset (2008–2024) | Source data — matches + deliveries |
| **Data Loading** | Python 3.13, Pandas, SQLAlchemy, PyMySQL | Load 260K rows into MySQL |
| **Database** | MySQL 8.4 (local) | Relational database storage |
| **SQL Analysis** | MySQL Workbench — 15 queries | CTEs, Window Functions, JOINs, HAVING |
| **Python Analysis** | Pandas, Matplotlib, Jupyter Notebook | EDA + 8 charts |
| **Visualisation** | Power BI Desktop + Service | Interactive IPL-themed dashboard |
| **Version Control** | Git, GitHub | Code management |

---

## 📁 Project Structure

```
ipl-analytics/
│
├── 01_data/
│   ├── matches.csv              ← 1,095 IPL matches (2008–2024)
│   └── deliveries.csv           ← 260,000+ ball-by-ball records
│
├── 02_database/
│   └── load_data.py             ← loads both CSVs into MySQL
│
├── 03_sql_analysis/
│   └── queries.sql              ← 15 SQL queries (basic → advanced)
│
├── 04_python_analysis/
│   ├── analysis.ipynb           ← EDA + 8 charts
│   ├── chart_top_scorers.png
│   ├── chart_top_wickets.png
│   ├── chart_season_runs.png
│   ├── chart_toss.png
│   ├── chart_sixes.png
│   ├── chart_economy.png
│   └── chart_venues.png
│
├── 05_dashboard/
│   └── IPLDashboard.pbix        ← Power BI file
│
├── .env                         ← MySQL credentials (not committed)
├── .gitignore
├── requirements.txt
└── README.md
```

---

## 📊 Dashboard Pages

| Page | Title | Key Visuals |
|---|---|---|
| 1 | Overview & Records | 4 KPI cards · IPL titles by team (team colors) |
| 2 | Batting Analysis | Top scorers · Six hitters · Player photo card · Season slicer |
| 3 | Bowling Analysis | Top wicket takers · Economy rate · Dismissal donut |
| 4 | Match & Toss Intel | Toss split · Bat vs chase · Win % by team · Dhoni tribute |
| 5 | Venue Intelligence | Highest scoring grounds · Most matches · Stadium background |
| 6 | Season Trends | Runs per season area chart · Growth story · IPL trophy |

---

## 🧠 SQL Queries Showcase

| # | Query | Technique used |
|---|---|---|
| Q1 | Matches per season | GROUP BY, ORDER BY |
| Q2 | IPL titles by team | WHERE, COUNT, LIMIT |
| Q3 | Top 10 run scorers | SUM, GROUP BY, ROUND |
| Q4 | Top 10 wicket takers | WHERE with exclusions, COUNT |
| Q5 | Toss win analysis | CASE WHEN, SUM, DIVIDE |
| Q6 | Best economy rates | HAVING, calculated column |
| Q7 | Most sixes hit | WHERE filter, COUNT |
| Q8 | Avg score by venue | Subquery JOIN, AVG, HAVING |
| Q9 | Season-wise runs | Multi-table JOIN, GROUP BY |
| Q10 | Bat first vs chase | CASE WHEN, percentage calc |
| Q11 | Top scorer per season | **CTE + RANK() Window Function** |
| Q12 | Running total matches | **SUM() OVER Window Function** |
| Q13 | Most consistent batsman | **CTE + STD() deviation** |
| Q14 | Best powerplay bowlers | WHERE over BETWEEN, HAVING |
| Q15 | Death over specialists | WHERE over BETWEEN, HAVING |

---

## ⚙️ How to Run

### Prerequisites
```
Python 3.10+
MySQL 8.0+ with MySQL Workbench
Power BI Desktop (free)
Kaggle account (free dataset download)
```

### Setup
```bash
# Clone the repo
git clone https://github.com/Jatin22sharma/IPL-Cricket-Analytics-Dashboard-2008-2024-
cd IPL-Cricket-Analytics-Dashboard-2008-2024-

# Install dependencies
pip install -r requirements.txt

# Add MySQL password to .env
echo "MYSQL_PASSWORD=yourpassword" > .env
```

### Run the pipeline
```bash
# Step 1 — Create database in MySQL Workbench
# Run: CREATE DATABASE ipl_db; USE ipl_db;

# Step 2 — Load data into MySQL
python 02_database/load_data.py

# Step 3 — Run SQL queries in MySQL Workbench
# Open: 03_sql_analysis/queries.sql

# Step 4 — Run Python analysis
# Open: 04_python_analysis/analysis.ipynb

# Step 5 — Open dashboard
# Open: 05_dashboard/IPLDashboard.pbix in Power BI Desktop
```

---

## 📦 Requirements

```
pandas==2.2.0
numpy==1.26.0
matplotlib==3.8.0
sqlalchemy==2.0.0
pymysql==1.1.0
python-dotenv==1.0.0
cryptography==42.0.0
```

---

## 💡 What I Learned

- Designing a **relational MySQL database** with proper table structure for large datasets
- Writing **advanced SQL** — CTEs, Window Functions (RANK, ROW_NUMBER, SUM OVER), multi-table JOINs
- **Connecting Python to MySQL** using SQLAlchemy URL.create for safe credential handling
- Building a **thematic Power BI dashboard** — IPL colors, team branding, player photos
- Discovered that **chasing teams win 53%** of IPL matches — contradicting the popular belief that batting first is safer in T20
- **Chris Gayle's 357 sixes** is so far ahead of #2 (232) that it may never be broken

---

## 🤝 Connect

**[Jatin Sharma]**
Aspiring Data Analyst | Python · SQL · MySQL · Power BI

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=flat&logo=linkedin)](https://linkedin.com/in/jatin-sharma22)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=flat&logo=github)](https://github.com/Jatin22sharma)

---

<div align="center">
<sub>🏏 Built with real IPL data · MySQL locally hosted · Power BI dashboard · 2026</sub>
</div>
