# Kimia Farma Performance Analysis Dashboard: Overview
- Build a master table by combining 4 source tables with BigQuery by using CTE and JOIN function.

<img width="775" height="320" alt="image" src="https://github.com/user-attachments/assets/d38d0f91-2a0b-4224-9f5f-d2ab1d48d805" />


- Based on data cleaning & pre-processing process that done using both BigQuery SQL and Python both the source tables and master table is very clean with no missing values, duplicates, wrong format nor invalid data. This process are done before and after the master table created (before and after JOIN process).
- The dashboard are created by connecting master table created in BigQuery with LookerStudio.

## Purposes
Helping Kimia Farma Team to analyze Sales Performance during business year 2020 - 2023 by summarized the information into interactive dashboard.

## Business Question
How did Kimia Farma perform from 2020 to 2023 in sales, profit, and branch service quality, and where are the opportunities to improve?

## Approach
1. **Import and check** the dataset in BigQuery: nulls, duplicates, formats (none found).
2. **Re-validation in Python** (pandas): info, duplicates, describe (data is clean).
3. **Built Master table** in SQL (CTE + JOINs) with calculated fields:
   - `persentase_gross_laba`: tiered gross margin based on the price (10% to 30%)
   - `nett_sales = price - (price x discount_percentage)`
   - `nett_profit = nett_sales x gross margin`
4. **Dashboards** in Looker Studio and Power BI (KPI cards, trend lines, map, top-5 charts, year/month/province filters).
5. **Cross-check**: total `nett_sales` matched across BigQuery, Looker Studio, and Power BI; monthly figures were checked with a separate QC query.
   
## Dashboard Result
- Looker Studio
<img width="422" height="159" alt="image" src="https://github.com/user-attachments/assets/9b76273c-039b-4c11-adbe-81fd6f56c45a" />

- Power BI
<img width="370" height="158" alt="image" src="https://github.com/user-attachments/assets/a0b72dc9-189e-4c7b-8a8b-ad2ccfedcd1b" />

For the Looker Studio dashboard, it can be accessed from https://lookerstudio.google.com/reporting/bc6d8c59-23bb-44a9-8338-1432e153cb42, the result of the dashboard also translated into a pdf report that also contains what insight that I gain from the data.

## Key Findings
- There's total **672,458 transactions**, Rp347.2bn gross sales, **Rp 321.2Bn net sales**, **Rp 91.2Bn net profit** (about 28% margin).
- Discounts reduced revenue by about **Rp 26Bn  (7.5%)**, while profitability stays healthy.
- Yearly performance is stable at roughly **Rp 80Bn net sales per year**.
- **Net sales stay flat (about Rp 220Mn)** all thorough the years
- **West Java** has about 4x the sales of the second-ranked province (Sumatera Utara).
  This may indicate weak penetration elsewhere, but it needs a per-branch comparison before concluding, since West Java may simply have more branches.
- Branch ratings are uniformly high (even the lowest-rated branches are above 4.2), and branches with the most transactions are not the top-rated ones.

## Recommendations
- Study the market segment and strategy in West Java and test them in secondary regions.
- Benchmark competitors in lower-performing provinces.
- Compare sales **per branch** (not only totals) before drawing conclusions on regional penetration.

## Tools
BigQuery SQL, Python (pandas), Looker Studio, Power BI (DAX), Google Colab.

### Contact Person
These project was created using dataset from Kimia Farma as part of Project Based Internship. For more information feel free to contact me from:

No/WA: +6281292728395

E-mail: mercy.claudiam@gmail.com

LinkedIn: : linkedin.com/in/mercy-claudia09
