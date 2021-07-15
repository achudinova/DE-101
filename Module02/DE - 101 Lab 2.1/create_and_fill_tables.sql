-- Create new schemas

create schema dwh;

-- ****************************************************************************
-- DWH.DIM_CALENDAR
-- ****************************************************************************

-- Drop the table
DROP table if exists dwh.dim_calendar cascade;

-- Create the table
CREATE TABLE dwh.dim_calendar
(
 date_key serial NOT NULL,
 "date"     date NOT NULL,
 day      integer NOT NULL,
 week     integer NOT NULL,
 month    integer NOT NULL,
 year     integer NOT NULL,
 quarter  integer NOT NULL,
 week_day varchar(20) NOT NULL,
 leap     varchar(20) NOT NULL,
 CONSTRAINT PK_dim_calendar PRIMARY KEY ( date_key )
);

-- Clear the table
--truncate table dwh.dim_calendar;

-- Generate dates
insert into dwh.dim_calendar
select
	to_char(date, 'yyyymmdd')::int 	as date_key,
	date::date	as "date",
	extract('day' from date)::int 	as "day",
	extract('week' from date)::int 	as week,
	extract('month' from date)::int as "month",
	extract('year' from date)::int 	as "year",
	extract('quarter' from date)::int as quarter,
	to_char(date, 'dy') as week_day,
	extract('day' from (date_trunc('year', date) + interval '2 month - 1 day') ) = 29 as leap
from generate_series(date '2000-01-01',
                       date '2030-01-01',
                       interval '1 day') as t(date);
-- Check for new rows
select * from dwh.dim_calendar;


-- ****************************************************************************
-- DWH.DIM_CUSTOMER
-- ****************************************************************************

-- Drop
DROP table if exists dwh.dim_customer cascade;

-- Create the table
CREATE TABLE dwh.dim_customer
(
 customer_key  serial NOT NULL,
 customer_id   varchar(8) NOT NULL,
 customer_name varchar(22) NOT NULL,
 segment_name      varchar(11) NOT NULL,
 CONSTRAINT PK_dim_customer PRIMARY KEY ( customer_key )
);

-- Clear the table
--truncate table dwh.dim_customer;

-- Insert rows
insert into dwh.dim_customer
select
	1000 + row_number() over() customer_key,
	customer_id,
	customer_name,
	segment_name
from
	(
	select
		distinct customer_id,
		customer_name,
		segment segment_name
	from stg.orders
	order by 1) t
order by 1;

-- Check for new rows
select * from dwh.dim_customer;


-- ****************************************************************************
-- DWH.DIM_GEO
-- ****************************************************************************

-- Drop
DROP table if exists dwh.dim_geo cascade;

-- Create the table
CREATE TABLE dwh.dim_geo
(
 geo_key     serial NOT NULL,
 country     varchar(13) NOT NULL,
 city        varchar(50) NOT NULL,
 "state"       varchar(20) NOT NULL,
 postal_code varchar(20) NOT NULL,
 region      varchar(50) NOT NULL,
 CONSTRAINT PK_dim_geo PRIMARY KEY ( geo_key )
);


-- Clear the table
--truncate table dwh.dim_geo;

select * from stg.orders where postal_code is null;

-- Fill the postal code for Burlington in stg.orders
update stg.orders
set postal_code = '05401'
where city = 'Burlington' and postal_code is null;

-- Insert rows
insert into dwh.dim_geo
select
	1000 + row_number() over() geo_key,
	t.*
from
(select distinct
	country,
	city,
	state,
	postal_code,
	region
from
	stg.orders
order by 1,2) t;

-- Check for new rows
select * from dwh.dim_geo;



-- ****************************************************************************
-- DWH.DIM_PRODUCT
-- ****************************************************************************

-- Drop
DROP table if exists dwh.dim_product cascade;

-- Create the table
CREATE TABLE dwh.dim_product
(
 product_key       serial NOT NULL,
 product_id        varchar(50) NOT NULL,
 product_name      varchar(150) NOT NULL,
 category_name     varchar(15) NOT NULL,
 subcategory_name varchar(11) NOT NULL,
 CONSTRAINT PK_dim_product PRIMARY KEY ( product_key )
);


