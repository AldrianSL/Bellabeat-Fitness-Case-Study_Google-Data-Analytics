CREATE TABLE cyclistic_schema.data_2023_analysis AS
	SELECT *
		FROM cyclistic_schema.Q1_2023
		UNION ALL
	SELECT *
		FROM cyclistic_schema.Q2_2023
		UNION ALL
	SELECT *
		FROM cyclistic_schema.Q3_2023
		UNION ALL
	SELECT *
		FROM cyclistic_schema.Q4_2023;

SELECT *
FROM cyclistic_schema.data_2023_analysis
WHERE 
member_casual = 'casual' AND rideable_type = 'docked_bike';

/*
Cyclistic Case Study: Data Analysis, full_year
Windows Functions, Aggregate Functions, Converting Data Types
*/

 -- Selecting full_year data to preview

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
        cyclistic_schema.data_2023_analysis
ORDER BY
        ride_id DESC
        -- or ride_length DESC


 -- Total Trips: Members vs Casual 
 -- Looking at overall, annual member and casual rider totals

SELECT
    TotalTrips,
    TotalMemberTrips,
    TotalCasualTrips,
    ROUND((CAST(TotalMemberTrips AS NUMERIC)/CAST(TotalTrips AS NUMERIC))*100,2) AS MemberPercentage,
    ROUND((CAST(TotalCasualTrips AS NUMERIC)/CAST(TotalTrips AS NUMERIC))*100,2) AS CasualPercentage
FROM
    (
        SELECT
            COUNT(ride_id) AS TotalTrips,
            SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS TotalMemberTrips,
            SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS TotalCasualTrips
        FROM
            cyclistic_schema.data_2023_analysis
        WHERE
            member_casual IN ('member', 'casual')
    )

 -- Avergage Ride Lengths: Members vs Casual  
 -- Looking at overall, member and casual average ride lengths

SELECT
        (
        SELECT
              AVG(ride_length)
        FROM
              cyclistic_schema.data_2023_analysis
        ) AS AvgRideLength_Overall,
        (
        SELECT
              AVG(ride_length)
        FROM
              cyclistic_schema.data_2023_analysis
        WHERE
              member_casual = 'member'
        ) AS AvgRideLength_Member,
        (
        SELECT
              AVG(ride_length)
        FROM
              cyclistic_schema.data_2023_analysis
        WHERE
              member_casual = 'casual' ) AS AvgRideLength_Casual

 -- Max Ride Lengths: Members vs Casual  
 -- Looking at max ride lengths to check for outliers

SELECT
        member_casual,
        MAX(ride_length) AS ride_length_MAX
FROM
        cyclistic_schema.data_2023_analysis
GROUP BY
        member_casual
ORDER BY
        ride_length_MAX

 -- Sorting by ride length to confirm there are multiple
 -- outliers for casual rider trips:

SELECT
      ride_id,
      member_casual,
      ride_length,
      day_of_week
FROM
      cyclistic_schema.data_2023_analysis
WHERE 
      member_casual = 'casual'
ORDER BY
      ride_length DESC

 -- Median Ride Lengths: Members vs Casual 
 -- Looking at median because of outliers influence on AVG

SELECT
    member_casual,
    median_ride_length
FROM
    (
        SELECT
            member_casual,
            PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY ride_length) AS median_ride_length
        FROM
            cyclistic_schema.data_2023_analysis
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
              DISTINCT member_casual,
              day_of_week,
              ROW_NUMBER() OVER (PARTITION BY member_casual ORDER BY COUNT(day_of_week) DESC) rn
        FROM
              cyclistic_schema.data_2023_analysis
        GROUP BY
              member_casual,
              day_of_week 
        )
WHERE
        rn = 1
ORDER BY
        member_casual DESC
LIMIT 2

 -- Looking at average ride length per day of week

SELECT
    day_of_week,
    AVG(ride_length) AS average_ride_length
FROM
    (
        SELECT
            member_casual,
            day_of_week,
            ride_length
        FROM
            cyclistic_schema.data_2023_analysis 
    ) as subquery
GROUP BY
    day_of_week
ORDER BY
    average_ride_length DESC
LIMIT 7;

 -- How about the median ride length per day of week?

SELECT
    member_casual,
    day_of_week,
    PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY ride_length) AS median_ride_length
FROM
    cyclistic_schema.data_2023_analysis
