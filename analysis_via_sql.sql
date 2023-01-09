
# SQL Data Analysis #

#1. Show all customer records
select *
from customers

#2. Show total number of customers
select count(*)
from customers

#3. Show transactions for Chennai market (market code for chennai is Mark001
select * 
from markets m
join transactions t
on m.markets_code = t.market_code
where m.markets_name = "Chennai"

#4. Show distrinct product codes that were sold in chennai
select count(distinct t.product_code)
from markets m
join transactions t
on m.markets_code = t.market_code
where m.markets_name = "Chennai"


#5. Show transactions where currency is US dollars
select *
from transactions t
where currency = "USD"


#6. Show transactions in 2020 join by date table
select *
from transactions t
join date d
on d.date = t.order_date
and d.year = 2020

#7. Show total revenue in year 2020,
select sum(t.sales_amount)
from transactions t
join date d
on d.date = t.order_date
and d.year = 2020 and t.currency = "INR"
	
#8. Show total revenue in year 2020, January Month,
select sum(t.sales_amount)
from transactions t
join date d
on d.date = t.order_date
and d.year = 2020 and t.currency = "INR" and month(order_date) = 1


#9. Show total revenue in year 2020 in Chennai
select sum(t.sales_amount)
from transactions t
join date d
on d.date = t.order_date
and d.year = 2020 and t.currency = "INR"
and t.market_code = (select markets_code from markets where markets_name = "Chennai")

#10 Show the total profit for each region for each year
select m.markets_name, d.year, sum(profit_margin) total_profit
from transactions t
join date d
on d.date = t.order_date
join markets m
on m.markets_code = t.market_code
group by 1,2
order by 1,2



# Power BI Transformation (Data Cleaning) #
#1- Markets table: removing cities with Null zones.
= Table.SelectRows(sales_markets, each ([zone] <> ""))


#2- Transactions table: Transforming sales amounts from "USD" to "INR" currency
= Table.AddColumn(#"Filtered Rows", "norm_sales_amount", each if [currency] = "USD" then [sales_amount]*75 else [sales_amount], type any)



# Power BI measures creation to use for visualization and analysis #
#1- Revenue forumula:
Revenue = SUM('Sales transactions'[norm_sales_amount])

#2- Sales Qty forumula:
Sales Qty = SUM('sales transactions'[sales_qty])

#3- Total Profit forumula:
Total Profit Margin = SUM('Sales transactions'[Profit_Margin])
