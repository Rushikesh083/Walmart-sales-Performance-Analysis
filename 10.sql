#Task 10: Analyzing Sales Trends by Day of the Week (6 Marks)
#Walmart wants to analyze the sales patterns to determine which day of the week brings the highest sales.

-- Calculate total sales by day of the week
SELECT
    DAYNAME(`new_date_column`) AS day_of_week, -- Extract the day of the week
    round(SUM(`Total`),2) AS total_sales -- Sum up the sales for each day
FROM
    `walmartsales`
GROUP BY
    DAYNAME(`new_date_column`) -- Group by the day of the week
ORDER BY
    total_sales DESC; -- Order by highest sales


