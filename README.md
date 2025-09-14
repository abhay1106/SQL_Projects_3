# Jomato Restaurant Data Analysis – Advanced SQL Project

## 1. Project Overview
This project analyzes restaurant data from a food delivery platform similar to **Jomato**, focusing on **advanced SQL concepts** such as stored procedures, transactions, views, triggers, and loops.  

The dataset contains details about restaurants, cuisines, bookings, ratings, and locations. The goal is to extract insights and simulate real-world database operations for analytics and business reporting.  

---

## 2. Tools & Technologies
- **Database:** MS SQL Server  
- **Concepts Covered:** Stored Procedures, Transactions, ROLLBACK, ROW_NUMBER, WHILE loops, Views, Triggers  

---

## 3. Tasks & Queries

### **Task 1: Create a stored procedure for restaurants with table booking not equal to zero**
```sql
CREATE PROCEDURE usp_TableBookingRestaurants
AS
BEGIN
    SELECT RestaurantName, RestaurantType, CuisineType
    FROM Jomato
    WHERE TableBooking > 0;
END;

-- Execute procedure
EXEC usp_TableBookingRestaurants;
```
Result: Displayed restaurants where table booking is available.

### **Task 2: Transaction – Update cuisine type and rollback**
```sql
BEGIN TRANSACTION;

UPDATE Jomato
SET CuisineType = 'Cafeteria'
WHERE CuisineType = 'Cafe';

-- Check update result
SELECT DISTINCT CuisineType FROM Jomato;

-- Rollback changes
ROLLBACK TRANSACTION;
```
Result: Cuisine type updated temporarily, then reverted back using rollback.

### **Task 3: Generate row numbers and find top 5 areas with highest ratings**
```sql
SELECT TOP 5 Area, Rating, 
       ROW_NUMBER() OVER (ORDER BY Rating DESC) AS RowNum
FROM Jomato
ORDER BY Rating DESC;
```
Result: Displayed top 5 areas ranked by highest ratings.

### **Task 4: Use WHILE loop to display numbers from 1 to 50**
```sql
DECLARE @i INT = 1;

WHILE @i <= 50
BEGIN
    PRINT @i;
    SET @i = @i + 1;
END;
```
Result: Displayed sequential numbers from 1 to 50.

### **Task 5: Create a Top Rating View**
```sql
CREATE VIEW vw_Top5Ratings
AS
SELECT TOP 5 RestaurantName, Rating
FROM Jomato
ORDER BY Rating DESC;
```
Result: View created to store the top 5 highest-rated restaurants.

### **Task 6: Trigger to send email notification when a new record is inserted**
```sql
CREATE TRIGGER trg_NewRestaurantInsert
ON Jomato
AFTER INSERT
AS
BEGIN
    -- Example: Sending email (requires DB Mail setup in SQL Server)
    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'RestaurantEmailProfile',
        @recipients = 'owner@restaurant.com',
        @subject = 'New Restaurant Added',
        @body = 'A new restaurant record has been inserted into the Jomato table.';
END;
```
Result: Trigger created to notify restaurant owners upon new entries.

## 4. Key Learnings

Created stored procedures to encapsulate queries

Used transactions with rollback for safe data updates

Applied ROW_NUMBER() for ranking and filtering

Implemented control flow using WHILE loops

Built views for reusable query storage

Simulated real-world notifications with triggers and database mail

## 5. Future Improvements

Extend stored procedures to include parameters (e.g., filter by city or cuisine)

Add error handling and logging in transactions

Use window functions like RANK() and DENSE_RANK() for deeper insights

Automate regular reports using SQL Agent jobs
