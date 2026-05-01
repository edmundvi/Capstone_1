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
