use project_1;
select * from walmartsales_dataset;

#TASK 1
-- Step 1: Calculate monthly total sales per branch
WITH monthly_sales AS (
    SELECT
        Branch,
        DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m-01') AS sales_month,
        SUM(Total) AS monthly_total
    FROM
        walmartsales_dataset
    GROUP BY
        Branch, DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m-01')
),

-- Step 2: Calculate month-over-month growth using LAG
sales_growth AS (
    SELECT
        Branch,
        sales_month,
        monthly_total,
        LAG(monthly_total) OVER (PARTITION BY Branch ORDER BY sales_month) AS prev_month_total
    FROM
        monthly_sales
),

-- Step 3: Calculate growth rate
growth_rate AS (
    SELECT
        Branch,
        sales_month,
        monthly_total,
        prev_month_total,
        CASE 
            WHEN prev_month_total > 0 THEN (monthly_total - prev_month_total) / prev_month_total
            ELSE NULL
        END AS monthly_growth_rate
    FROM
        sales_growth
),

-- Step 4: Average growth rate per branch
avg_growth AS (
    SELECT
        Branch,
        ROUND(AVG(monthly_growth_rate), 4) AS avg_monthly_growth
    FROM
        growth_rate
    WHERE
        monthly_growth_rate IS NOT NULL
    GROUP BY
        Branch
)

-- Step 5: Get top branch
SELECT
    Branch,
    avg_monthly_growth
FROM
    avg_growth
ORDER BY
    avg_monthly_growth DESC
LIMIT 1;




#TASK 2
select * from walmartsales_dataset;
-- Step 1: Calculate profit per product line per branch
WITH product_profit AS (
    SELECT
        Branch,
        "Product line" AS product_line,
        SUM("gross income" - cogs) AS total_profit
    FROM
        walmartsales_dataset
    GROUP BY
        Branch, "Product line"
),

-- Step 2: Rank product lines within each branch by profit
ranked_products AS (
    SELECT
        Branch,
        product_line,
        total_profit,
        RANK() OVER (PARTITION BY Branch ORDER BY total_profit DESC) AS profit_rank
    FROM
        product_profit
)

-- Step 3: Select the most profitable product line per branch
SELECT
    Branch,
    product_line,
    total_profit
FROM
    ranked_products
WHERE
    profit_rank = 1
ORDER BY
    Branch;



#TASK 3
WITH customer_spending AS (
    SELECT
        "Customer ID" AS customer_id,
        SUM(Total) AS total_spent
    FROM
        walmartsales_dataset
    GROUP BY
        "Customer ID"
),

-- Step 2: Rank customers by total spending and calculate percentiles
ranked_customers AS (
    SELECT
        customer_id,
        total_spent,
        NTILE(3) OVER (ORDER BY total_spent DESC) AS spending_tier
    FROM
        customer_spending
)

-- Step 3: Label the segments
SELECT
    customer_id,
    total_spent,
    CASE spending_tier
        WHEN 1 THEN 'High Spender'
        WHEN 2 THEN 'Medium Spender'
        WHEN 3 THEN 'Low Spender'
    END AS spending_segment
FROM
    ranked_customers
ORDER BY
    total_spent DESC;
    
    
#TASK 4
-- Step 1: Calculate average and standard deviation for each product line
WITH product_stats AS (
    SELECT
        "Product line",
        AVG(Total) AS avg_total,
        STDDEV(Total) AS std_total
    FROM
        walmartsales_dataset
    GROUP BY
        "Product line"
),

-- Step 2: Join with original data to compare each transaction to the stats
transaction_analysis AS (
    SELECT
        w.*,
        ps.avg_total,
        ps.std_total,
        -- Z-score calculation
        (Total - ps.avg_total) / ps.std_total AS z_score
    FROM
        walmartsales_dataset w
    JOIN
        product_stats ps
        ON w."Product line" = ps."Product line"
)

