describe hr_1;
describe hr_2;
-- combine datasets

select * 
From 
Hr_1 
join hr_2
on hr_1.employeenumber = hr_2.EmployeeID;

-- KPI 1 — Average Attrition Rate for all Departments

select department, round(sum(case when attrition = "Yes" then 1 else 0 end)*100/ count(*),2) as Att_rate from combined group by department;

-- KPI 2 — Average Hourly Rate of Male Research Scientist

select round( avg(hourlyrate),2) as Avgerage_rate from combined where gender = "Male" and jobrole = "Research Scientist";

-- KPI 3 — Attrition Rate vs Monthly Income Stats

select case
WHEN MonthlyIncome < 5000 THEN 'Less than 5000'
WHEN MonthlyIncome BETWEEN 5000 AND 10000 THEN '5000 to 10000'
ELSE 'More than 10000'
END AS Income_Category,  round(sum(case when attrition = "Yes" then 1 else 0 end)*100/ count(*),2) as Att_rate from combined group by income_category ;

-- KPI 4 — Average Working Years for Each Department

select round(avg(totalworkingyears),2) as Years_at_Company ,	 department from combined group by department;

-- KPI 5 — Job Role vs Work Life Balance

select round(avg(worklifebalance),2) as Work_Life , jobrole from combined group by jobrole;

-- KPI 6 — Attrition Rate vs Years Since Last Promotion
SELECT 
CASE
    WHEN YearsSinceLastPromotion <= 2 THEN '0-2'
    WHEN YearsSinceLastPromotion BETWEEN 3 AND 5 THEN '3-5'
    ELSE '6+'
END AS Promotion_Group,
COUNT(*) AS TotalEmployees,
round(sum(case when attrition = "Yes" then 1 else 0 end)*100/ count(*),2) as Att_rate
FROM combined
GROUP BY promotion_group
ORDER BY promotion_group;

