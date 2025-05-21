# Task 4: Detecting Anomalies in Sales Transactions (6 Marks)
# Walmart suspects that some transactions have unusually high or low sales compared to the average for the
# product line. Identify these anomalies.

-- Step 1: Calculate Mean and Standard Deviation for Each Product Line
WITH ProductLineStats AS (
    SELECT
        `Product line`,
        round(AVG(Total),2) AS avg_sales,            -- Average sales for the product line
        round(STDDEV(Total),2) AS std_dev_sales       -- Standard deviation of sales
    FROM
        walmartsales
    GROUP BY
        `Product line`
),

-- Step 2: Identify Transactions Outside the Normal Range
Anomalies AS (
    SELECT
        ws.`Invoice ID`,
        ws.Branch,
        ws.`Product line`,
        ws.Total,
        pls.avg_sales,
        pls.std_dev_sales,
        -- Calculate Z-Score for each transaction
        (ws.Total - pls.avg_sales) / pls.std_dev_sales AS z_score
    FROM
        walmartsales ws
    JOIN
        ProductLineStats pls
    ON
        ws.`Product line` = pls.`Product line`
    WHERE
        ABS(ws.Total - pls.avg_sales) > 2 * pls.std_dev_sales -- Anomalies: Beyond 2 standard deviations
)

-- Step 3: Display the Anomalous Transactions
SELECT
    `Invoice ID`,
    Branch,
    `Product line`,
    Total,
    avg_sales,
    std_dev_sales,
    ROUND(z_score, 2) AS z_score
FROM
    Anomalies
ORDER BY
    z_score DESC;

