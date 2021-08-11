use sales;

-- Changing INR to USD
DELETE FROM transactions WHERE currency = 'USD';

UPDATE transactions
SET currency = 'USD'
WHERE currency = 'INR';


-- Removing sales data with bad values i.e. negative values
DELETE FROM transactions WHERE sales_amount < 0;

-- Joined tables for reference    
SELECT 
    t.*, d.*
FROM
    transactions t
        INNER JOIN
    date d ON t.order_date = d.date
WHERE
    d.year = 2019;  


-- Total revenue generated in 2029
SELECT 
    SUM(sales_amount) AS total_revenue
FROM
    transactions t
        INNER JOIN
    date d ON t.order_date = d.date
WHERE
    d.year = 2019;
 
-- Total revenue generated in 2019 per month
SELECT 
    month_name, SUM(sales_amount) AS total_revenue
FROM
    transactions t
        INNER JOIN
    date d ON t.order_date = d.date
WHERE
    d.year = 2019
GROUP BY month_name;

-- Month of greatest sales revenue
SELECT 
    month_name, SUM(sales_amount) AS total_revenue
FROM
    transactions t
        INNER JOIN
    date d ON t.order_date = d.date
WHERE
    d.year = 2019
GROUP BY month_name
ORDER BY total_revenue DESC
LIMIT 1;
    