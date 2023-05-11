
select * from dbo.Bank_Customer_Churn_Prediction

-- check dublicates?
select customer_id, COUNT(*) 
from Bank_Customer_Churn_Prediction
group by customer_id
having COUNT(*)>1
-- which country have best credit score?
select country, AVG(credit_score) as avg_score
from Bank_Customer_Churn_Prediction
group by country
order by avg_score desc;

-- female or male percent in churn with cte

with Female_perc as ( select customer_id from Bank_Customer_Churn_Prediction 
where gender='Female' and churn=1)

select  (count(f.customer_id)*100)/count(b.customer_id) as female_per,
		100-(count(f.customer_id)*100)/count(b.customer_id) as male_per
from Bank_Customer_Churn_Prediction b
 full join Female_perc f on b.customer_id=f.customer_id
 where churn=1
 
-- how many customer have credit cards?
select credit_card, count(credit_card)  as credit_card
from Bank_Customer_Churn_Prediction
group by credit_card

-- how many percent have active member
select (count(*)*100)/10000 from Bank_Customer_Churn_Prediction
where active_member=1
-- how many percent have credit card
select (count(*)*100)/10000 from Bank_Customer_Churn_Prediction
where credit_card=1

--balance for each country

select country, format(sum( cast(balance as numeric)),'#,###.###') as sum_balance 
from Bank_Customer_Churn_Prediction
group by country
order by sum_balance

--avg churn age for each gender

select gender, case when gender='Female' then AVG(age)
			when gender='Male' then avg(age) else 'unkwon' end as avg_age
from Bank_Customer_Churn_Prediction
where churn=1
group by gender

-- how many customer has left bank

select churn, count(*) as count_churn from Bank_Customer_Churn_Prediction
group by churn

--product_number vs churn

select products_number, count(*) as churn_number
from Bank_Customer_Churn_Prediction
where churn=1
group by products_number
order by churn_number asc

--churn vs country

select country,count(churn) as count_churn from Bank_Customer_Churn_Prediction
where churn=1
group by country
order by count_churn

--age vs churn

select top 10 age, count(*) as count_churn from	Bank_Customer_Churn_Prediction
where churn=1
group by age
order by count(*) desc

-- tenure years vs churn

select tenure, count(churn) as count_churn from Bank_Customer_Churn_Prediction
where churn=1
group by tenure
order by count(churn) desc

--churn , country vs age

select top 10 country,age,count(churn) as churned from Bank_Customer_Churn_Prediction
where churn=1
group by  cube(country, age)
order by churned desc

--credit card and churn

select credit_card,count(churn) as count_churn from Bank_Customer_Churn_Prediction
where churn=1
group by credit_card

--credit score vs churn

select top 10 credit_score, count(churn) as count_churn from Bank_Customer_Churn_Prediction
group by credit_score
order by count_churn desc

-- country,balance vs churn

select country, churn, format(sum(cast(balance as numeric)),'#,###.###') as churn_balance 
from Bank_Customer_Churn_Prediction
group by country,churn
order by country,churn_balance

--gender,estimated_salary vs churn

select gender, churn, format(sum(cast(estimated_salary as numeric)),'#,###.###') as churn_salary 
from Bank_Customer_Churn_Prediction
group by gender,churn
order by churn,churn_salary

