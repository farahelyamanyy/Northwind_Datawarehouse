# 📦 Northwind Data Warehouse

A complete end-to-end **Data Warehouse project** designed using the Northwind OLTP database. This project showcases dimensional modeling, star schema design, and ETL development using **SQL Server Integration Services (SSIS)** — ideal for powering business intelligence and analytical reporting.

---

## 🚀 Project Overview

This project demonstrates how to transform a transactional (OLTP) system into an analytical (OLAP) system by:

- Designing a **Star Schema** from the normalized Northwind database
- Implementing ETL processes in **SSIS**
- Handling data cleaning, nulls, type casting, and business logic
- Populating the **Fact** and **Dimension** tables for analytical querying

---

## 📁 Project Structure

```plaintext
Northwind_Datawarehouse/
│
├── database/
│   ├── NorthWind_DB.bak                # Backup file of the OLTP Northwind DB
│   └── Northwind_DB_Creation.sql       # SQL script to create the OLTP DB
│
├── Data warehouse/
│   └── NorthWind_DWH_creation.sql      # SQL script to create the DWH star schema
│
└── README.md
```

---

## 🧩 Star Schema Design

### 🔹 OLTP Schema (Before)

![Northwind OLTP Schema](https://i.postimg.cc/Y2mHdtZD/Screenshot-160.png)

### 🔸 Star Schema (After)

![Northwind Star Schema](https://i.postimg.cc/mggp6whZ/Screenshot-161.png)

---

## ⚙️ ETL Process with SSIS

- Developed ETL data pipelines using SQL Server Integration Services (SSIS) to automate the extraction, transformation, and loading of data from the source database (OLTP) to the data warehouse (OLAP).
- The important part was loading the data into the Fact Table and that was done by collecting all the IDs from tables in the source database using a Merge Join transformation.
- Data cleansing using **Derived Columns** and **ISNULL** logic
- Lookups on dimensions to replace business keys with surrogate keys



---

## 📌 How to Run the Project

1. **Restore the Northwind DB**  
   Use `NorthWind_DB.bak` or run `Northwind_DB_Creation.sql` in SSMS

2. **Create the Data Warehouse schema**  
   Run `NorthWind_DWH_creation.sql` to build the DWH tables

3. **Execute the SSIS Package**  
   Open the SSIS package in Visual Studio and run to populate the DWH

 > ⚠️ *Note: The SSIS package used for the ETL process is not included in this repository.*


---
