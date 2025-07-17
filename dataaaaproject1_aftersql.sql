select * from dataaproject1;

-- how many states where represented in dataset
SELECT Count(distinct(State))
FROM dataaproject1;


-- what was the average time of men vs women
SELECT Gender, avg(total_minutes)
FROM dataaproject1
group by Gender;

-- WHAT WAS THE YONGEST AND OLEDEST AGE IN THE RACE
SELECT Gender, min(Age) AS Yongest, max(Age) as oldest
FROM dataaproject1
group by Gender;

-- what was the averge time of each age group
WITH age_buckets as (
SELECT total_minutes,
	case WHEN Age<30 then 'age 20-29'
	     WHEN Age<40 then 'age 30-39'
		 WHEN Age<50 then 'age 40-49'
		 WHEN Age<60 then 'age 50-59'
	else 'age 60+' end as age_group
from dataaproject1
)
select age_group, avg(total_minutes) as race_time
from age_buckets
group by age_group
order by race_time;


-- top 3 males and females
with gender_rank as ( 
select	 rank() over (partition by Gender order by total_minutes asc) as gender_rank,
full_name, 
total_minutes, 
Gender
from dataaproject1
)
select * 
from gender_rank
where gender_rank<4
order by total_minutes;