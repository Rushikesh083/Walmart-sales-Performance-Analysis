#Task 1: Identifying the Top Branch by Sales Growth Rate (6 Marks)
#Walmart wants to identify which branch has exhibited the highest sales growth over time. 
#Analyze the total sales for each branch and compare the growth rate across months to find the top performer.

-- Step 1: Aggregate Monthly Sales for Each Branch
WITH MonthlySales AS (
    SELECT
        Branch, 
        DATE_FORMAT(new_date_column, '%Y-%m') AS sales_month, -- Extract Year-Month from the `Date` column
        round(SUM(Total),2) AS monthly_sales -- Sum of the `Total` column for monthly sales
    FROM 
        walmartsales
    GROUP BY 
        Branch, DATE_FORMAT(new_date_column, '%Y-%m')
),

-- Step 2: Calculate Month-over-Month Growth
MonthlyGrowth AS (
    SELECT
        Branch,
        sales_month,
        monthly_sales,
        LAG(monthly_sales) OVER (PARTITION BY Branch ORDER BY sales_month) AS prev_month_sales,
        CASE
            WHEN LAG(monthly_sales) OVER (PARTITION BY Branch ORDER BY sales_month) IS NOT NULL 
            THEN (monthly_sales - LAG(monthly_sales) OVER (PARTITION BY Branch ORDER BY sales_month)) 
                 / LAG(monthly_sales) OVER (PARTITION BY Branch ORDER BY sales_month)
            ELSE NULL
        END AS growth_rate
    FROM
        MonthlySales
),

-- Step 3: Calculate Average Growth Rate for Each Branch
BranchGrowth AS (
    SELECT
        Branch,
        round(AVG(growth_rate),2) AS avg_growth_rate -- Average growth rate for each branch
    FROM
        MonthlyGrowth
    WHERE 
        growth_rate IS NOT NULL -- Exclude rows with no previous month
    GROUP BY
        Branch
)

-- Step 4: Identify the Top Branch
SELECT
    Branch,
    avg_growth_rate
FROM
    BranchGrowth
ORDER BY
    avg_growth_rate DESC;




#Total sales for all months by Branch

select Branch, round(sum(cogs),2) from walmartsales
group by Branch,month(date)
order by branch;