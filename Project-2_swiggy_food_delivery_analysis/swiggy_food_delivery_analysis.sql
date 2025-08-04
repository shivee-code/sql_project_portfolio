use live_session

## Task 1. Retrieve the number of restaurants from each city where the delivery time is more than 60 minutes.
SELECT City, COUNT(Restaurant) as no_of_rest
FROM swiggy
WHERE Delivery_time > 60
GROUP BY City;

## Task 2. Find all the unique food types offered by restaurants.
SELECT * FROM swiggy;
SELECT DISTINCT food_type
FROM swiggy;

## Task3. Retrieve all restaurants from "Koramangala" where the price is between 200 and 400, and the average ratings are above 4.
select *
from swiggy
where Area = "Koramangala"
and price between 200 and 400
and Avg_ratings>4;

## Task 4. Fetch all restaurant names that serve 'Chinese' cuisine.
select restaurant, food_type
from swiggy
where food_type like 'Chinese%';

## Task 5. Find the total number of restaurants in each city
select city, count(distinct restaurant) as total_restaurants
from swiggy
group by city;

## Task 6. Retrieve restaurants in Bangalore with more than 100 total ratings
select city, total_ratings
from swiggy
where city="Bangalore"
and Total_ratings>100;

## Task 7. Retrieve the top 5 restaurants based on the highest average ratings
select restaurant, Avg_ratings
from swiggy
order by Avg_ratings desc
limit 5;

## Task 8. Show all restaurants located in either "Koramangala" or "Indiranagar"
select restaurant, Area
from swiggy
where Area in ('Koramangala', 'Indiranagar');

## Task 9. Find the average delivery time for restaurants serving 'Biryani' cuisine
select * from swiggy;
select avg(delivery_time) as avg_delivery_time
from swiggy
where Food_type like '%Biryani';

## Task 10. Delete all restaurants where the price is below 200
delete from swiggy
where price<200;

## Task 11. Update the delivery time to 45 minutes for all restaurants with more than 500 total ratings 
select * from swiggy;
SET SQL_SAFE_UPDATES = 0;    ## this command is disable safe search 
update swiggy set Delivery_time=45
where Total_ratings>=500;
SET SQL_SAFE_UPDATES = 1;    ## this command is enable safe search

## Task 12. create a table to store swiggy customer feedback and insert 10 records from 10 customers
create table customer_feedback
(
feedback_id int primary key,
customer_name varchar(20),
restaurant varchar(20),
price int,
check(price between 1 and 99),
feedback_statement varchar(50),
feedback_date date default (current_date())
);
insert into customer_feedback values
(1, "a", "bb", 20, "very good quality food", "2025-06-22");
insert into customer_feedback(feedback_id, customer_name, restaurant, price, feedback_statement) values
(2, "b", "cc", 40, "good ambience");

## See the customer_feedback table
select * from customer_feedback;