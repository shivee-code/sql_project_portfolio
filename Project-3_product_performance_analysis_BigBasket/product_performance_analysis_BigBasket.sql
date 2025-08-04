use live_session;
select * from bigbasket;

# Task 1. Rank products based on their sale price within each category.
select category, product, sale_price,
rank() over(partition by category order by sale_price desc) as rank_salesprice,
dense_rank() over(partition by category order by sale_price desc) as dence_salesprice,
row_number() over(partition by category order by sale_price desc) as rank_salesprice
from bigbasket;

# Task 2. Find the next product's sale price for comparison within the same category.
select category, product, sale_price,
lead(sale_price) over(partition by category order by sale_price desc) as lead_salesprice
from bigbasket;

# if you want to find the previous product's sale price then use lag().
select category, product, sale_price,
lag(sale_price) over(partition by category order by sale_price desc) as lag_salesprice
from bigbasket;

# Task 3. Create a CTE to get the top 5 highest-rated products for each category.
with toprated as (
select category, product, rating,
row_number() over(partition by category order by rating desc) as rank_row
from bigbasket)
select * from toprated where rank_row<=5;

# Task 4. Create a view to simplify querying for product information in the 'Beauty & Hygiene' category.
create view Beauty_Hygiene as
select id, product, category, sub_category, rating, brand, market_price
from bigbasket
where category="Beauty & Hygiene";
select * from Beauty_Hygiene;

# Task 5. Write a stored procedure to update the sale price of a product by its id.
DELIMITER //
CREATE PROCEDURE update_saleprice(
IN product_id INT,
IN new_saleprice INT
)
BEGIN
UPDATE bigbasket
SET sale_price = new_saleprice
WHERE id = product_id;
END //
DELIMITER ;
call update_saleprice(1,550);
select * from bigbasket;

# Task 6. Create a CTE to show the total sales price per category and rank them.
with total_sale as(
select category, sum(sale_price) as total_saleprice
from bigbasket
group by category)
select category, total_saleprice,
dense_rank() over(order by total_saleprice desc) as dense_ranksale
from total_sale;

# Task 7. Create a view to store the sale price and market price difference for each product.
create view prdf as
select product, sale_price, market_price, (market_price-sale_price) as diff
from bigbasket;
select * from prdf;

# Task 8. Create a stored procedure to return products from a specific category and sub category.
DELIMITER //

CREATE PROCEDURE GetProductsByCategory(
    IN input_category VARCHAR(100),
    IN input_subcategory VARCHAR(100)
)
BEGIN
    SELECT id, product, brand, category, sub_category, sale_price, market_price, rating, type
    FROM bigbasket
    WHERE category = input_category
      AND sub_category = input_subcategory;
END //

DELIMITER ;
CALL GetProductsByCategory('Beverages', 'Tea');

# Task 9. Use CASE to assign discounts based on the market price of the products(>500 as high discount, from 200 to 500 as medium discount or else low discount).
select product, market_price,
case
when market_price > 500 then "high discount"
when market_price between 200 and 500 then "medium_discount"
else "low discount"
end market_saleprice_levels
from bigbasket;