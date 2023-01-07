-- week 25
-- https://frostyfridaychallenges.s3.eu-west-1.amazonaws.com/challenge_25/ber_7d_oct_clim.json
use role sysadmin;
create or replace file format json_file_format
    type='json';
create or replace stage weather_raw
    url='s3://frostyfridaychallenges/challenge_25';
list @weather_raw;

create or replace table weather_parsed (
    raw variant);
copy into weather_parsed
    from @weather_raw/ber_7d_oct_clim.json
    file_format=(format_name=json_file_format);
select * from weather_parsed;

select value
from weather_parsed
,LATERAL FLATTEN(input => raw:weather);

create or replace view curated_view as
select value:timestamp::timestamp as Date, 
       value:icon::text as icon,
       value:temperature::number(5,2) as temperature,
       value:precipitation::number(5,2) as precipitation,
       value:wind_speed::number(5,2) as wind,
       value:relative_humidity::number(5,2) as humidity       
from weather_parsed
,LATERAL FLATTEN(input => raw:weather);

select * from curated_view;

create or replace table weather_agg as
select date_trunc(day,date) as date, 
       array_agg(distinct icon) within group (order by icon) as icon_array, 
       avg(temperature) as avg_temperature, 
       sum(precipitation) as total_precipitation,
       avg(wind) as avg_wind,
       avg(humidity) as avg_humidity
       from curated_view group by date_trunc(day,date) 
       order by date_trunc(day,date) desc;

select * from weather_agg;
