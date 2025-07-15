USE [master]
GO
CREATE DATABASE [NORTHWND_DWH]
GO
USE [NORTHWND_DWH]
GO

-- Create the orders fact table
CREATE TABLE dbo.ordersales_fact
(
    order_key INT IDENTITY(1,1) NOT NULL ,
	order_id INT NOT NULL,
    employee_key INT NOT NULL,
    shipper_key INT NOT NULL,
    customer_key INT NOT NULL,
    supplier_key INT NOT NULL,
    product_key INT NOT NULL,
    shipinfo_key INT NOT NULL,
	order_date_key INT NOT NULL,
    required_date_key INT NOT NULL,
    shipped_date_key INT NOT NULL,
    freight REAL NOT NULL,
    unit_price REAL NOT NULL,
    quantity INT NOT NULL,
    discount REAL NOT NULL,
	extended_price REAL NOT NULL
	);

-- Create the date_dim table
CREATE TABLE date_dim
(
    date_key INT NOT NULL PRIMARY KEY,
    full_date DATE,
	day INT,
    weekday_name VARCHAR(9),
	week INT,
	month INT,
    month_name VARCHAR(20),
	quarter INT,
    year INT
);

-- Create the Customers table
CREATE TABLE dbo.customer_dim
(
    customer_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    customer_id nchar(5) NOT NULL,
    company_name nvarchar(40) NOT NULL,
    contact_name nvarchar(30),
    contact_title nvarchar(30),
	address nvarchar(60),
    city nvarchar(15),
    region nvarchar(15),
    country nvarchar(15),
	postal_code nvarchar(10),
);


-- Create the employee dimension table
CREATE TABLE dbo.employee_dim
(	employee_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	employee_id INT NOT NULL,
    first_name nvarchar(10) NOT NULL,
	last_name nvarchar(20) NOT NULL,
    title nvarchar(30),
	TitleOfCourtesy nvarchar(25),
    birth_date DATE,
    hire_date DATE,
    address nvarchar(60),
    city nvarchar(15),
    region nvarchar(15),
    country nvarchar(15),
	postal_code nvarchar(10),
);

-- Create the product Dimension table
CREATE TABLE dbo.product_dim
(
    product_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    product_id INT NOT NULL,
    product_name nvarchar(40) NOT NULL,
	quantity_per_unit nvarchar(20),
    unit_price REAL,
	units_in_stock SMALLINT,
	units_on_order SMALLINT,
	ReorderLevel smallint,
    Discontinued smallint, 
    category_name nvarchar(15) NOT NULL,
	category_descriotion nvarchar(100)
);

-- Create the suppliers Dimension table 
CREATE TABLE dbo.supplier_dim
(
    supplier_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    supplier_id INT NOT NULL,
    company_name nvarchar(40) NOT NULL,
	contact_name nvarchar(30),
    contact_title nvarchar(30),
    address nvarchar(60),
    city nvarchar(15),
    region nvarchar(15),
    country nvarchar(15),
	postal_code nvarchar(10)
);

-- Create the Shipper dimension table
CREATE TABLE dbo.shipper_dim
(
    shipper_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    shipper_id INT NOT NULL,
    company_name nvarchar(40) NOT NULL
);

-- Create the ship_info dimension table
CREATE TABLE dbo.ship_info_dim
(
    shipinfo_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ship_name NVARCHAR(40),
    ship_address nvarchar(60),
    ship_city nvarchar(15),
    ship_region nvarchar(15),
    ship_country nvarchar(15)
);

--Add primary key constraint on fact table 

ALTER table dbo.ordersales_fact add constraint PK_Fact_order primary key(order_key, order_id,employee_key,shipper_key,customer_key,
																	supplier_key,product_key,shipinfo_key,order_date_key,required_date_key,shipped_date_key)


-- Add Foreign Key Constraints
ALTER TABLE dbo.ordersales_fact
    ADD CONSTRAINT FK_ordersales_fact_customer_key FOREIGN KEY (customer_key)
    REFERENCES dbo.customer_dim (customer_key);

ALTER TABLE dbo.ordersales_fact
    ADD CONSTRAINT FK_ordersales_fact_date_key0 FOREIGN KEY (order_date_key)
    REFERENCES dbo.date_dim (date_key);


ALTER TABLE dbo.ordersales_fact
    ADD CONSTRAINT FK_ordersales_fact_date_key1 FOREIGN KEY (required_date_key)
    REFERENCES dbo.date_dim (date_key);


ALTER TABLE dbo.ordersales_fact
    ADD CONSTRAINT FK_ordersales_fact_date_key2 FOREIGN KEY (shipped_date_key)
    REFERENCES dbo.date_dim (date_key);

ALTER TABLE dbo.ordersales_fact
    ADD CONSTRAINT FK_ordersales_fact_employee_key FOREIGN KEY (employee_key)
    REFERENCES dbo.employee_dim (employee_key);

ALTER TABLE dbo.ordersales_fact
    ADD CONSTRAINT FK_ordersales_fact_product_key FOREIGN KEY (product_key)
    REFERENCES dbo.product_dim (product_key);

ALTER TABLE dbo.ordersales_fact
    ADD CONSTRAINT FK_ordersales_fact_supplier_key FOREIGN KEY (supplier_key)
    REFERENCES dbo.supplier_dim (supplier_key);

ALTER TABLE dbo.ordersales_fact
    ADD CONSTRAINT FK_ordersales_fact_shipper_key FOREIGN KEY (shipper_key)
    REFERENCES dbo.shipper_dim (shipper_key);

ALTER TABLE dbo.ordersales_fact
    ADD CONSTRAINT FK_ordersales_fact_shipinfo_key FOREIGN KEY (shipinfo_key)
    REFERENCES dbo.ship_info_dim (shipinfo_key);


------ population of Date dimension 

DECLARE @StartDate DATE = '1995-01-01';
DECLARE @EndDate DATE = '2035-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    DECLARE @DateKey INT = CONVERT(INT, FORMAT(@StartDate, 'yyyyMMdd'));

    INSERT INTO date_dim (date_key, full_date, day, weekday_name, week, month, month_name, quarter, year )
    VALUES (
        @DateKey,
        @StartDate,
		DATEPART(DAY, @StartDate),
        DATENAME(WEEKDAY, @StartDate),
		DATEPART(WEEK, @StartDate),
		DATEPART(MONTH, @StartDate),
        DATENAME(MONTH, @StartDate),
		DATEPART(QUARTER, @StartDate),
        DATEPART(YEAR, @StartDate)
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END;

--DEFAULT Unknown row 
INSERT INTO date_dim (date_key, full_date, day, weekday_name, week, month, month_name, quarter, year)
VALUES
(-1, NULL, NULL, 'Unknown', NULL, NULL, 'Unknown', NULL, NULL);



