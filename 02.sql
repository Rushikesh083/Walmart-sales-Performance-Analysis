#Task 2: Finding the Most Profitable Product Line for Each Branch (6 Marks)
#Walmart needs to determine which product line contributes the highest profit to each branch.
#The profit margin should be calculated based on the difference between the gross income and cost of goods sold.

-- Step 1: Calculate Profit Margin for Each Product Line and Branch
WITH ProfitData AS (
    SELECT
        Branch,
        `Product line`,
        round(SUM(`cogs` - `gross income`),2) AS total_profit -- Calculate profit for each product line and branch
    FROM 
        walmartsales
    GROUP BY 
        Branch, `Product line`
),

-- Step 2: Rank Product Lines by Profit Within Each Branch
RankedProfit AS (
    SELECT
        Branch,
        `Product line`,
        total_profit,
        RANK() OVER (PARTITION BY Branch ORDER BY total_profit DESC) AS profit_rank
    FROM
        ProfitData
)

-- Step 3: Retrieve the Most Profitable Product Line for Each Branch
SELECT
    Branch,
    `Product line`,
    total_profit
FROM
    RankedProfit
WHERE 
    profit_rank = 1;
