
--create table staging 1--
create table building_store_staging
(like building_store including all)

--Entering table data--
insert into building_store_staging 
select * from building_store 

select * from building_store_staging


--Check For Duplicates
with duplicate_cte as
(
	select *,
		row_number () over(partition by 
			product_name, 
			brand, 
			product_type, 
			unit,
			unit_purchase, 
			price_per_unit, 
			total_price, 
			date_shop, 
			delivery, 
			store_location, 
			type_store,
			customer_name, 
			cashier_name
		)as row_num
	from building_store_staging 
)
select * from duplicate_cte
where row_num > 1;



SELECT to_date(date_shop::text, 'YYYY-MM-DD HH24:MI:SS') 
AS date_converted
FROM building_store_staging;

--update date--
UPDATE building_store_staging 
SET "date_shop" = "date_shop"::date;

--update data type date
update building_store_staging 
set date_shop = date_shop::date;

--change data type date_shop
ALTER TABLE building_store_staging
ALTER COLUMN date_shop TYPE date
USING date_shop::date;

--delete column currency
alter table building_store_staging 
drop column currency


select date_shop 
from building_store_staging bss 


--Check for Missing Values--
SELECT *
FROM building_store_staging
WHERE 
    -- kolom teks: NULL atau ''
    product_type   IS NULL OR product_type   = '' OR
    delivery       IS NULL OR delivery       = '' OR
    store_location IS NULL OR store_location = '' OR
    type_store     IS NULL OR type_store     = '' OR
    customer_name  IS NULL OR customer_name  = '' OR
    cashier_name   IS NULL OR cashier_name   = '' OR
    unit           IS NULL OR
    unit_purchase  IS NULL OR
    price_per_unit IS NULL OR
    total_price    IS NULL OR
    date_shop      IS NULL;

select * from building_store_staging bss 










