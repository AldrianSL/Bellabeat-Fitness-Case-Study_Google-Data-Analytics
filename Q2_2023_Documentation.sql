/*
Cyclistic Case Study: Quarterly Data Exploration, Q2_2023
Windows Functions, Aggregate Functions, Converting Data Types
*/

 -- Select columns from Q1 data to preview
	
 SELECT  
        ride_id,
        started_at,
        ended_at,
        ride_length,
        day_of_week, 
        start_station_name,
        end_station_name,
        member_casual
FROM 
        cyclistic_schema.Q2_2023
ORDER BY 
        started_at


  -- Total Trips: Members vs Casual 
  -- Looking at overall, annual member and casual rider totals

SELECT
    COUNT(ride_id) AS TotalTrips,
    SUM(CASE WHEN COALESCE(member_casual, 'unknown') = 'member' THEN 1 ELSE 0 END) AS TotalMemberTrips,
    SUM(CASE WHEN COALESCE(member_casual, 'unknown') = 'casual' THEN 1 ELSE 0 END) AS TotalCasualTrips,
    ROUND((SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) * 1.0 / COUNT(ride_id)) * 100, 2) AS MemberPercentage,
    ROUND((SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) * 1.0 / COUNT(ride_id)) * 100, 2) AS CasualPercentage
FROM
    cyclistic_schema.Q2_2023;


 -- Avergage Ride Lengths: Members vs Casual  
 -- Looking at overall, member and casual average ride lengths

SELECT
        (
        SELECT 
                AVG(ride_length)
        FROM 
                cyclistic_schema.Q2_2023
        ) AS AvgRideLength_Overall,
        (
        SELECT 
                AVG(ride_length) 
        FROM 
                cyclistic_schema.Q2_2023
        WHERE 
                member_casual = 'member'
        ) AS AvgRideLength_Member,
        (
        SELECT 
                AVG(ride_length) 
        FROM 
                cyclistic_schema.Q2_2023
        WHERE 
                member_casual = 'casual'
        ) AS AvgRideLength_Casual

 -- Max Ride Lengths: Members vs Casual  
 -- Looking at max ride lengths to check for outliers

SELECT 
        member_casual,
        MAX(ride_length) AS ride_length_MAX
FROM 
        cyclistic_schema.Q2_2023
GROUP BY 
        member_casual
ORDER BY 
        ride_length_MAX DESC
LIMIT 
        2

 -- Looking at median ride lengths

SELECT
    member_casual,
    median_ride_length
FROM
    (
        SELECT
            member_casual,
            PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY ride_length) AS median_ride_length
        FROM
            cyclistic_schema.Q2_2023
        WHERE
            ride_length IS NOT NULL
        GROUP BY
            member_casual
    ) AS subquery
ORDER BY
    median_ride_length DESC
LIMIT 2;

 -- Rides per day: member and casual
 -- Looking at which days have the highest number of rides
 
SELECT
        member_casual, 
        day_of_week AS mode_day_of_week
FROM 
        (
        SELECT
                DISTINCT member_casual, day_of_week, ROW_NUMBER() OVER (PARTITION BY member_casual ORDER BY COUNT(day_of_week) DESC) rn
        FROM
                cyclistic_schema.Q2_2023
        GROUP BY
                member_casual, day_of_week
        )
WHERE
        rn = 1
ORDER BY
        member_casual DESC LIMIT 2

-- Looking at median ride lengths per day for annual members  

SELECT
    member_casual,
    day_of_week,
    PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY ride_length) AS median_ride_length
FROM
    cyclistic_schema.Q2_2023
WHERE
    member_casual = 'member'
    AND ride_length IS NOT NULL 
GROUP BY
    member_casual, day_of_week
ORDER BY
    median_ride_length DESC
LIMIT 7;

 -- Looking at median ride lengths per day for casual riders  
 
SELECT
    member_casual,
    day_of_week,
    PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY ride_length) AS median_ride_length
FROM
    cyclistic_schema.Q2_2023
WHERE
    member_casual = 'casual'
    AND ride_length IS NOT NULL 
GROUP BY
    member_casual, day_of_week
ORDER BY
    median_ride_length DESC
LIMIT 7;

  -- Looking at total number of trips per day 

SELECT  
        day_of_week,
        COUNT(DISTINCT ride_id) AS total_trips,
        SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS MemberTrips,
        SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS CasualTrips
FROM 
        cyclistic_schema.Q2_2023
GROUP BY 
        1
ORDER BY 
        total_trips DESC LIMIT 7

 -- Start stations: member vs casual
 -- Looking at start station counts

SELECT 
        DISTINCT start_station_name,
        SUM(
            CASE WHEN ride_id = ride_id AND start_station_name = start_station_name THEN 1 ELSE 0 END
            ) AS total,
        SUM(
            CASE WHEN member_casual = 'member' AND start_station_name = start_station_name THEN 1 ELSE 0 END
            ) AS member,
        SUM(
            CASE WHEN member_casual = 'casual' AND start_station_name = start_station_name THEN 1 ELSE 0 END
            ) AS casual
FROM 
        cyclistic_schema.Q2_2023
GROUP BY 
        start_station_name
ORDER BY 
        casual DESC