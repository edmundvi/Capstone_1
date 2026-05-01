/*
MANAGER: Miami Vue
REGION: Northeast
REGIONALDIRECTOR: Michael Jarvis
STATE: New Jersey
*/

	-- Using sample_sales schema
USE sample_sales;

	-- Query to find SalesManager and associated region details
SELECT *
	FROM management
	WHERE SalesManager = 'Miami Vue';

-- 1.) What is total revenue overall for sales in the assigned territory, plus the start date and end date that tell you what period the data covers?

	-- Query to find which store IDs are in my sales territory
	-- Store IDs in sales territory of New Jersey are 824 to 839
SELECT * FROM store_locations
	WHERE State = 'New Jersey';
    
	-- Query to find total revenue of sales territory (IDs 824 to 839)
    -- Total revenue of territory = 5,175,405.87
SELECT
	FORMAT(SUM(Sale_Amount), 2) AS Territory_Revenue, -- Snake formatting to stay consistent with column naming conventions
    MIN(Transaction_Date) AS Start_Date,		 	  
    MAX(Transaction_Date) AS End_Date
	FROM store_sales
	WHERE Store_ID BETWEEN 824 AND 839 -- IDs of stores in New Jersey
;

-- 2.) What is the month by month revenue breakdown for the sales territory?

	-- Query to find total revenue month by month
SELECT								
	YEAR(Transaction_Date) AS Year
    , MONTH(Transaction_Date) AS Month
	, FORMAT(sum(Sale_Amount), 2) AS Monthly_Revenue	
	FROM store_sales
	WHERE Store_ID >= 824 AND Store_ID <= 839
	GROUP BY
		YEAR(Transaction_Date),	
		MONTH(Transaction_Date)		
	ORDER BY YEAR
;

-- 3.) Provide a comparison of total revenue for the specific sales territory and the region it belongs to

	-- Quick locate other territories in region, Maryland, Massachusetts, Maine, New Jersey
SELECT * FROM management WHERE Region = 'Northeast';

	-- Find IDs of the stores for these regions
SELECT * FROM store_locations
	WHERE State  = 'Maryland'	   -- IDs 731 to 739
		OR State = 'Massachusetts' -- IDs 730, and 801 to 817
		OR State = 'Maine'		   -- IDs 818 to 823
;
    
    -- Finds total revenue of the region using join on Store_ID
    -- New Jersey Revenue = 5,175,405.87
    -- Region Revenue = 24,237,526.98
SELECT
	FORMAT (SUM(ss.Sale_Amount), 2) AS Northeast_Revenue
	FROM store_sales ss
    JOIN store_locations sl
	ON ss.Store_ID = sl.StoreID 					-- StoreID columns spelled differently but values are the same
    WHERE (StoreID BETWEEN 730 AND 739) 			-- IDs of all stores in region
	   OR (StoreID BETWEEN 801 AND 839)
;
		
-- 4.) What is the number of transactions per month and average transaction size by product category for the sales territory?
	
    -- Join store_sales, products, and inventory_categories on Prod_Num and CategoryID
SELECT
	YEAR(Transaction_Date) AS Year
    , MONTH(Transaction_Date) AS Month
    , Category
    , FORMAT(AVG(Sale_Amount), 2) AS Avg_Transaction_Size
    , COUNT(*) AS Transactions
    FROM store_sales ss
    JOIN products p
		ON ss.Prod_Num = p.ProdNum -- Column names are different but values are the same
	JOIN inventory_categories ic
		ON p.Categoryid = ic.Categoryid
	WHERE ss.Store_ID BETWEEN 824 AND 839
    GROUP BY 
		YEAR(Transaction_Date)
		, MONTH(Transaction_Date)
        , Category
	ORDER BY
	Category
    , Year
    , Month
;
    
-- 5.) Can you provide a ranking of in-store sales performance by each store in the sales territory, or a ranking of online sales performance by state within an online sales territory?

	-- Find sum of each store and order from highest to lowest
SELECT
	SUM(sale_amount) AS Sales
    , Store_ID
	FROM store_sales
	WHERE (Store_ID BETWEEN 730 AND 739) 			-- IDs of all stores in region
	   OR (Store_ID BETWEEN 801 AND 839)
	GROUP BY Store_ID
    ORDER BY Sales DESC
;
-- 6.) What is your recommendation for where to focus sales attention in the next quarter?
