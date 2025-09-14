--Using Assignment Database:-
USE Assignment;

--Dataset Provided:-
SELECT * FROM Jomato;

--Tasks to be Performed:-
 --1) Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.
CREATE OR ALTER PROCEDURE DisplayRestaurantDetails 
AS
BEGIN
SELECT restaurantName, RestaurantType, CuisinesType FROM Jomato WHERE tablebooking != 'No'
END;

EXEC DisplayRestaurantDetails;

  --2) Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.
BEGIN TRANSACTION;

UPDATE Jomato
SET CuisinesType = 'Cafeteria'
WHERE CuisinesType = 'Cafe';

SELECT *
FROM Jomato
WHERE CuisinesType = 'Cafeteria';

ROLLBACK TRANSACTION;

--3)Generate a row number column and find the top 5 areas with the highest rating of restaurants.
SELECT TOP 5 Rating,Area,ROW_NUMBER() OVER (ORDER BY rating DESC) AS RowNumber
FROM Jomato;

--4)Use the while loop to display the 1 to 50.
DECLARE @OrderId INT;
SET @OrderId = 1;
WHILE @OrderId<= 50
BEGIN
    SELECT * FROM Jomato WHERE OrderId=@OrderId;
    SET @OrderId = @OrderId + 1;
END;

--5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.
CREATE VIEW Top_Rating AS
SELECT TOP 5 Rating FROM Jomato
ORDER BY Rating DESC;

SELECT * FROM Top_Rating;

--6. Write a trigger that sends an email notification to the restaurant owner whenever a new record is inserted.
CREATE TRIGGER SendEmailOnInsert
ON Jomato
AFTER INSERT
AS
BEGIN
    DECLARE @RestaurantName NVARCHAR(100);
    DECLARE @OwnerEmail NVARCHAR(100);
    
    SELECT @RestaurantName = i.RestaurantName, @OwnerEmail = i.OwnerEmail
    FROM inserted i;
    
    DECLARE @Subject NVARCHAR(255) = 'New Restaurant Inserted: ' + @RestaurantName;
    DECLARE @Body NVARCHAR(MAX) = 'Dear Owner, a new restaurant (' + @RestaurantName + ') has been added to our system.';
    
    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'YourMailProfile',
        @recipients = @OwnerEmail,
        @subject = @Subject,
        @body = @Body;
END;

