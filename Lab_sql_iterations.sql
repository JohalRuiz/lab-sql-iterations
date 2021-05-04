-- Lab | SQL Iterations

use sakila;

-- Write a query to find what is the total business done by each store.
select sum(payment.amount) as business, store.store_id 
from payment 
join rental on payment.rental_id = rental.rental_id 
join inventory on rental.inventory_id = inventory.inventory_id
join store on inventory.store_id = store.store_id
group by store.store_id;

-- Convert the previous query into a stored procedure.
DELIMITER //
create procedure biznes_per_store()
begin
select sum(payment.amount) as business, store.store_id 
from payment 
join rental on payment.rental_id = rental.rental_id 
join inventory on rental.inventory_id = inventory.inventory_id
join store on inventory.store_id = store.store_id
group by store.store_id;
end //
DELIMITER ;

call biznes_per_store();
drop procedure if exists biznes_per_store;


-- Convert the previous query into a stored procedure that takes the input for store_id and 
-- displays the total sales for that store.
DELIMITER //
create procedure biznes_per_store(in param1 int)
begin
select sum(payment.amount) as business, store.store_id 
from payment 
join rental on payment.rental_id = rental.rental_id 
join inventory on rental.inventory_id = inventory.inventory_id
join store on inventory.store_id = store.store_id
where store.store_id COLLATE utf8mb4_general_ci = param1;
end //
DELIMITER ;
call biznes_per_store(1);
drop procedure if exists biznes_per_store;

-- Update the previous query. Declare a variable total_sales_value of float type, that will 
-- store the returned result (of the total sales amount for the store). Call the stored 
-- procedure and print the results.
DELIMITER //
create procedure biznes_per_store(in param1 int)
begin
declare total_sales_value float;
select sum(payment.amount) into total_sales_value
from payment 
join rental on payment.rental_id = rental.rental_id 
join inventory on rental.inventory_id = inventory.inventory_id
join store on inventory.store_id = store.store_id
where store.store_id COLLATE utf8mb4_general_ci = param1;
select total_sales_value;
end //
DELIMITER ;
call biznes_per_store(1);
drop procedure if exists biznes_per_store;

/* In the previous query, add another variable flag. If the total sales value for the store is 
over 30.000, then label it as green_flag, otherwise label is as red_flag. Update the stored 
procedure that takes an input as the store_id and returns total sales value for that store 
and flag value.*/