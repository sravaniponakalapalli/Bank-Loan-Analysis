create database bank_loan
use bank_loan

select *
from loan_data

/* Total Loan Applications */
select COUNT(id) as loan_applications
from loan_data
-- MTD
select COUNT(id) as loan_applications
from loan_data
where MONTH(issue_date) = 12
-- PMTD
select COUNT(id) as loan_applications
from loan_data
where MONTH(issue_date) = 11

/* Total Funded Amount */
select SUM(loan_amount) as total_fund_amt
from loan_data
-- MTD
select SUM(loan_amount) as total_fund_amt
from loan_data
where MONTH(issue_date) = 12
-- PMTD
select SUM(loan_amount) as total_fund_amt
from loan_data
where MONTH(issue_date) = 11

/* Total Amount Recieved */
select SUM(total_payment) as total_amt
from loan_data
-- MTD
select SUM(total_payment) as total_amt
from loan_data
where MONTH(issue_date) = 12
-- PMTD
select SUM(total_payment) as total_amt
from loan_data
where MONTH(issue_date) = 11

/* Average Intrest Rate */
select AVG(int_rate) as avg_int_rate
from loan_data
-- MTD
select AVG(int_rate) as avg_int_rate
from loan_data
where MONTH(issue_date) = 12
-- PMTD
select AVG(int_rate) as avg_int_rate
from loan_data
where MONTH(issue_date) = 11

/* Average DTI */
select AVG(dti) as avg_dti
from loan_data
-- MTD
select AVG(dti) as avg_dti
from loan_data
where MONTH(issue_date) = 12
-- PMTD
select AVG(dti) as avg_dti
from loan_data
where MONTH(issue_date) = 11

--- Good Loan ----
/* Good Loan Appication Percentage */
select (COUNT(case when loan_status='Fully Paid' or loan_status='current' then id end)*100.0)/COUNT(id) as good_app_percent
from loan_data
/* Good Loan Applications */
select COUNT(id) as good_loan_appications
from loan_data
where loan_status = 'fully paid' or loan_status = 'current'
/* Good Loan Funded Amount */
select SUM(loan_amount) as good_l_funded_amt
from loan_data
where loan_status = 'fully paid' or loan_status = 'current'
/* Good Loan Total Recieved Amount */
select SUM(total_payment) as good_l_recieved_amt
from loan_data
where loan_status = 'fully paid' or loan_status = 'current'

--- Bad Loan ----
/* Bad Loan Appication Percentage */
select (COUNT(case when loan_status='charged off' then id end)*100.0)/COUNT(id) as bad_loan_app_percent
from loan_data
/* Bad Loan Applications */
select COUNT(id) as bad_loan_app
from loan_data
where loan_status='charged off'
/* Bad Loan Funded Amount */
select SUM(loan_amount) as bad_l_funded_amt
from loan_data
where loan_status='charged off'
/* Bad Loan Total Recieved Amount */
select SUM(total_payment) as bad_l_total_recieve_amt
from loan_data
where loan_status='charged off'

/* Loan Status */
with cte1 as(
select loan_status,COUNT(id) as loan_applications,SUM(loan_amount) as funded_amt,SUM(total_payment) as recieved_amt,AVG(int_rate)*100.0 as avg_interest_rate,AVG(dti)*100.0 as avg_dti
from loan_data
group by loan_status
),
cte2 as(
select loan_status,SUM(loan_amount) as mtd_funded_amt,SUM(total_payment) as mtd_recieved_amt
from loan_data
where MONTH(issue_date) = 12
group by loan_status
)
select c1.loan_status,loan_applications,funded_amt,recieved_amt,avg_interest_rate,avg_dti,mtd_funded_amt,mtd_recieved_amt
from cte1 c1
join cte2 c2
on c1.loan_status = c2.loan_status

/* Month */
select MONTH(issue_date) as month_no,DATENAME(month,issue_date) as month_name,COUNT(id) as no_applicants,SUM(loan_amount) as total_fundamount,SUM(total_payment) as total_recievedamt
from loan_data
group by MONTH(issue_date),DATENAME(month,issue_date)
order by month_no

/* State */
select address_state as states,COUNT(id) as no_applicants,SUM(loan_amount) as fundedamt,SUM(total_payment) as recievedamt
from loan_data
group by address_state
order by address_state

/* Term */
select term,COUNT(id) as no_applicants,SUM(loan_amount) as fundedamt,SUM(total_payment) as recievedamt
from loan_data
group by term
order by term

/* Employeelength */
select emp_length,count(id) as no_applicants,SUM(loan_amount) as fundedamt,SUM(total_payment) as recievedamt
from loan_data
group by emp_length
order by emp_length

/* Purpose */
select purpose,COUNT(id) as no_applicants,SUM(loan_amount) as fundedamt,SUM(total_payment) as recievedamt
from loan_data
group by purpose
order by purpose

/* Home Ownership */
select home_ownership,COUNT(id) as no_applicants,SUM(loan_amount) as fundedamt,SUM(total_payment) as recievedamt
from loan_data
group by home_ownership
order by home_ownership


select *
from loan_data