-- Step 3: Filter out anomalies (z-score > 2 or < -2)
SELECT
    "Invoice ID",
    "Product line",
    Branch,
    Total,
    ROUND(avg_total, 2) AS avg_product_total,
    ROUND(z_score, 2) AS z_score,
    CASE 
        WHEN z_score > 2 THEN 'High Anomaly'
        WHEN z_score < -2 THEN 'Low Anomaly'
    END AS anomaly_type
FROM
    transaction_analysis
WHERE
    ABS(z_score) > 2
ORDER BY
    ABS(z_score) DESC;



#TASK 5
-- Step 1: Count transactions per payment method in each city
WITH payment_counts AS (
    SELECT
        City,
        Payment,
        COUNT(*) AS payment_count
    FROM
        walmartsales_dataset
    GROUP BY
        City, Payment
),

-- Step 2: Rank payment methods by usage within each city
ranked_payments AS (
    SELECT
        City,
        Payment,
        payment_count,
        RANK() OVER (PARTITION BY City ORDER BY payment_count DESC) AS rank_in_city
    FROM
        payment_counts
)

-- Step 3: Get the most popular payment method per city
SELECT
    City,
    Payment AS most_popular_payment,
    payment_count
FROM
    ranked_payments
WHERE
    rank_in_city = 1
ORDER BY
    City;
    
    
#TASK 6
-- Step 1: Extract month from the Date column and group by Gender
SELECT
    DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS sales_month,
    Gender,
    SUM(Total) AS total_sales
FROM
    walmartsales_dataset
GROUP BY
    sales_month, Gender
ORDER BY
    sales_month, Gender;
    
    
    
#TASK 7
-- Step 1: Sum total sales per product line and customer type
WITH product_sales AS (
    SELECT
        "Customer type",
        "Product line",
        SUM(Total) AS total_sales
    FROM
        walmartsales_dataset
    GROUP BY
        "Customer type", "Product line"
),

-- Step 2: Rank product lines per customer type by total sales
ranked_sales AS (
    SELECT
        "Customer type",
        "Product line",
        total_sales,
        RANK() OVER (PARTITION BY "Customer type" ORDER BY total_sales DESC) AS rank
    FROM
        product_sales
)

-- Step 3: Select the top product line for each customer type
SELECT
    "Customer type",
    "Product line",
    total_sales
FROM
    ranked_sales
WHERE
    rank = 1;



#TASK 8
-- Step 1: Convert Date to proper format and join each customer’s transactions to themselves
WITH parsed_data AS (
    SELECT
        `Customer ID`,
        STR_TO_DATE(`Date`, '%m/%d/%Y') AS txn_date,
        `Invoice ID`
    FROM
        walmartsales_dataset
),

-- Step 2: Self-join on Customer ID to compare dates
repeat_customers AS (
    SELECT
        a.`Customer ID`,
        a.txn_date AS first_purchase,
        b.txn_date AS repeat_purchase,
        DATEDIFF(b.txn_date, a.txn_date) AS days_between
    FROM
        parsed_data a
    JOIN
        parsed_data b
        ON a.`Customer ID` = b.`Customer ID`
        AND b.txn_date > a.txn_date
        AND DATEDIFF(b.txn_date, a.txn_date) <= 30
)

-- Step 3: Get distinct repeat customers
SELECT DISTINCT
    `Customer ID`
FROM
    repeat_customers
ORDER BY
    `Customer ID`;



#TASK 9
SELECT
    `Customer ID`,
    SUM(`Total`) AS total_revenue
FROM
    walmartsales_dataset
GROUP BY
    `Customer ID`
ORDER BY
    total_revenue DESC
LIMIT 5;


#TASK 10
SELECT
    DAYNAME(STR_TO_DATE(`Date`, '%m/%d/%Y')) AS day_of_week,
    SUM(`Total`) AS total_sales
FROM
    walmartsales_dataset
GROUP BY
    day_of_week
ORDER BY
    total_sales DESC;

