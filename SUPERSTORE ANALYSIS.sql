
-- Looking at the dataset

select *
from skillphore..superstore



-- 1. How does the revenue vary across different branches
-- Quantity multiplied by unit price gives the revenue as COGS in the dataset   

select Branch, SUM(COGS) Revenue
from skillphore..superstore
group by Branch
order by Revenue desc


-- 2. Identify the top-selling product lines and the least popular ones

select ProductLine, SUM(Quantity) AS Total_Quantity
from skillphore..superstore
group by ProductLine
order by Total_Quantity DESC


-- 3. What is the distribution of customer types (Members vs Normal)

select CustomerType, COUNT(*) CS_Distribution, sum(Quantity) 
Quantity_Sum, round(avg(GrossIncome),2) Avg_GrossIncome
from skillphore..superstore
group by CustomerType
order by CS_Distribution DESC


-- 4. What are the preferred payment methods for customers

Select Payment, COUNT(*) PreferredPayment
from skillphore..superstore
group by Payment
order by PreferredPayment DESC


-- 5. Is there a correlation between payment method and total purchase amount

select Payment, COUNT(Payment) Payment_Count, SUM(Total) Total_Purchase
from skillphore..superstore
group by Payment
order by Payment_Count


WITH PaymentMethodTotal AS (
    select Payment, SUM(Total) AS total_purchase, AVG(Total) AS avg_total
    from skillphore..superstore
    group by Payment
)

SELECT 
    (select SUM((total_purchase - avg_total) * (total_purchase - avg_total))
    from PaymentMethodTotal) / 
    ((COUNT(Payment) - 1) * SUM(total_purchase * total_purchase)) AS correlation
FROM PaymentMethodTotal;


-- 6. How do the different branches compare in terms of customer ratings

select Branch, ROUND(AVG(Rating),2) Avg_Rating
from skillphore..superstore
group by Branch, City
order by Avg_Rating desc


-- 7. Which of the branches has more of the highest customer rating

select Branch, MAX(Rating) Max_Rating, COUNT(Rating) Highest_Rating_Count
from skillphore..superstore
where Rating = 10
group by Branch
order by Highest_Rating_Count DESC



-- 8. Which gender purchases the most

select Gender, sum(Quantity) Most_Purchase, sum(GrossIncome) Total_GrossIncome
from skillphore..superstore
group by Gender
order by Most_Purchase DESC