GROUP BY
    member_casual, day_of_week
ORDER BY
    median_ride_length DESC
LIMIT 7;

 -- Looking at AVG ride length per day of week for casual and annual

SELECT
    member_casual,
    day_of_week,
    AVG(ride_length) AS average_ride_length
FROM
    (
        SELECT
            member_casual,
            day_of_week,
            ride_length
        FROM
            cyclistic_schema.data_2023_analysis
    ) as subquery
GROUP BY
    member_casual,
    day_of_week
ORDER BY
    average_ride_length DESC
LIMIT 14;

-- Looking at median ride lengths per day

SELECT
    member_casual,
    day_of_week,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY COALESCE(ride_length, INTERVAL '0 seconds')) AS median_ride_length
FROM
    cyclistic_schema.data_2023_analysis
WHERE
    member_casual = 'member'
    -- member_casual = 'casual'
GROUP BY
    member_casual,
    day_of_week
ORDER BY
    median_ride_length DESC
LIMIT 7;

-- Overall trips per day
 -- Looking at total number of trips per day_of_week

SELECT
    day_of_week,
    COUNT(DISTINCT ride_id) AS TotalTrips,
    ROUND((COUNT(DISTINCT ride_id) * 100.0 / SUM(COUNT(DISTINCT ride_id)) OVER ()), 2) AS PercentageOfTotal
FROM
    cyclistic_schema.data_2023_analysis
WHERE
    ride_id IS NOT NULL 
GROUP BY
    day_of_week
ORDER BY
    TotalTrips DESC;

-- Overall, member, casual
 -- Looking at total number of trips per day 

SELECT  
        day_of_week,
        COUNT(DISTINCT ride_id) AS TotalTrips,
        SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS MemberTrips,
        SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS CasualTrips
FROM 
        cyclistic_schema.data_2023_analysis
GROUP BY 
        1
ORDER BY 
        TotalTrips DESC 
LIMIT 7

 -- Overall: member and casual
 -- Looking at total number of trips per day 

SELECT
    day_of_week,
    member_casual,
    COUNT(DISTINCT ride_id) AS TotalTrips,
    ROUND((COUNT(DISTINCT ride_id) * 100.0 / TotalTrips_Overall), 2) AS PercentageOfTotal
FROM
    (
        SELECT
            COUNT(ride_id)::NUMERIC AS TotalTrips_Overall
        FROM
            cyclistic_schema.data_2023_analysis
        WHERE 
            member_casual = 'member'
    ) AS overall,
    cyclistic_schema.data_2023_analysis
WHERE
    member_casual = 'member'
GROUP BY
    day_of_week, member_casual, TotalTrips_Overall
ORDER BY
    TotalTrips DESC
LIMIT
    7;

 -- Looking at most popular bike types
 -- Overall counts

SELECT 
    COUNT(*) AS Rows, 
    rideable_type,
    member_casual
FROM
    cyclistic_schema.data_2023_analysis
WHERE
    rideable_type IS NOT NULL
GROUP BY 
    rideable_type, 
    member_casual
ORDER BY 
    Rows DESC
LIMIT 5;

 -- Looking at bike types for member and casual
 
SELECT
        member_casual,
        rideable_type AS bike_type
FROM
        cyclistic_schema.data_2023_analysis
WHERE 
        member_casual = 'member'
        -- member_casual = 'casual'
GROUP BY 
        1,2

-- Looking at average ride length by bike type

SELECT
        rideable_type,
        AVG(ride_length) AS ride_length_AVG
FROM
        cyclistic_schema.data_2023_analysis
GROUP BY 
        1
LIMIT 
        3

-- Looking at max ride length by bike type

SELECT
        rideable_type,
        MAX(ride_length) AS ride_length_MAX
FROM
        cyclistic_schema.data_2023_analysis
GROUP BY 
        1

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
        cyclistic_schema.data_2023_analysis
GROUP BY 
        start_station_name
ORDER BY 
        total DESC
        -- member DESC
        -- casual DESC

 -- End stations: member vs casual
 -- Looking at end station counts

SELECT 
        DISTINCT end_station_name,
        SUM(
            CASE WHEN ride_id = ride_id AND end_station_name = end_station_name THEN 1 ELSE 0 END
            ) AS total,
        SUM(
            CASE WHEN member_casual = 'member' AND end_station_name = end_station_name THEN 1 ELSE 0 END
            ) AS member,
        SUM(
            CASE WHEN member_casual = 'casual' AND end_station_name = end_station_name THEN 1 ELSE 0 END
            ) AS casual
