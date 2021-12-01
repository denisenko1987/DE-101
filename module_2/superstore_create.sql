-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-11-24 09:23:10.778

-- tables
-- Table: customer_dim
CREATE TABLE customer_dim (
    customer_id varchar(20)  NOT NULL,
    customer_name varchar(50)  NOT NULL,
    segment varchar(50)  NOT NULL,
    CONSTRAINT customer_dim_pk PRIMARY KEY (customer_id)
);

-- Table: geo_dim
CREATE TABLE geo_dim (
    postal_code int  NOT NULL,
    country varchar(20)  NOT NULL,
    region varchar(20)  NOT NULL,
    city varchar(20)  NOT NULL,
    state varchar(20)  NOT NULL,
    manager_dim_region varchar(20)  NOT NULL,
    CONSTRAINT geo_dim_pk PRIMARY KEY (postal_code)
);

-- Table: manager_dim
CREATE TABLE manager_dim (
    region varchar(20)  NOT NULL,
    person varchar(20)  NOT NULL,
    CONSTRAINT manager_dim_pk PRIMARY KEY (region)
);

-- Table: order_date_dim
CREATE TABLE order_date_dim (
    order_id varchar(20)  NOT NULL,
    order_date date  NOT NULL,
    year int  NOT NULL,
    month int  NOT NULL,
    week int  NOT NULL,
    day_of_week varchar(10)  NOT NULL,
    day int  NOT NULL,
    CONSTRAINT order_date_dim_pk PRIMARY KEY (order_id)
);

-- Table: product_dim
CREATE TABLE product_dim (
    product_id varchar(20)  NOT NULL,
    sub_category varchar(20)  NOT NULL,
    category varchar(20)  NOT NULL,
    product_name varchar(20)  NOT NULL,
    CONSTRAINT product_dim_pk PRIMARY KEY (product_id)
);

-- Table: sales_fact_dim
CREATE TABLE sales_fact_dim (
    row_id int  NOT NULL,
    order_id varchar(20)  NOT NULL,
    customer_id varchar(20)  NOT NULL,
    product_id varchar(20)  NOT NULL,
    ship_mode varchar(20)  NOT NULL,
    postal_code int  NOT NULL,
    sales decimal(5,3)  NOT NULL,
    quantity int  NOT NULL,
    discount decimal(5,3)  NOT NULL,
    profit decimal(8,3)  NOT NULL,
    CONSTRAINT sales_fact_dim_pk PRIMARY KEY (row_id)
);

-- Table: ship_date_dim
CREATE TABLE ship_date_dim (
    order_id varchar(20)  NOT NULL,
    ship_date date  NOT NULL,
    year int  NOT NULL,
    month int  NOT NULL,
    week int  NOT NULL,
    day_of_week varchar(10)  NOT NULL,
    day int  NOT NULL,
    CONSTRAINT ship_date_dim_pk PRIMARY KEY (order_id)
);

-- foreign keys
-- Reference: customer_dim_sales_fact_dim (table: sales_fact_dim)
ALTER TABLE sales_fact_dim ADD CONSTRAINT customer_dim_sales_fact_dim
    FOREIGN KEY (customer_id)
    REFERENCES customer_dim (customer_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: geo_dim_manager_dim (table: geo_dim)
ALTER TABLE geo_dim ADD CONSTRAINT geo_dim_manager_dim
    FOREIGN KEY (region)
    REFERENCES manager_dim (region)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: order_date_dim_sales_fact_dim (table: sales_fact_dim)
ALTER TABLE sales_fact_dim ADD CONSTRAINT order_date_dim_sales_fact_dim
    FOREIGN KEY (order_id)
    REFERENCES order_date_dim (order_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: sales_fact_dim_geo_dim (table: sales_fact_dim)
ALTER TABLE sales_fact_dim ADD CONSTRAINT sales_fact_dim_geo_dim
    FOREIGN KEY (postal_code)
    REFERENCES geo_dim (postal_code)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: sales_fact_dim_product_dim (table: sales_fact_dim)
ALTER TABLE sales_fact_dim ADD CONSTRAINT sales_fact_dim_product_dim
    FOREIGN KEY (product_id)
    REFERENCES product_dim (product_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: ship_date_dim_sales_fact_dim (table: sales_fact_dim)
ALTER TABLE sales_fact_dim ADD CONSTRAINT ship_date_dim_sales_fact_dim
    FOREIGN KEY (order_id)
    REFERENCES ship_date_dim (order_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