-- Clear the table
--truncate table dwh.dim_product;

-- Insert rows
insert into dwh.dim_product
select
	1000 + row_number() over() as product_key,
	t.*
from
(select distinct
	product_id		product_id,
	product_name	product_name,
	category 		category_name,
	subcategory 	subcategory_name
from stg.orders
order by 1) t;

-- Check for new rows
select * from dwh.dim_product;



-- ****************************************************************************
-- DWH.DIM_SHIPPING
-- ****************************************************************************

-- Drop
DROP table if exists dwh.dim_shipping cascade;

-- Create the table
CREATE TABLE dwh.dim_shipping
(
 shipping_key  serial NOT NULL,
 shipping_mode varchar(14) NOT NULL,
 CONSTRAINT PK_dim_shipping PRIMARY KEY ( shipping_key )
);


-- Clear the table
--truncate table dwh.dim_shipping;

-- Insert rows
insert into dwh.dim_shipping
select
	1000 + row_number() over() as shipping_key,
	t.*
from
(select distinct
	ship_mode shipping_mode
from stg.orders
order by 1) t;

-- Check for new rows
select * from dwh.dim_shipping;



-- ****************************************************************************
-- DWH.TFCT_SALES
-- ****************************************************************************

-- Drop
DROP table if exists dwh.tfct_sales;

-- Create the table
CREATE TABLE dwh.tfct_sales
(
 sales_key         serial NOT NULL,
 order_id          varchar(14) NOT NULL,
 order_date_key    integer NOT NULL,
 shipment_date_key integer NOT NULL,
 customer_key      integer NOT NULL,
 product_key       integer NOT NULL,
 shipping_key      integer NOT NULL,
 geo_key           integer NOT NULL,
 sales             numeric(28,4) NOT NULL,
 quantity          integer NOT NULL,
 discount          numeric(4,2) NOT NULL,
 profit            numeric(28,4) NOT NULL,
 CONSTRAINT PK_order PRIMARY KEY ( sales_key )
 --,CONSTRAINT FK_28 FOREIGN KEY ( customer_key ) REFERENCES dwh.dim_customer ( customer_key )
 --,CONSTRAINT FK_31 FOREIGN KEY ( product_key ) REFERENCES dwh.dim_product ( product_key )
 --,CONSTRAINT FK_60 FOREIGN KEY ( shipping_key ) REFERENCES dwh.tfct_sales ( shipping_key )
 --,CONSTRAINT FK_68 FOREIGN KEY ( geo_key ) REFERENCES dwh.dim_geo ( geo_key )
);

--CREATE INDEX fkIdx_29 ON dwh.tfct_sales (customer_key);
--CREATE INDEX fkIdx_32 ON dwh.tfct_sales (product_key) ;
--CREATE INDEX fkIdx_61 ON dwh.tfct_sales (shipping_key);
--CREATE INDEX fkIdx_69 ON dwh.tfct_sales (geo_key);


-- Clear the table
-- truncate table dwh.tfct_sales;

-- Insert rows
insert into dwh.tfct_sales
select
	1000 + row_number() over(order by row_id) 	sales_key,
	order_id									order_id,
	to_char(order_date, 'yyyymmdd')::int 		order_date_key,
	to_char(ship_date, 'yyyymmdd')::int 		shipment_date_key,
	c.customer_key,
	p.product_key,
	s.shipping_key,
	g.geo_key,
	sales,
	quantity,
	discount,
	profit
from stg.orders stg
	join dwh.dim_customer c on c.customer_id = stg.customer_id
	join dwh.dim_product p on p.product_id = stg.product_id and p.product_name = stg.product_name and  p.category_name = stg.category and p.subcategory_name = stg.subcategory
	join dwh.dim_shipping s on s.shipping_mode = stg.ship_mode
	join dwh.dim_geo g on g.city = stg.city and g.country = stg.country and g.postal_code = stg.postal_code::varchar and g.state = stg.state and g.region = stg.region ;

-- Check for new rows
select count(*) from dwh.tfct_sales;