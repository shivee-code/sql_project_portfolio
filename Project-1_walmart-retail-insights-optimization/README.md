# Sales Performance Analysis of Walmart Stores Using Advanced MySQL Techniques

This project explores Walmart’s transactional data to derive actionable business insights through advanced SQL queries. By analyzing customer behavior, product line performance, and sales patterns, the project supports data-driven decision-making and sales strategy optimization.

---

## Objective

To optimize Walmart’s sales strategies by analyzing historical transactions across branches, customer types, product lines, and payment methods using advanced MySQL queries.

---


---

## Key Business Questions Answered

1. **Top Branch by Sales Growth Rate** – Identified branches with the highest month-over-month sales growth.
2. **Most Profitable Product Line per Branch** – Ranked product lines by total profit margin.
3. **Customer Segmentation by Spending** – Classified customers into High, Medium, and Low spending tiers.
4. **Anomaly Detection in Sales** – Detected outliers using Z-scores for unusually high or low transactions.
5. **Popular Payment Method by City** – Ranked most frequently used payment methods per city.
6. **Monthly Sales by Gender** – Analyzed gender-wise sales performance month-wise.
7. **Preferred Product Line by Customer Type** – Identified product preferences by membership type.
8. **Repeat Customer Identification** – Tracked customers making repeat purchases within 30 days.
9. **Top 5 Customers by Sales Volume** – Highlighted the highest revenue-generating customers.
10. **Sales Trends by Day of Week** – Evaluated weekly patterns to find peak sales days.

---

## Techniques Used

- **Common Table Expressions (CTEs)**
- **Window Functions** (`RANK()`, `LAG()`, `NTILE()`)
- **Aggregations & Grouping**
- **Date Parsing and Formatting**
- **Z-Score Based Anomaly Detection**
- **Self-Joins for Repeat Purchase Logic**

---

## Tools

- MySQL / MySQL Workbench
- CSV Data (Walmart Transactions)
- Git Bash
- PowerPoint (for reporting)

---

## Dataset

- **File:** `Walmartsales_Dataset.csv`
- Contains customer transactions including:
  - Branch, City, Date
  - Customer ID & Type
  - Product Line, Payment Method
  - Total Sales, COGS, Gross Income

