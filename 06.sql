#Task 6: Monthly Sales Distribution by Gender (6 Marks)
#Walmart wants to understand the sales distribution between male and female customers on a monthly basis.

SELECT
        DATE_FORMAT(new_date_column, '%Y-%m') AS sales_month, -- Extract Year-Month from Date
        Gender,
        round(SUM(Total),2) AS total_sales -- Sum of sales by Gender and Month
    FROM
        walmartsales
    GROUP BY
        DATE_FORMAT(new_date_column, '%Y-%m'), Gender;