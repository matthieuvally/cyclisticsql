--Total number of trips for annual members vs. casual riders
SELECT
usertype,
COUNT(trip_id) as number_of_trips
FROM cyclistic..data
WHERE usertype IS NOT NULL
GROUP BY usertype
ORDER BY COUNT(trip_id) DESC

--Total number of trips for annual members vs. casual riders per month

SELECT
DATEADD(MONTH, DATEDIFF(MONTH, 0, start_date), 0) AS month,
COUNT(CASE WHEN usertype = 'member' THEN 1 END) AS annual_members,
COUNT(CASE WHEN usertype = 'casual' THEN 1 END) AS casual_riders,
COUNT(trip_id) AS total_trips
FROM cyclistic..data
WHERE start_date IS NOT NULL
GROUP BY DATEADD(MONTH, DATEDIFF(MONTH, 0, start_date), 0)
ORDER BY month

--Total trip duration for annual members vs. casual riders in hours

SELECT
usertype,
SUM(DATEDIFF(HOUR, start_date, end_date)) AS trip_duration_hours
FROM cyclistic..data
WHERE ride_length IS NOT NULL
GROUP BY  usertype
ORDER BY trip_duration_hours DESC

--Average trip duration for annual members vs. casual riders in minutes

SELECT
usertype,
AVG(DATEDIFF(MINUTE, start_date, end_date)) AS avg_trip_duration_minutes
FROM cyclistic..data
WHERE ride_length IS NOT NULL
GROUP BY  usertype

--Most popular docking stations for annual members

SELECT
from_station_name,
COUNT(trip_id) AS trip_count
FROM cyclistic..data
WHERE usertype = 'member'
GROUP BY from_station_name
ORDER BY trip_count DESC

--Most popular docking stations for casual riders

SELECT
from_station_name,
COUNT(trip_id) AS trip_count
FROM cyclistic..data
WHERE usertype = 'casual'
GROUP BY from_station_name
ORDER BY trip_count DESC

--Average number of trips per day for annual members vs. casual riders

SELECT
usertype,
AVG(trip_count) AS avg_trips_per_day
FROM (SELECT
usertype,
CAST(start_date AS DATE) AS day,
COUNT(trip_id) AS trip_count
FROM cyclistic..data
WHERE start_date IS NOT NULL
GROUP BY usertype, CAST(start_date AS DATE)) subquery
GROUP BY usertype

--Peak hours of bike usage for annual members

SELECT
DATEPART(HOUR, start_date) AS hour,
COUNT(trip_id) AS trip_count
FROM cyclistic..data
WHERE usertype = 'member' and
start_date IS NOT NULL
GROUP BY DATEPART(HOUR, start_date)
ORDER BY trip_count DESC

--Peak hours of bike usage for annual members vs. casual riders

SELECT
DATEPART(HOUR, start_date) AS hour,
COUNT(trip_id) AS trip_count
FROM cyclistic..data
WHERE usertype = 'casual' and
start_date IS NOT NULL
GROUP BY DATEPART(HOUR, start_date)
ORDER BY trip_count DESC

--Total number of trips by bike type

SELECT
bike_type,
COUNT(trip_id) as number_of_trips
FROM cyclistic..data
WHERE bike_type IS NOT NULL
GROUP BY bike_type
ORDER BY COUNT(trip_id) DESC

--Total trip duration by bike type in hours

SELECT
bike_type,
SUM(DATEDIFF(HOUR, start_date, end_date)) AS trip_duration_hours
FROM cyclistic..data
WHERE start_date IS NOT NULL
GROUP BY bike_type

--Average trip Duration by Bike Type in minutes

SELECT
bike_type,
AVG(DATEDIFF(MINUTE, start_date, end_date)) AS avg_trip_duration_minutes
FROM cyclistic..data
WHERE start_date IS NOT NULL
GROUP BY bike_type

--Busiest stations

SELECT
station_name,
COUNT(*) AS trip_count
FROM
(SELECT
from_station_name AS station_name
FROM cyclistic..data
UNION ALL
SELECT
to_station_name AS station_name
FROM cyclistic..data) AS stations
GROUP BY station_name
ORDER BY trip_count DESC

--Total trip duration by day of week in hours

SELECT
day_of_week,
SUM(DATEDIFF(MINUTE, start_date, end_date)) AS total_trip_duration_hours
FROM cyclistic..data
WHERE start_date IS NOT NULL
GROUP BY day_of_week
ORDER BY total_trip_duration_hours DESC

--Average trip duration by day of week in minutes

SELECT
day_of_week,
AVG(DATEDIFF(MINUTE, start_date, end_date)) AS avg_trip_duration_minutes
FROM cyclistic..data
WHERE start_date IS NOT NULL
GROUP BY day_of_week
ORDER BY avg_trip_duration_minutes DESC