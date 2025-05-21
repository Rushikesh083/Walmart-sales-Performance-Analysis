#Task 9: Finding Top 5 Customers by Sales Volume (6 Marks)
#Walmart wants to reward its top 5 customers who have generated the most sales Revenue.

select `Customer ID`, round(sum(Total),2) as total_sales 
from walmartsales
group by `Customer ID`
order by total_sales DESC
LIMIT 5;
