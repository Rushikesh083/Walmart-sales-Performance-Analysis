# Task 3: Analyzing Customer Segmentation Based on Spending (6 Marks)
#Walmart wants to segment customers based on their average spending behavior. 
#Classify customers into three tiers: High, Medium, and Low spenders based on their total purchase amounts.


SELECT
    `Customer ID`,
    round(SUM(Total),2) AS total_spending,
    CASE
        WHEN SUM(Total) < 20000 THEN 'Low Spender'
        WHEN SUM(Total) BETWEEN 20000 AND 22000 THEN 'Medium Spender'
        ELSE 'High Spender'
    END AS spending_tier
FROM
    walmartsales
GROUP BY
    `Customer ID`
ORDER BY
    `Customer ID`;