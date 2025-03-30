-- response rate for control group yes+ NO / total

select experiment, (select count() from resolute-cat-412100.abtest.abtest where experiment = 'control' and yes = 1 or ⁠ no ⁠ = 1 ) / (select count() from resolute-cat-412100.abtest.abtest where experiment = 'control' )
from resolute-cat-412100.abtest.abtest
where experiment = 'control'
group by 
experiment

---> control   0.33387292594091461


--- response rate for exposed group yes+ NO / total

select experiment, (select count() from resolute-cat-412100.abtest.abtest where experiment = 'exposed' and yes = 1 or ⁠ no ⁠ = 1 ) / (select count() from resolute-cat-412100.abtest.abtest where experiment = 'exposed' )
from resolute-cat-412100.abtest.abtest
where experiment = 'exposed'
group by 
experiment

---> exposed  0.18908312522297538

-- yes/yes+no how many people responded yes out of total resonse for control

select experiment, (select count() from resolute-cat-412100.abtest.abtest where experiment = 'control' and yes = 1 ) / (select count() from resolute-cat-412100.abtest.abtest where experiment = 'control' and yes = 1 or ⁠ no ⁠ = 1 )
from resolute-cat-412100.abtest.abtest
where experiment = 'control'
group by 
experiment

--> control   0.19878787878787879

-- yes/yes+no how many people responded yes out of total resonse for exposed

select experiment, (select count() from resolute-cat-412100.abtest.abtest where experiment = 'exposed' and yes = 1 ) / (select count() from resolute-cat-412100.abtest.abtest where experiment = 'exposed' and yes = 1 or ⁠ no ⁠ = 1 )
from resolute-cat-412100.abtest.abtest
where experiment = 'exposed'
group by 
experiment

---> exposed  0.37641509433962
