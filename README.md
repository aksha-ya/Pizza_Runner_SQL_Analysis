Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers as a part of uberization.

The Data
The data Danny provided consists of six tables.

Runners: Stores the registration date for each new runner.

Customer_orders: Captures customer pizza orders, with one row per individual pizza in an order. 
(Key columns - pizza_id: Identifies the type of pizza ordered; 

exclusions: Specifies ingredient_id values to be removed from the pizza; 
extras: Specifies ingredient_id values to be added to the pizza). 

Note: Customers can order multiple pizzas of the same type with different exclusions and extras.

Runner_orders: Tracks orders assigned to runners, including completed and cancelled orders. 
(Key columns - pickup_time: Timestamp when the runner picks up the pizzas; 
distance: Distance traveled by the runner to deliver the order; duration: Time taken for the runner to deliver the order). It is worth noting that data quality issues exist in this table.

Pizza_names: Lists the names of the two available pizzas - Meat Lovers and Vegetarian.
Pizza_recipes: Defines the standard set of toppings for each pizza_id.
Pizza_toppings: Contains a mapping of topping_id values to their corresponding topping_name values.