# Swiggy Food Delivery Analysis Using SQL



## Project Title:

**Optimizing Food Delivery Analysis Using MySQL**



## Project Overview:

This SQL-based analysis project focuses on understanding and improving food delivery operations using a sample dataset from Swiggy — a leading online food delivery platform in India. It includes advanced SQL queries to derive business insights from data related to restaurants, delivery time, ratings, food types, and customer feedback.



## Objective:

To enhance business decision-making by analyzing key metrics such as:

- Delivery time

- Food type preferences

- Customer ratings

- Restaurant pricing

- Area and city-wise performance



This project leverages **MySQL** to write clean, optimized queries for data retrieval, manipulation, and creation of new feedback data structures.



---



## Dataset Overview:



| Column Name      | Description                                          |
|------------------|------------------------------------------------------|
| `ID`             | Unique identifier for each record                    |
| `Area`           | Area/locality of the restaurant                      |
| `City`           | City in which the restaurant is located              |
| `Restaurant`     | Name of the restaurant                               |
| `Price`          | Average price per order                              |
| `Avg_ratings`    | Average customer rating                              |
| `Total_ratings`  | Total number of ratings received                     |
| `Food_type`      | Types of cuisines served                             |
| `Address`        | Detailed address of the restaurant                   |
| `Delivery_time`  | Time taken to deliver the order (in minutes)         |



---



## Key SQL Tasks Performed:



### Data Exploration & Aggregation:

1. **City-wise restaurant count** where delivery time > 60 minutes.

2. **All unique food types** offered.

3. **Filtered restaurant listings** from Koramangala with price between 200–400 and ratings > 4.

4. **List of restaurants** serving **Chinese** cuisine.

5. **Total number of restaurants per city.**



### Advanced Filtering & Ranking:

6. **Restaurants in Bangalore** with more than 100 total ratings.

7. **Top 5 restaurants** with the highest average ratings.

8. **Restaurants in either Koramangala or Indiranagar.**



### Aggregation Metrics:

9. **Average delivery time** for restaurants serving **Biryani**.



### Data Manipulation:

10. **Delete** all restaurants where price < 200.

11. **Update** delivery time to 45 mins for restaurants with more than 500 ratings.

12. **Create and populate** a new `customer_feedback` table with constraints and sample data.



---



## Technologies Used:

- **SQL (MySQL)**

- DDL & DML operations

- Filtering, Aggregation, Joins, and Subqueries



---



## Outcome:

This project demonstrates practical SQL skills used in real-world data analytics:

- Identifying performance bottlenecks

- Filtering restaurant options by multiple criteria

- Manipulating data and creating new tables

- Delivering insights that can guide operational improvements for food delivery platforms



