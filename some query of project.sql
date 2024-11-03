SELECT * FROM python_sql_project.orders;

# QUESTION-11:=>CALCULATE THE MOVING AVERAGE OF ORDER VALUES FOR EACH CUSTOMER OVER THEIR ORDER HISTORY ?

with a1 as
(SELECT orders.customer_id as cus_id,orders.order_purchase_timestamp as time_stamp,
payments.payment_value as payment
from orders join payments
on orders.order_id=payments.order_id)

select  cus_id,time_stamp,payment,
round(avg(payment) over (partition by cus_id order by time_stamp rows between 2 preceding and current row),2)
as moving_avg
from a1 order by 
round(avg(payment)
 over (partition by cus_id order by time_stamp rows between 2 preceding and current row),2) desc;
 



# QUESTION-12:=>CALCULATE THE COMMULATIVE SALES PER MONTH FOR EACH YEAR ?-- 

with temp as (select year(orders.order_purchase_timestamp) as years,month(orders.order_purchase_timestamp) 
as months,
round(sum(payments.payment_value),2) as payment from
orders join payments
on orders.order_id=payments.order_id
group by year(orders.order_purchase_timestamp),month(orders.order_purchase_timestamp)
order by year(orders.order_purchase_timestamp),month(orders.order_purchase_timestamp))

select *,sum(payment) over(order by years,months)
from temp;


 # QUESTION-13:=>CALCULATE THE YEAR OVER YEAR GROTH OF TOTAL SALES ?
 
 with temp as
 (select YEAR(orders.order_purchase_timestamp) as years,round(sum(payments.payment_value),2)
 as total_sales
 from orders join payments
 on orders.order_id=payments.order_id
 group by YEAR(orders.order_purchase_timestamp)
 order by YEAR(orders.order_purchase_timestamp))
 
 select years,total_sales, ((total_sales-lag(total_sales,1) over(order by years))
 /lag(total_sales,1) over(order by years))*100
 from temp
order by years;
