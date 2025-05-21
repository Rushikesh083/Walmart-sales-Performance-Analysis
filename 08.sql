#Task 8: Identifying Repeat Customers (6 Marks)
#Walmart needs to identify customers who made repeat purchases within a specific time frame (e.g., within 30 days).

#Repeat Customers within 4 days.

-- Step 1: Rank Transactions by Customer and Date
WITH RankedTransactions AS (
    SELECT
        `Customer ID`,
        `new_date_column` AS transaction_date,
        ROW_NUMBER() OVER (PARTITION BY `Customer ID` ORDER BY `new_date_column` ASC) AS txn_rank
    FROM
        `walmartsales`
),

-- Step 2: Calculate Days Between Consecutive Transactions
DateDifferences AS (
    SELECT
        t1.`Customer ID`,
        t1.transaction_date AS purchase_date,
        t2.transaction_date AS next_purchase_date,
        DATEDIFF(t2.transaction_date, t1.transaction_date) AS days_between_purchases
    FROM
        RankedTransactions t1
    LEFT JOIN
        RankedTransactions t2
    ON
        t1.`Customer ID` = t2.`Customer ID`
        AND t1.txn_rank + 1 = t2.txn_rank
)

-- Step 3: Filter Customers with Repeat Purchases Within 30 Days and Count Transactions
SELECT
    `Customer ID`,
    COUNT(*) AS repeat_purchase_count -- Count repeat transactions
FROM
    DateDifferences
WHERE
    days_between_purchases > 0 -- Exclude same-day transactions
    AND days_between_purchases <= 4 -- Only transactions within 30 days
GROUP BY
    `Customer ID`
ORDER BY
    repeat_purchase_count DESC; -- Sort by the highest number of repeat purchases