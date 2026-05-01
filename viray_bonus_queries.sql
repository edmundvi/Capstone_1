USE sample_sales;

-- SELECT, Filtering & Sorting
-- 1. Create a list of all transactions that took place on January 15, 2024, sorted by sale amount from
-- highest to lowest.

SELECT *
	FROM store_sales
	WHERE Transaction_Date = '2024-01-15'
    ORDER BY Sale_Amount DESC
;

-- 2. Which transactions had a sale amount greater than $500? Display the transaction date, store ID,
-- product number, and sale amount.

SELECT *
	FROM store_sales
	WHERE Sale_Amount > 500
    ORDER BY Sale_Amount DESC
;

-- 3. Find all products whose product number begins with the prefix 105250. What category do they
-- belong to?
		-- They belong in the Technology & Accessories category
SELECT 
	p.ProdNum
    , p.Categoryid
    , ic.Category
    FROM products p
    JOIN inventory_categories ic
		ON ic.Categoryid = p.Categoryid
    WHERE Prodnum LIKE '105250%'
;
SELECT * FROM inventory_categories;

-- 4. What is the total sales revenue across all transactions? What is the average transaction amount?

SELECT
	FORMAT(SUM(Sale_Amount), 2) AS Total_Revenue
    , AVG(Sale_Amount) AS Mean_Transaction
	FROM store_sales
;

-- 5. How many transactions were recorded for each product category? Which category has the most
-- transactions?
	-- Stationery and Supplies has the most transactions
SELECT
	ic.Category
    , COUNT(*) AS Total_Transactions
	FROM store_sales ss
    JOIN products p
		ON ss.Prod_Num = p.ProdNum
    JOIN inventory_categories ic
		ON p.categoryID = ic.CategoryID
	GROUP BY ic.Category
    ORDER BY Total_Transactions DESC
;

-- 6. Which store generated the highest total revenue? Which generated the lowest?
	-- Something is wrong with the Total_Revenue column ordering
SELECT 
	Store_ID
	, FORMAT(SUM(Sale_Amount), 2) AS Total_Revenue
	FROM store_sales
    GROUP BY Store_ID
    ORDER BY Total_Revenue DESC
;

-- 7. What is the total revenue for each category, sorted from highest to lowest?


-- 8. Which stores had total revenue above $50,000? (Hint: you'll need HAVING.)