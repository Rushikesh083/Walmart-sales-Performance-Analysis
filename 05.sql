#Task 5: Most Popular Payment Method by City (6 Marks)
#Walmart needs to determine the most popular payment method in each city to tailor marketing strategies.

-- Step 1: Count Payment Method Usage by City
WITH PaymentCounts AS (
    SELECT
        City,
        Payment,
        COUNT(*) AS payment_count -- Count the number of transactions for each payment method
    FROM
        walmartsales
    GROUP BY
        City, Payment
),

-- Step 2: Rank Payment Methods by Popularity Within Each City
RankedPayments AS (
    SELECT
        City,
        Payment,
        payment_count,
        RANK() OVER (PARTITION BY City ORDER BY payment_count DESC) AS payment_rank
    FROM
        PaymentCounts
)

-- Step 3: Select the Most Popular Payment Method in Each City
SELECT
    City,
    Payment AS most_popular_payment_method,
    payment_count
FROM
    RankedPayments
WHERE
    payment_rank = 1
ORDER BY
    City;
