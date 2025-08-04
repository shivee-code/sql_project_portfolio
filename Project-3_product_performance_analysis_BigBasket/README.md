# Product Performance Analysis – Big Basket (SQL Project)



## Project Title:

**Product Performance Analysis in Big Basket Using MySQL Analytical Functions**



## Overview:

This SQL-based case study analyzes sales performance and customer preferences using Big Basket’s product data. The focus is on using **advanced SQL features** such as **ranking functions, CTEs, subqueries, views, stored procedures, lead-lag analysis**, and **CASE expressions** to uncover actionable insights.



The project simulates real-world data analysis tasks commonly performed by data analysts and business intelligence professionals.



---



## Objective:

To derive business insights related to product pricing, category-wise sales, and discount strategies using **MySQL**. This includes:

- Ranking products by sale price

- Comparing current vs. next product prices

- Identifying top-rated items by category

- Creating reusable queries via views and stored procedures



---



## Dataset Description:

The dataset includes product-level details for various items sold on Big Basket.



| Column Name   | Description                                  |
|---------------|----------------------------------------------|
| `id`          | Unique identifier for each product           |
| `product`     | Product name                                 |
| `category`    | Product category                             |
| `sub_category`| Product subcategory                          |
| `brand`       | Brand name                                   |
| `sale_price`  | Sale price offered to customers              |
| `market_price`| Original (MRP) of the product                |
| `type`        | Product type                                 |
| `rating`      | Customer rating for the product              |



---



## SQL Tasks Performed:



### 1. Rank Products by Sale Price Within Each Category

- Used `RANK()`, `DENSE_RANK()`, and `ROW_NUMBER()` window functions.



### 2. Compare Product Sale Prices (Lead/Lag)

- Used `LEAD()` and `LAG()` to show price differences between current and next product within category.



### 3. Identify Top 5 Highest-Rated Products Per Category

- Used `CTE` and `ROW_NUMBER()` to return top-rated items.



### 4. Create a View for 'Beauty & Hygiene' Category

- Simplified category-specific queries using a SQL view.



### 5. Write a Stored Procedure to Update Sale Price by Product ID

- Enables dynamic updating of pricing information.



### 6. Analyze Total Sales per Category and Rank Them

- Used `CTE` + `DENSE_RANK()` for ranking based on sales.



### 7. Create a View to Show Price Difference (Market vs. Sale Price)

- Helps evaluate discount margins product-wise.



### 8. Create a Stored Procedure to Filter Products by Category and Subcategory

- Parameterized procedure for flexible product search.



### 9. Use `CASE` to Categorize Discount Levels

- Products classified into "high", "medium", or "low" discount tiers based on market price.



---



## Technologies Used:

- **SQL (MySQL)**

- Views, Stored Procedures

- CTEs (Common Table Expressions)

- Window Functions

- CASE statements

- Subqueries



---



## Outcomes:

- Showcased real-world SQL techniques for data analysis

- Built modular, reusable query components (views, procedures)

- Performed in-depth analysis of pricing and product performance

- Demonstrated SQL proficiency suitable for data analyst roles

