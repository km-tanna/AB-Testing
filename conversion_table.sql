create or replace table resolute-cat-412100.abtest.final_table as (select experiment, (select count(*) from `resolute-cat-412100.abtest.test_table` where experiment = 'control' and yes = 1)/
(select count(*) from `resolute-cat-412100.abtest.test_table` where experiment = 'control' and (yes = 1 or `no` = 1)) as
conversion_rate,
(select count(*) from `resolute-cat-412100.abtest.test_table` where experiment = 'control' and yes = 1) as yes_rate,
(select count(*) from `resolute-cat-412100.abtest.test_table` where experiment = 'control' and `no` = 1) as no_rate,
((select count(*) from `resolute-cat-412100.abtest.test_table` where experiment = 'control' and yes = 1) + (select count(*) from
`resolute-cat-412100.abtest.test_table` where experiment = 'control' and `no` = 1)) as total_response
from `resolute-cat-412100.abtest.test_table`
where experiment = 'control'
group by experiment
union all
select experiment, (select count(*) from `resolute-cat-412100.abtest.test_table` where experiment = 'exposed' and yes = 1)/
(select count(*) from `resolute-cat-412100.abtest.test_table` where experiment = 'exposed' and (yes = 1 or `no` = 1)) as
conversion_rate,
(select count(*) from `resolute-cat-412100.abtest.test_table` where experiment= 'exposed' and yes = 1) as yes_rate,
(select count(*) from `resolute-cat-412100.abtest.test_table` where experiment = 'exposed' and `no` = 1) as no_rate,
((select count(*) from `resolute-cat-412100.abtest.test_table` where experiment = 'exposed' and yes = 1) + (select count(*)
from `resolute-cat-412100.abtest.test_table` where experiment = 'exposed' and `no` = 1)) as total_response
from `resolute-cat-412100.abtest.test_table` table
where experiment = 'exposed'
group by
experiment
union all
select 'total' as experiment, (select count(*) from `resolute-cat-412100.abtest.test_table` where yes = 1)/
(select count(*) from `resolute-cat-412100.abtest.test_table` where yes = 1 or `no` = 1) as conversion_rate,
((select count(*) from `resolute-cat-412100.abtest.test_table` where experiment = 'control' and yes = 1) + (select count(*) from
`resolute-cat-412100.abtest.test_table`where experiment = 'exposed' and yes = 1)) as yes_rate,
((select count(*) from `resolute-cat-412100.abtest.test_table` where experiment = 'control' and `no` = 1) + (select count(*) from
`resolute-cat-412100.abtest.test_table` where experiment = 'exposed' and `no` = 1)) as no_rate,
(((select count(*) from `resolute-cat-412100.abtest.test_table` where experiment = 'control' and yes = 1) + (select count(*) from
`resolute-cat-412100.abtest.test_table` where experiment = 'control' and `no` = 1)) + ((select count(*) from `resolute-cat-412100.abtest.test_table`
where experiment = 'exposed' and yes = 1) + (select count(*) from `resolute-cat-412100.abtest.test_table` table where experiment = 'exposed' and `no` = 1)))
from `resolute-cat-412100.abtest.test_table`
group by
experiment);
