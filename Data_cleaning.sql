/*Data cleaning-dealing with nulls and other anamolies*/
UPDATE pizza_runner.customer_orders
SET exclusions = NULL
WHERE exclusions IN ('null', ' ');

UPDATE pizza_runner.customer_orders
SET extras = NULL
WHERE extras IN ('null', ' ');

UPDATE pizza_runner.runner_orders
SET cancellation = NULL
WHERE cancellation IN ('null', ' ');

-- Setting NULL for columns where orders were cancelled

UPDATE pizza_runner.runner_orders
SET pickup_time = NULL
WHERE cancellation IS NOT NULL; 


UPDATE pizza_runner.runner_orders
SET distance = NULL
WHERE cancellation IS NOT NULL;

UPDATE pizza_runner.runner_orders
SET duration = NULL
WHERE cancellation IS NOT NULL;

update pizza_runner.runner_orders
set duration=replace(duration,'minutes','')

update pizza_runner.runner_orders
set duration=replace(duration,'mins','')

update pizza_runner.runner_orders
set duration=replace(duration,'minute','')

update pizza_runner.runner_orders
set distance=replace(duration,'km','')

UPDATE pizza_runner.runner_orders
SET distance = ltrim(RTRIM(distance));

UPDATE pizza_runner.runner_orders
SET duration = ltrim(RTRIM(duration));


---To correct the data types

ALTER TABLE pizza_runner.runner_orders
ALTER COLUMN pickup_time DATETIME;

ALTER TABLE pizza_runner.runner_orders
ALTER COLUMN duration INT;

ALTER TABLE pizza_runner.runner_orders
ALTER COLUMN distance FLOAT;

alter table pizza_runner.pizza_recipes
alter column toppings varchar(max)
