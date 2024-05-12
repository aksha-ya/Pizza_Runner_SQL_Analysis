--How many pizzas were ordered

select count(pizza_ID) as Pizza_count  FROM pizza_runner.customer_orders;


--How many successful orders were delivered by each runner?

select runner_id,count(*) as Successfull_orders
from pizza_runner.runner_orders 
where cancellation is null
group by runner_id


---How many of each type of pizza was delivered?

select cast(p.pizza_name as varchar(max)) as Pizza,count(*) as order_count
from pizza_runner.customer_orders c join pizza_runner.runner_orders r
on c.order_id=r.order_id join pizza_runner.pizza_names p on c.pizza_id=p.pizza_id
where r.cancellation is null
group by cast(p.pizza_name as varchar(max))



---What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

SELECT runner_id, CONCAT(AVG(duration), ' minutes') AS Avg_duration
FROM pizza_runner.runner_orders
GROUP BY runner_id;



--What are the standard ingredients for each pizza?

with cte as (
select pizza_id,value from pizza_runner.pizza_recipes cross apply string_split(toppings,','))
select CAST(pn.pizza_name AS nvarchar(30)) as pizza,string_agg(CAST(pt.topping_name AS nvarchar(30)),',') as standard_ingredients
from pizza_runner.pizza_names pn inner join cte on pn.pizza_id=cte.pizza_id
join pizza_runner.pizza_toppings pt on cte.value=pt.topping_id
group by CAST(pn.pizza_name AS nvarchar(30))


---What was the most commonly added extra?

with cte as (select pizza_id,value from pizza_runner.customer_orders cross apply string_split(extras,',')),
ctee as (select pizza_id,value from pizza_runner.pizza_recipes cross apply string_split(toppings,','))

select cast(topping_name as varchar(max)) as topping,count(*) as times_added
from cte inner join ctee on cte.value=ctee.value
join pizza_runner.pizza_toppings pt on ctee.value=pt.topping_id
group by cast(topping_name as varchar(max))
order by times_added desc 
offset 0 rows
fetch next 1 rows only



If Danny wants to expand his range of pizzas — how would this impact the existing data design? Write an INSERT statement to demonstrate what would happen if a new Supreme pizza with all the toppings was added to the Pizza Runner menu?

INSERT INTO pizza_runner.pizza_recipes
VALUES
  (3, '1, 2, 3, 4, 5, 6, 7, 8, 9, 10');

INSERT INTO pizza_runner.pizza_names
VALUES
  (3, 'Supreme');

-- View modified data
SELECT *
FROM pizza_runner.pizza_recipes;

SELECT *
FROM pizza_runner.pizza_names;

---- What was the most common exclusion?

with a as (
select pizza_id,value from  pizza_runner.customer_orders cross apply string_split(exclusions,','))
select  top 1 cast(pt.topping_name as varchar(max))  as exclusive_name,count(*) as exclusive_count
from a inner join pizza_runner.pizza_toppings pt on a.value=pt.topping_id
group by cast(pt.topping_name as varchar(max))
order by 2 desc 