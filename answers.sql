Question 1: Converting to 1NF
-- =============================================
-- TRANSFORM TO 1NF (Eliminate multi-valued attributes)
-- =============================================
-- Step 1: Create normalized table structure
CREATE TABLE NormalizedOrders (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Step 2: Insert split product values
INSERT INTO NormalizedOrders (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Alternative for existing table:
-- SELECT OrderID, CustomerName, 
--        SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ', ', n), ', ', -1) AS Product
-- FROM ProductDetail
-- JOIN number_table ON n <= LENGTH(Products) - LENGTH(REPLACE(Products, ', ', '')) + 1

Question 2: Converting to 2NF
-- =============================================
-- TRANSFORM TO 2NF (Remove partial dependencies)
-- =============================================
-- Step 1: Create Orders table (removes CustomerName dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create OrderItems table (full dependency on composite PK)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Populate tables
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);
