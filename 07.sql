# Task 7: Best Product Line by Customer Type (6 Marks)
# Walmart wants to know which product lines are preferred by different customer types(Member vs. Normal).

-- Step 1: Calculate Total Sales for Each Product Line and Customer Type
WITH ProductLineSales AS (
    SELECT
        `Customer type`,
        `Product line`,
		round(SUM(Total),2) AS total_sales -- Total sales for each product line and customer type
    FROM
        walmartsales
    GROUP BY
        `Customer type`, `Product line`
),

-- Step 2: Rank Product Lines by Sales for Each Customer Type
RankedProductLines AS (
    SELECT
        `Customer type`,
        `Product line`,
        total_sales,
        RANK() OVER (PARTITION BY `Customer type` ORDER BY total_sales DESC) AS sales_rank -- Rank by sales
    FROM
        ProductLineSales
)

-- Step 3: Retrieve the Most Preferred Product Line for Each Customer Type
SELECT
    `Customer type`,
    `Product line` AS best_product_line,
    total_sales
FROM
    RankedProductLines
WHERE
    sales_rank = 1
ORDER BY
    `Customer type`;
