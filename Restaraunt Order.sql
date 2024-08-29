-- The Taste of the World Cafe debuted a new menu at the start of the year. You've been asked to dig into the customer data to see which menu items are doing well/not well and what the top customers seem to like best.

-- Objectives
-- 	1. Explore the menu_items table to get an idea of what's on the new menu.
-- 	2. Explore the order_details table to get an idea of the data that's been collected. 
-- 	3. Use both tables to understand how customers are reacting to the new menu.

use restaurant_db;

-- 	Obj 1. Explore the menu_items table to get an idea of what's on the new menu.
-- 1. View the menu_items table.
select *
from menu_items;

-- 2. Find the number of items on the menu.
select count(*) as 'Menu Items'
from menu_items;

-- 3. What are the least and most expensive items on the menu?
select max(price), min(price)
from menu_items;

-- 4. How many Italian dishes are on the menu?
select count(category)
from menu_items
where category like 'Italian';

-- 5. What are the most least and most expensive Italian dishes on the menu?
select max(price), min(price)
from menu_items
where category like 'Italian';

-- 6. How many dishes are in each category?
select category, count(menu_item_id) as 'Number of Dishes'
from menu_items
group by category;

-- 7. What is the average dish price within each category?
select category, avg(price)
from menu_items
group by category;


-- Obj 2. Explore the order_details table to get an idea of the data that's been collected. 
-- 1. View the order_details table.
select *
from order_details;

-- 2. What is the date range of the table?
select min(order_date), max(order_date)
from order_details;

-- 3. How many orders were made within this date range?
select count(distinct order_id) as 'Number of Orders'
from order_details;

-- 4. How many items were ordered withing this date range?
select count(item_id) as 'Total Items'
from order_details;

-- 5. Which order had the greatest number of items?
select order_id, count(item_id) as num_items
from order_details
group by order_id
order by num_items desc;

-- 6. How many orders had more than 12 items?
select count(*)
from
(select order_id, count(item_id) as num_items
from order_details
group by order_id
having num_items > 12) as num_orders;


-- Obj 3. Use both tables to understand how customers are reacting to the new menu.
-- 1. Combine the menu_items and order_details tables into a single table.
select * 
from order_details as det
left join menu_items as men
on det.item_id = men.menu_item_id;
-- Used a left join to keep all the info from the transaction table. The transaction table (order_details) is more essential than the look up table (menu_items). The order details is more essential than the menu item. The menu item info is supplemental in comparison to order details info. Could have used a right join also to join the info, but it looks better with a left. Could use an inner join to avoid null values, but the transaction info is vital. 
select * 
from menu_items as menu
right join order_details as details
on menu.menu_item_id = details.item_id;

select * 
from order_details as det
inner join menu_items as men
on det.item_id = men.menu_item_id;

-- 2. What are the least and most ordered items?
select item_name, count(item_id) as times_purchased
from order_details as det
left join menu_items as men
on det.item_id = men.menu_item_id
group by item_id
ORDER BY times_purchased desc;

select item_name, count(item_id) as times_purchased
from order_details as det
left join menu_items as men
on det.item_id = men.menu_item_id
group by item_id
ORDER BY times_purchased;

-- 3. What categories are the least and most ordered items in?
select item_name, count(item_id) as times_purchased, category
from order_details as det
left join menu_items as men
on det.item_id = men.menu_item_id
group by item_id
ORDER BY times_purchased;

select item_name, count(item_id) as times_purchased, category
from order_details as det
left join menu_items as men
on det.item_id = men.menu_item_id
group by item_id
ORDER BY times_purchased desc;

-- 4. What are the top 5 orders that spent the most money?
select order_id, sum(price) as total
from order_details as det
left join menu_items as men
on det.item_id = men.menu_item_id
group by order_id
order by total desc
limit 5;

-- 5. View the details of the highest spend order. What insights can you gather from the results?
select *
from order_details as det
left join menu_items as men
on det.item_id = men.menu_item_id
where order_id = 440
order by category;

-- 6. View the details of the top 5 highest spend orders. What insights can you gather from the results?
select order_id, item_name, category, price
from order_details as det
left join menu_items as men
on det.item_id = men.menu_item_id
where order_id in (440,2075,1957,330,2675)
group by order_id, item_name, category, price
order by order_id, category;

select order_id, category, count(item_id) as num_items
from order_details as det
left join menu_items as men
on det.item_id = men.menu_item_id
where order_id in (440,2075,1957,330,2675)
group by order_id, category
order by order_id, category;





'440', '192.15'
'2075', '191.05'
'1957', '190.10'
'330', '189.70'
'2675', '185.10'




