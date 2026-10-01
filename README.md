# 🚴 BikeStores Sales Analysis — Advanced SQL

Analyzing the BikeStores sample database with SQL Server to rank customers, products, and staff, and to uncover who drives sales performance.

---

## 📌 Project Overview

This project answers six business questions using **Window Functions, CTEs, and Subqueries**. The goal was to move beyond simple data retrieval and perform real analytical tasks: ranking, running totals, and comparing performance against company averages.

## 🗂️ Dataset

**BikeStores** sample database (SQL Server). Tables used:

| Schema | Table | Purpose |
|---|---|---|
| `sales` | `orders` | Order header: customer, staff, order date |
| `sales` | `order_items` | Order lines: quantity and list price |
| `sales` | `staffs` | Employee details |
| `production` | `products` | Product names and prices |
| `production` | `categories` | Product categories |

---

## 🧠 Business Questions & Solutions

| # | Business Question | Techniques |
|---|---|---|
| 1 | Rank each customer by the total value of their orders | `RANK()`, `SUM()`, `GROUP BY` |
| 2 | Find the second highest product price in each category | `DENSE_RANK()`, `PARTITION BY`, CTE |
| 3 | Calculate each employee's total sales with a running total | `SUM() OVER (... ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`, CTE |
| 4 | Find employees whose average sales are higher than the company average | Subquery, `AVG()`, `HAVING` |
| 5 | Find the employee who processed the most orders each year | `ROW_NUMBER()`, `PARTITION BY`, CTE |
| 6 | Find the top 3 most expensive products in each category | `DENSE_RANK()` vs `ROW_NUMBER()`, CTE |

### Example: Customer Ranking

```sql
SELECT 
    o.customer_id,
    SUM(oi.quantity * oi.list_price) AS total_price,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.list_price) DESC) AS price_rank
FROM sales.orders AS o
INNER JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY o.customer_id;
```

---

## 💡 Key Concepts Practiced

- **Ranking functions:** `RANK()`, `DENSE_RANK()`, and `ROW_NUMBER()`, and how each handles ties
- **PARTITION BY:** ranking inside each group (category, year) instead of across the whole table
- **Running totals:** cumulative sums using window frames
- **CTEs:** breaking complex logic into readable steps
- **Subqueries:** comparing group averages against an overall average
- **Multi-table JOINs** and aggregate functions

## 📝 Notes

- Sales value is calculated as `quantity * list_price`. Discounts are not applied.
- Query 6 includes two solutions on purpose: `DENSE_RANK()` returns all products tied at a rank, while `ROW_NUMBER()` returns exactly three rows per category.

---

## ▶️ How to Run

1. Install **SQL Server** and **SQL Server Management Studio** (or Azure Data Studio).
2. Download the BikeStores sample database and restore or run its setup script.
3. Open `bikestores_analysis.sql` and run each query.

## 🛠️ Tools

![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Window Functions](https://img.shields.io/badge/Window%20Functions-0A66C2?style=for-the-badge)
![CTEs](https://img.shields.io/badge/CTEs-444444?style=for-the-badge)
---
## 🗂️ Data Source
The dataset is the BikeStores sample database, available here:
🔗 [Download BikeStores](https://www.sqlservertutorial.net/getting-started/load-sample-database/)

> The data is not included in this repository. Download it and run the setup script before executing the queries