FROM 
        cyclistic_schema.data_2023_analysis
GROUP BY 
        end_station_name
ORDER BY 
        total DESC
        -- member DESC
        -- casual DESC

-- Looking at most popular start and end station combos

SELECT 
        start_station_name, 
        end_station_name,
        COUNT(*) AS combination_cnt
FROM
        cyclistic_schema.data_2023_analysis
WHERE 
        start_station_name IS NOT NULL 
        AND end_station_name IS NOT NULL
GROUP BY 
        1,2
ORDER BY 
        combination_cnt DESC

 -- Looking at most popular start and end station combos
 -- Filtering by member or casual 

SELECT 
        start_station_name, 
        end_station_name,
        COUNT(*) AS combination_cnt,
        member_casual
FROM
        cyclistic_schema.data_2023_analysis
WHERE 
        start_station_name IS NOT NULL 
        AND end_station_name IS NOT NULL
        -- AND member_casual = 'member'
        -- AND member_casual = 'casual'
GROUP BY 
        1,2,4
ORDER BY 
        combination_cnt DESC

 -- Looking at most popular start and end station combos 
 -- Overall count

SELECT
    SUM(CASE WHEN end_station_name = start_station_name THEN 1 ELSE 0 END) AS Rows,
    start_station_name,
    end_station_name
FROM
    cyclistic_schema.data_2023_analysis
GROUP BY
    start_station_name,
    end_station_name
ORDER BY
    Rows DESC;

-- Looking at total trip data 

SELECT
    COUNT(ride_id) AS TotalTrips,
    COUNT(CASE WHEN member_casual = 'member' THEN 1 ELSE NULL END) AS TotalMemberTrips,
    COUNT(CASE WHEN member_casual = 'casual' THEN 1 ELSE NULL END) AS TotalCasualTrips,
    ride_date,
    EXTRACT(QUARTER FROM ride_date) AS quarter
FROM
    cyclistic_schema.data_2023_analysis
WHERE 
    ride_date IS NOT NULL
GROUP BY
    ride_date, quarter
ORDER BY 
    ride_date ASC;

 -- trips per day 

SELECT
        TotalTrips,
        member_casual,
        ride_date,
        EXTRACT(QUARTER FROM ride_date) AS quarter
FROM 
        (
        SELECT
                COUNT(ride_id) AS TotalTrips,
                member_casual,
                ride_date,
                EXTRACT(QUARTER FROM ride_date) AS quarter
        FROM
                cyclistic_schema.data_2023_analysis
        WHERE 
                ride_date = ride_date
        GROUP BY
                member_casual,
                ride_date,
                quarter
        )
GROUP BY 
        1,2,3,4
ORDER BY 
        ride_date ASC

 --Trips per day along with running percentage

SELECT
    ride_date,
    TotalTrips_both,
    TotalMemberTrips,
    TotalCasualTrips,
    ROUND(CAST(TotalMemberTrips AS NUMERIC) / TotalTrips_both * 100, 2) AS MemberPercentage,
    ROUND(CAST(TotalCasualTrips AS NUMERIC) / TotalTrips_both * 100, 2) AS CasualPercentage
FROM 
    (
    SELECT
        ride_date,
        COUNT(ride_id) AS TotalTrips_both,
        COUNT(CASE WHEN member_casual = 'member' THEN 1 ELSE NULL END) AS TotalMemberTrips,
        COUNT(CASE WHEN member_casual = 'casual' THEN 1 ELSE NULL END) AS TotalCasualTrips
    FROM
        cyclistic_schema.data_2023_analysis
    WHERE 
        ride_date IS NOT NULL
    GROUP BY 
        ride_date
    ) AS Subquery
ORDER BY 
    ride_date;

 -- Average start hour along with running percentage

SELECT
        start_hour,
        total_trips,
        member_casual
FROM 
        (
        SELECT
                EXTRACT(HOUR FROM start_time) as start_hour,
                COUNT(ride_id) AS total_trips,
                member_casual
        FROM
                cyclistic_schema.data_2023_analysis
        WHERE 
                ride_id = ride_id
        GROUP BY 
                start_hour,
                member_casual
        )
GROUP BY 
        1,2,3
ORDER BY 
        start_hour

