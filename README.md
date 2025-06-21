# 🦠 COVID-19 Data Exploration Project

This project focuses on exploring global COVID-19 data using SQL to uncover insights around infection rates, death counts, vaccination progress, and overall global impact. The analysis was performed in SQL Server and includes advanced querying techniques such as CTEs, window functions, and temporary tables.

---

## 📌 Project Goals

- Analyze total cases and deaths by country and globally
- Explore infection and death percentages per population
- Track vaccination trends using rolling calculations
- Prepare cleaned data for visualization in tools like Tableau

---

## 🧰 Tools & Technologies

- **SQL Server Management Studio (SSMS)**
- **COVID-19 Dataset** (Deaths & Vaccinations)
- **Tableau for visualization**

---

## 🧪 Key SQL Concepts Used

- `JOIN`, `GROUP BY`, `ORDER BY`, `WHERE`
- Aggregate functions: `SUM()`, `MAX()`
- Common Table Expressions (CTEs)
- Window functions: `OVER(PARTITION BY...)`
- Temporary Tables
- `CREATE VIEW` and `DROP TABLE`

---

## 📄 Project Breakdown

### 1. 🗂 Exploring the Dataset
- Previewed both `CovidDeaths` and `CovidVaccinations` tables
- Ordered by date and location to identify trends

### 2. 📉 Analyzing Infection and Mortality
- Calculated **Death Percentage** for Romania and other countries
- Measured **Infection Rate** vs Population

### 3. 🌍 Global Aggregations
- Identified countries and continents with the highest:
  - Infection rates
  - Death counts
- Computed **daily global totals**

### 4. 💉 Vaccination Analysis
- Used **CTEs** and **Window Functions** to calculate rolling totals
- Measured **percentage of population vaccinated**

### 5. 🧪 Using Temp Tables & Views
- Built a **temporary table** for reusable calculations
- Created a **view** (`PercentPopulationVaccinated`) to support future Tableau dashboards

---

## 📊 Insights Generated

- Highest infection rates relative to population
- Global mortality rates over time
- Vaccination progress per country
- Most impacted continents by death count

---

## 📁 Files in this Repo

- `SQL query - Data Exploration.sql`: Main SQL script for all queries
- `SQLQuery - Tables for Tableau.sql`: Script of the tables used for Tableau Visuals

---

## ✅ How to Use

1. Clone the repo or download `.sql` files
2. Import the dataset into your SQL environment
3. Run queries step by step to explore the data
4. Check the results on Tableau Public

 ---

## 📊 Tableau Dashboard

Explore the interactive COVID-19 Dashboard created in Tableau:

👉 [**View the Dashboard on Tableau Public**](https://public.tableau.com/app/profile/ciui.lidia.bianca/viz/CovidDeathsDashboard_17449900283970/Dashboard1)

This dashboard includes:
- Global death counts by continent
- Infected population percentages per country
- Forecasting trends for selected countries
- Interactive charts and maps for visual insights  

---

## 🙋‍♀️ About Me

Hi, I'm **Ciui Lidia Bianca**, a data enthusiast passionate about turning raw data into actionable insights using tools like SQL, Power BI, Excel, and Tableau.  
Feel free to [connect with me on LinkedIn]( https://www.linkedin.com](https://www.linkedin.com/in/ciui-lidia-4675b0245/ ) or check out more on my [portfolio website](https://your-portfolio-link.com).

