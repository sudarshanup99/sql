SELECT *FROM sdn.aven_organization;
USE sdn;
desc sdn.aven_organization;
alter table sdn.aven_organization add phone_no int;
alter table sdn.aven_organization change `row` sn int not null primary key;

update sdn.aven_organization set phone_no=980400132 where sn=1;
ALTER TABLE sdn.aven_organization MODIFY COLUMN phone_no int AFTER sn;
SELECT effective_date,expiration_date,DATEDIFF(expiration_date, effective_date) AS subtracted_time FROM sdn.aven_organization;
ALTER TABLE aven_organization ADD COLUMN subtracted_time INT;
update aven_organization set subtracted_time= datediff(expiration_date,effective_date);
select * from information_schema.tables;
select sn, phone_no,subtracted_time from aven_organization order by sn asc, subtracted_time desc ;
-- for searching with value
select * from aven_organization where property_id > 10020 and property_id<10128;
-- for searching
select count(*) as number_of_citieswiths  from aven_organization where city like 'S%';

-- having
select lease_status,count(lease_status),decision_fico from sdn.aven_organization group by lease_status,decision_fico having decision_fico>640;
-- select count(*) from sdn.aven_organization ;
-- to change data type 
alter table aven_organization drop column market_date ;

SELECT CAST(market_value_date AS DATE) AS market_date FROM sdn.aven_organization;
update sdn.aven_organization set market_date= CAST(market_value_date AS DATE) ;
--  using of case statement 
SELECT city,state,subtracted_time,  CASE WHEN subtracted_time > 600 THEN 'enough time' WHEN subtracted_time BETWEEN 365 AND 600 THEN 'nearly matured' ELSE 'matured' END FROM sdn.aven_organization WHERE subtracted_time IS NOT NULL ORDER BY subtracted_time;
-- TO REPLACE THE STRINGS
select city ,replace(city,'SANDY','BEACH') as fixedcell from sdn.aven_organization;

-- substring
select city, substring(city,1,3) as extractedstring from sdn.aven_organization order by city;

-- lowercase
select city, lower(city) as lowercasecity from sdn.aven_organization ;

-- subquery 
select property_id,monthly_payment,(select avg(monthly_payment) from sdn.aven_organization) as allavgmonthly from sdn.aven_organization;
select city,(select avg(monthly_payment) from sdn.aven_organization) AVGH  from sdn.aven_organization group by city order by city;

-- with partition by
SELECT property_id, city,monthly_payment, AVG(monthly_payment) OVER () AS
AllAvgSalary
FROM sdn.aven_organization;

-- with from
SELECT property_id, monthly_payment
FROM (
    SELECT property_id, monthly_payment, AVG(monthly_payment) OVER () AS AllAvgSalary
    FROM sdn.aven_organization
) AS subquery
ORDER BY property_id;

-- subquery with where
SELECT property_id, monthly_payment, city
FROM sdn.aven_organization
WHERE monthly_payment=(
    SELECT min(monthly_payment) FROM sdn.aven_organization
);

-- full outer join
SELECT aven_organization.property_id, city,new_table.age
FROM sdn.aven_organization
LEFT JOIN new_table ON aven_organization.property_id = new_table.property_id
UNION
SELECT aven_organization.property_id, city,new_table.age
FROM sdn.aven_organization
RIGHT JOIN new_table ON aven_organization.property_id = new_table.property_id order by property_id
;






