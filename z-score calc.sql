with cte1 as (select conversion_rate * (1- conversion_rate) as part1, 'formula' as formula
from `resolute-cat-412100.abtest.final_table`
where experiment = 'total'),

cte2 as (select 1/total_response as part2, 'formula' as formula
from `resolute-cat-412100.abtest.final_table`
where experiment = 'control'),

cte3 as (select 1/total_response as part3, 'formula' as formula
from `resolute-cat-412100.abtest.final_table`
where experiment = 'exposed'),

cte4 as (select part1*(part2 +part3) as se, a.formula from 
cte1 a
join cte2 b
on a.formula= b.formula
join cte3 c
on c.formula = a.formula),

p1 as (select conversion_rate, 'formula' as formula
from `resolute-cat-412100.abtest.final_table` 
where experiment = 'exposed' ),

p2 as (select conversion_rate, 'formula' as formula
from `resolute-cat-412100.abtest.final_table` 
where experiment = 'control')

select a.num/sqrt(b.SE) 
from (select p1.conversion_rate - p2.conversion_rate as num, p1.formula
from p1
join p2
on p1.formula = p2.formula) a
join cte4 b
on a.formula = b.formula;
