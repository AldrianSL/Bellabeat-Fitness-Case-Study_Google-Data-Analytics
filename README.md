# CASE STUDY: Cyclistic Bikeshare Analysis in 2023
##### Author: Aldrian Syafril Lubis

##### Date: December 18, 2024

##### [Tableau (Progress)

##### [Tableau (Progress)

_The case study follows the six step data analysis process:_

### ❓ [Ask](#1-ask)
### 💻 [Prepare](#2-prepare)
### 🛠 [Process](#3-process)
### 📊 [Analyze](#4-analyze)
### 📋 [Share](#5-share)
### 🧗‍♀️ [Act](#6-act)

## Scenario
I am a Junior Data Analyst on the Marketing Analyst team at Cyclistic, a bike-share company based in Chicago. The marketing director believes that the company’s future success depends on increasing the number of annual memberships. Therefore, my team is tasked with understanding the differences in bike usage patterns between casual riders and annual members.

In my role, I am responsible for analyzing Cyclistic's bike usage data, identifying trends, and presenting data-driven insights to support the development of effective marketing strategies aimed at converting casual riders into annual members. 

To achieve this goal, I will:  
1. **Data Collection:** Access historical bike usage data, including user type, ride duration, rental and return locations, and trip times.  
2. **Data Cleaning and Preparation:** Ensure the data is accurate, free of anomalies, and ready for analysis.  
3. **Data Analysis:** Compare usage patterns between casual riders and annual members, such as ride frequency, trip duration, and popular locations.  
4. **Data Visualization:** Create professional and easy-to-understand visualizations using tools like Tableau and Excel to support executive presentations.  
5. **Recommendation Development:** Based on the insights gathered, I will propose targeted marketing strategies designed to convert more casual riders into annual members.

All recommendations I present will be backed by strong data insights and compelling visualizations to persuade executives in making strategic decisions for the company's growth.

## Characters and teams
- **Cyclistic:** A bike-share program in Chicago with over 5,800 bicycles and 600 docking stations. Cyclistic offers inclusive options like reclining bikes, hand tricycles, and cargo bikes, making it accessible for people with disabilities and those unable to use standard bikes. While most riders prefer traditional bikes, around 8% use the assistive options. Approximately 30% of users commute to work daily, while most ride for leisure.  

- **Lily Moreno:** The Director of Marketing and my direct manager. She oversees the development of marketing campaigns and initiatives to promote Cyclistic's bike-share program through channels like email and social media.  

- **Cyclistic Marketing Analytics Team:** A team of data analysts responsible for collecting, analyzing, and reporting data to guide Cyclistic’s marketing strategies. I joined this team six months ago and have been learning about the company’s mission and business objectives, as well as how I can contribute as a Junior Data Analyst.  

- **Cyclistic Executive Team:** A detail-oriented leadership group that will decide whether to approve the proposed marketing strategies based on the data insights and visualizations presented.

## About the Company
<p align="center">
  <img src="Screenshot_3-1-2025_19938_.jpeg" alt="Image" />
</p>

In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet 5,824 bicycles that are geotracked and locked into a network of 692 station across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime.

Cyclistic's marketing strategy has focused on building general awareness and appealing to broad consumer segments through flexible pricing plans, including single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders, while annual membership holders are Cyclistic members. Finance analysts have determined that annual members are significantly more profitable than casual riders. While pricing flexibility helps attract a broad customer base, Marketing Director Lily Moreno believes that maximizing annual memberships will be crucial for future growth. Rather than targeting entirely new customers, she sees a strong opportunity to convert casual riders into annual members since they are already familiar with Cyclistic and have chosen it for their mobility needs.

## 1. Ask
💡 **BUSINESS TASK: Analyze historical bike trip data to identify trends in how annual members and casual riders use Cyclistic bikes differently.**

Primary stakeholders: Lily Moreno, Cyclistic executive team members.

Secondary stakeholders: Bellabeat marketing analytics team.

:dart: **DEFINING PROBLEM** :
The main problem for the director of marketing and marketing analytics team is this: Design marketing strategies aimed at converting Cyclistic’s casual riders into annual members. There are three questions that will guide this future marketing program. For my scope on this project, I will anlyze the first question:

1) How do annual members and casual riders use Cyclistic bikes differently?
2) Why would casual riders buy Cyclistic annual memberships?
3) How can Cyclistic use digital media to influence casual riders to become members?

By looking at the data, we will be able to first get a broad sense of certain patterns that are occurring in the two different groups. Understanding the differences will provide more accurate customer profiles for each group. These insights will help the marketing analytics team design high quality targeted marketing for converting casual riders into members. For the Cyclistic executive team, these insights will help Cyclistic maximize the number of annual members and will fuel future growth for the company.

## 2. Prepare 
**Data Source:** 
We’ll be using Cyclistic’s historical bike trip data from 2023, which is publicly available ([Here](https://divvy-tripdata.s3.amazonaws.com/index.html)). The data is made available by Motivate International Inc. under this ([license](https://divvybikes.com/data-license-agreement)). The data is stored in PostgreSQL.
There are 12 .CSV files total:
```
01) 2023-01_divvy_trip-data.csv  
02) 2023-02_divvy_trip-data.csv  
03) 2023-03_divvy_trip-data.csv  
04) 2023-04_divvy_trip-data.csv  
05) 2023-05_divvy_trip-data.csv  
06) 2023-06_divvy_trip-data.csv  
07) 2023-07_divvy_trip-data.csv  
08) 2023-08_divvy_trip-data.csv  
09) 2023-09_divvy_trip-data.csv  
10) 2023-10_divvy_trip-data.csv  
11) 2023-11_divvy_trip-data.csv  
12) 2023-12_divvy_trip-data.csv  
```
It is structured data, organized in rows (records) and columns (fields). Each record represents one trip, and each trip has a unique field that identifies it: ride_id. Each trip is anonymized and includes the following fields:
```
* ride_id               #Ride id - unique
* rideable_type         #Bike type - Classic, Docked, Electric
* started_at            #Trip start day and time
* ended_at              #Trip end day and time
* start_station_name    #Trip start station
* start_station_id      #Trip start station id
* end_station_name      #Trip end station
* end_station_id        #Trip end station id
* start_lat             #Trip start latitude  
* start_lng             #Trip start longitute   
* end_lat               #Trip end latitude  
* end_lat               #Trip end longitute   
* member_casual         #Rider type - Member or Casual  
```
Bike station data that is made publicly available by the ([city of Chicago](https://www.chicago.gov/city/en/narr/foia/data_disclaimer.html)) will also be used. It can be downloaded ([here](https://data.cityofchicago.org/Transportation/Divvy-Bicycle-Stations/bbyy-e7gq/data)). In terms of bias and credibility, both data sources we are using ROCCC:

- Reliability and Original: This data comes from real-time data from Cyclistic for the entire time of 2023 published by Motivate International Inc, this is the public data that contains accurate, complete and unbiased info on Cyclistic’s historical bike trips. It can be used to explore how different customer types are using Cyclistic bikes.
- Comprehensive and Current: these sources contain all the data needed to understand the different ways members and casual riders use Cyclistic bikes. The data is from the past years. It is current and relevant to the task at hand. This is important because the usefulness of data decreases as time passes.
- Cited: these sources are publicly available data provided by Cyclistic and the City of Chicago. Governmental agency data and vetted public data are typically good sources of data.

## 3. Process
[Back to Top](#author-aldrian-syafril-lubis)

### :recycle: Data Cleaning and Manipulation

**We use PostgreSQL**

Our next step is making sure the data is stored appropriately and prepared for analysis. After downloading all 12 zip files and unzipping them, I housed the files in a folder on my desktop. I also created subfolders for the .CSV filesso that I have a copy of the original data. Then, I launched import it to pgAdmin 4 (Postgre SQL GUI).
For each .CSV file, I did the following:

● Merge all dataframes into a single dataframe :
```
CREATE TABLE cyclistic_schema.data_2023 AS
SELECT * FROM january_2023
UNION ALL
SELECT * FROM february_2023
UNION ALL
SELECT * FROM march_2023
UNION ALL
SELECT * FROM april_2023
UNION ALL
SELECT * FROM may_2023
UNION ALL
SELECT * FROM june_2023
UNION ALL
SELECT * FROM july_2023
UNION ALL
SELECT * FROM august_2023
UNION ALL
SELECT * FROM september_2023
UNION ALL
SELECT * FROM october_2023
UNION ALL
SELECT * FROM november_2023
UNION ALL
SELECT * FROM december_2023;
```

● Changed format of started_at and ended_at columns:
```
ALTER TABLE cyclistic_schema.data_2023
ALTER COLUMN started_at TYPE timestamp without time zone USING started_at::timestamp without time zone;

ALTER TABLE cyclistic_schema.data_2023
ALTER COLUMN ended_at TYPE timestamp without time zone USING ended_at::timestamp without time zone;
```

● Created a column called ride_length:
```
ALTER TABLE cyclistic_schema.data_2023
ADD COLUMN ride_length INTERVAL;

UPDATE cyclistic_schema.data_2023
SET ride_length = ended_at - started_at;
```

● Created a column called ride_date:
```
ALTER TABLE cyclistic_schema.data_2023
ADD COLUMN ride_date DATE;

UPDATE cyclistic_schema.data_2023
SET ride_date = DATE(started_at);
```

● Created a column called ride_month
```
ALTER TABLE cyclistic_schema.data_2023
ADD COLUMN ride_month INTEGER;

UPDATE cyclistic_schema.data_2023
SET ride_month = EXTRACT(MONTH FROM started_at);
```

● Created a column called ride_year
```
ALTER TABLE cyclistic_schema.data_2023
ADD COLUMN ride_year INTEGER;

UPDATE cyclistic_schema.data_2023
SET ride_year = EXTRACT(YEAR FROM started_at);
```

● Created a column called start_time
```
ALTER TABLE cyclistic_schema.data_2023
ADD COLUMN start_time TIME;

UPDATE cyclistic_schema.data_2023
SET start_time = CAST(started_at AS TIME);
```

● Created a column called end_time
```
ALTER TABLE cyclistic_schema.data_2023
ADD COLUMN end_time TIME;

UPDATE cyclistic_schema.data_2023
SET end_time = CAST(ended_at AS TIME);
```

● Created a column called day_of_week
```
ALTER TABLE cyclistic_schema.data_2023
ADD COLUMN day_of_week INTEGER;

UPDATE cyclistic_schema.data_2023
SET day_of_week = CASE 
    WHEN started_at IS NULL THEN NULL
    ELSE EXTRACT(DOW FROM started_at) + 1
END
WHERE started_at IS NOT NULL;
--- Note: 1 = Sunday and 7 = Saturday
```

Clean the data to prepare for analysis in 4. Analyze!

## 4. Analyze
[Back to Top](#author-aldrian-syafril-lubis)

-  [Further Data Cleaning and Manipulation via PostgreSQL](#Further-Data-Cleaning-and-Manipulation-via-PostgreSQL)
-  [Exploratory](#Exploratory)
-  [Summary](#Summary)
-  [Interesting Finds](#interesting-finds)
-  [Sleep](#sleep)


## **Further Data Cleaning and Manipulation via PostgreSQL**
[Back to Analyze](#4-analyze)

Before we go any further, I found some interesting insights when I categorized the existing data into Quarter forms using this syntax:
```
SELECT
    EXTRACT(QUARTER FROM started_at) AS quarter,
    COUNT(*) AS total_trips
FROM
    cyclistic_schema.data_2023
GROUP BY
    quarter;
```
<p align="center">
  <img src="Total Trips by Quarter.png" alt="Image" />
</p>

### **Key Insight : I found that there was a large spike in cyclistic service usage in the middle of winter, in July and August, and in early aumn in September.**


### **Create quarterly tables**

In order to perform analysis by season, let’s seperate the merged tables into these tables :
* **Table 1)** 2023_Q1 -> JAN(01), FEB(02), MAR(03)
* **Table 2)** 2023_Q2 -> APR(04), MAY(05), JUN(06)
* **Table 3)** 2023_Q3 -> JUL(07), AUG(08), SEP(09)
* **Table 4)** 2023_Q4 -> OCT(10), NOV(11), DEC(12)
```
-- Create 2023_Q1 table
CREATE TABLE cyclistic_schema.Q1_2023 AS
SELECT * 
FROM cyclistic_schema.data_2023
WHERE EXTRACT(QUARTER FROM started_at) = 1;

-- Create 2023_Q2 table
CREATE TABLE cyclistic_schema.Q2_2023 AS
SELECT * 
FROM cyclistic_schema.data_2023
WHERE EXTRACT(QUARTER FROM started_at) = 2;

-- Create 2023_Q3 table
CREATE TABLE cyclistic_schema.Q3_2023 AS
SELECT * 
FROM cyclistic_schema.data_2023
WHERE EXTRACT(QUARTER FROM started_at) = 3;

-- Create 2023_Q4 table
CREATE TABLE cyclistic_schema.Q4_2023 AS
SELECT * 
FROM cyclistic_schema.data_2023
WHERE EXTRACT(QUARTER FROM started_at) = 4;
```


### **Clean and transform day of week**

Some additional data cleaning is needed on the new table. First, we’ll update the format for day_of_week from INTEGER to STRING. Then, we’ll change the values from numbers to their corresponding day names (i.e. 1 = Sunday, 7 = Saturday.

We’ll start with Q1_2023 and repeat for the remaining three tables:

```
ALTER TABLE cyclistic_schema.Q1_2023
ALTER COLUMN day_of_week TYPE TEXT;

UPDATE cyclistic_schema.Q1_2023
SET day_of_week = CASE 
    WHEN day_of_week = '1' THEN 'Sunday'
    WHEN day_of_week = '2' THEN 'Monday'
    WHEN day_of_week = '3' THEN 'Tuesday'
    WHEN day_of_week = '4' THEN 'Wednesday'
    WHEN day_of_week = '5' THEN 'Thursday'
    WHEN day_of_week = '6' THEN 'Friday'
    WHEN day_of_week = '7' THEN 'Saturday'
    ELSE day_of_week 
END;
```


## **Exploratory**
[Back to Analyze](#4-analyze)

### Q1_2023 - Quarterly Data Exploration

We’ll select a few columns from Q1_2023 to preview in a temporary table. This will help give us an idea of potential trends and relationships to explore further:
```
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
        cyclistic_schema.Q1_2023
ORDER BY 
        started_at
```
The above query returned 639,424 rows. That is the number of recorded trips we have data for in this quarter. Let’s dive deeper into those trip totals.

### Total Trips
We’ll create total columns for overall, annual members and casual riders. We’ll also calculate percentages of overall total for both types:
```
SELECT
    COUNT(ride_id) AS TotalTrips,
    SUM(CASE WHEN COALESCE(member_casual, 'unknown') = 'member' THEN 1 ELSE 0 END) AS TotalMemberTrips,
    SUM(CASE WHEN COALESCE(member_casual, 'unknown') = 'casual' THEN 1 ELSE 0 END) AS TotalCasualTrips,
    ROUND((SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) * 1.0 / COUNT(ride_id)) * 100, 2) AS MemberPercentage,
    ROUND((SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) * 1.0 / COUNT(ride_id)) * 100, 2) AS CasualPercentage
FROM
    cyclistic_schema.Q1_2023;
```
Of the 639,424 total trips in Q1_2023, 77% were from annual members while 23% were from casual riders.
<p align="center">
  <img src="Total Trips Q1_2023.png" alt="Image" />
</p>

### Average ride lengths
How does average ride_length differ for these groups?
```
SELECT
        (
        SELECT 
                AVG(ride_length)
        FROM 
                cyclistic_schema.Q1_2023
        ) AS AvgRideLength_Overall,
        (
        SELECT 
                AVG(ride_length) 
        FROM 
                cyclistic_schema.Q1_2023
        WHERE 
                member_casual = 'member'
        ) AS AvgRideLength_Member,
        (
        SELECT 
                AVG(ride_length) 
        FROM 
                cyclistic_schema.Q1_2023
        WHERE 
                member_casual = 'casual'
        ) AS AvgRideLength_Casual
```
<div style="text-align: center;">
  <img src="https://github.com/user-attachments/assets/3fad7b6d-35c8-419e-8872-e28666d7fb61" alt="Average Ride Length Q1_2023" />
</div>
We can see that casual riders average about 12 more minutes per ride. That seems like a pretty big difference. What influence are outliers having on these averages? Let’s investigate.

### Max ride lengths
We’ll look at the maximum values for ride_length to see if anything extreme is influencing the casual rider average:
```
SELECT 
        member_casual,
        MAX(ride_length) AS ride_length_MAX
FROM 
        cyclistic_schema.Q1_2023
GROUP BY 
        member_casual
ORDER BY 
        ride_length_MAX DESC
LIMIT 
        2
```
![Screenshot 2025-01-07 165019](https://github.com/user-attachments/assets/c19d4718-9ebb-49ea-9d8a-24bfe16e3b22)

As we suspected, the casual riders average ride_length was significantly impacted by at least one outlier. The longest trip duration for casual riders was 23 days 8 Hours. Meanwhile, the longest for annual member was only about 1 day 2 hours.

### Median ride lengths
Since there are more than a few outliers impacting the average, we’re going to use median instead of average. Median will be more accurate for our analysis:
```
SELECT
    member_casual,
    median_ride_length
FROM
    (
        SELECT
            member_casual,
            PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY ride_length) AS median_ride_length
        FROM
            cyclistic_schema.Q1_2023
        WHERE
            ride_length IS NOT NULL
        GROUP BY
            member_casual
    ) AS subquery
ORDER BY
    median_ride_length DESC
LIMIT 2;
```
![Screenshot 2025-01-07 173027](https://github.com/user-attachments/assets/a211b3df-605e-4709-92d8-dd3850d215ec)
#### Now we see a much closer number, with 8 minutes for casual riders and 7 minutes for annual members.

### Busiest day for rides
Let’s see which day has the most rides for annual members and casual riders:
```
 -- Looking at which days have the highest number of rides
 
SELECT
        member_casual, 
        day_of_week AS mode_day_of_week
FROM 
        (
        SELECT
                DISTINCT member_casual, day_of_week, ROW_NUMBER() OVER (PARTITION BY member_casual ORDER BY COUNT(day_of_week) DESC) rn
        FROM
                cyclistic_schema.Q1_2023
        GROUP BY
                member_casual, day_of_week
        )
WHERE
        rn = 1
ORDER BY
        member_casual DESC LIMIT 2
```
![Screenshot 2025-01-07 183732](https://github.com/user-attachments/assets/d99a83ca-96c8-4fad-a891-c87269cdd354)

Suprisingly, Tuesday is the most popular day for annual members, meanwhile Sunday is the most popular for casual riders which is predictable.

### Median ride length per day
Let’s look at the median ride lengths per day for both annual members and casual riders. Since Tuesday and Sunday is the most popular overall, do we think it will also have the highest median ride length?
```
-- Looking at median ride lengths per day for annual members  

SELECT
    member_casual,
    day_of_week,
    PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY ride_length) AS median_ride_length
FROM
    cyclistic_schema.Q1_2023
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
    cyclistic_schema.Q1_2023
WHERE
    member_casual = 'casual'
    AND ride_length IS NOT NULL 
GROUP BY
    member_casual, day_of_week
ORDER BY
    median_ride_length DESC
LIMIT 7;
```
Annual Member Rider Median ride length per day :
![Screenshot 2025-01-07 184700](https://github.com/user-attachments/assets/98dcec2f-5516-40c2-82a6-5c494b5fc836)

Casual Rider Median ride length per day :
![Screenshot 2025-01-07 184722](https://github.com/user-attachments/assets/0344da77-4706-4fe6-9f2c-f95d7f2a775e)

There is no significant different with The median ride length for casual riders and The median ride length for annual members.

### Total rides per day
Let’s look at total rides per day. We’ll create columns for overall total, annual members and casual riders:
```
  -- Looking at total number of trips per day 

SELECT  
        day_of_week,
        COUNT(DISTINCT ride_id) AS TotalTrips,
        SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS MemberTrips,
        SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS CasualTrips
FROM 
        `cyclistic-cs-341119.biketrips.2021_Q1`
GROUP BY 
        1
ORDER BY 
        total_trips DESC LIMIT 7
```
![Screenshot 2025-01-07 191219](https://github.com/user-attachments/assets/7a2c055f-aea2-4313-8e93-f1b97f27dbe7)

### Start stations
Next, we’ll look at the most popular start stations for trips. We’ll again include columns for overall, annual member and casual rider totals per start station:
```
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
        cyclistic_schema.Q1_2023
GROUP BY 
        start_station_name
ORDER BY 
        total DESC
```
![Screenshot 2025-01-07 192014](https://github.com/user-attachments/assets/f9018b27-6bd8-4786-89d1-2ca317ce2ba0)

We can begin to see some interesting patterns in the start station data. It looks like casual riders and annual members tend to favor different regions for beginning their trips. By updating the ORDER BY function to sort by casual DESC and member DESC in two separate queries, we can compare the top ten start stations for both:

![Start Stations](https://github.com/user-attachments/assets/dddf0c0f-c217-47f2-ad0e-e601bfd39826)

Wow! There is three start station that cracks the top ten for both lists.
* (([University Ave & 57th St](https://www.bing.com/maps?q=University+Ave+%26+57th+St&FORM=HDRSC6&cp=47.204091%7E-122.513229&lvl=18.4))) start station is ranked #1 for annual members and #5 for casual riders.
* (([Elis Ave & 60th St](https://www.bing.com/maps?q=Ellis+Ave+%26+60th+St&FORM=HDRSC6&cp=43.601715%7E-96.775309&lvl=16.2))) start station is ranked #2 for annual members and #6 for casual riders.
* (([Kingsbury St & Kinzie St](https://www.bing.com/maps?q=Kingsbury+St+%26+Kinzie+St&FORM=HDRSC6&cp=41.889138%7E-87.638685&lvl=16.3))) start station is ranked #4 for annual members and #8 for casual riders.

### Quarterly data exploration (cont.)
Instead of walking through each quarter like we’ve done for Q1-2023, I will instead provide links to the full SQL files. The queries used are similar to the ones above:
* **Table 1)** 2023_Q1 -> JAN(01), FEB(02), MAR(03)
* **Table 2)** 2023_Q2 -> APR(04), MAY(05), JUN(06)
* **Table 3)** 2023_Q3 -> JUL(07), AUG(08), SEP(09)
* **Table 4)** 2023_Q4 -> OCT(10), NOV(11), DEC(12)


## **Summary**
[Back to Analyze](#4-analyze)



## 5. Share 
[Back to Top](#author-emi-ly)

### 🎨 [Bellabeat Data Analysis Dashboard](https://public.tableau.com/app/profile/emily.liang7497/viz/BellabeatFitnessDataAnalysisDashboard/GiantDashboard)

![dashboard-bella](https://user-images.githubusercontent.com/62857660/136821119-78ddef7b-1e78-4875-bc4b-04febdfb67c2.PNG)

### 🎨 [Bellabeat Data Presentation in Tableau](https://public.tableau.com/app/profile/emily.liang7497/viz/BellabeatFitnessDataAnalysis-GoogleDataAnalyticsCapstone/Story1)

![present](https://user-images.githubusercontent.com/62857660/136821333-3e30a827-81d9-43c5-bd7f-98a1680901d9.PNG)



## 6. Act
[Back to Top](#author-emi-ly)

Conclusion based on our analysis:
- Sedentary make up a significant portion, 81% of users daily active minutes. Users spend on avg 12 hours a day in sedentary minutes, 4 hours lightly active, and only half-hour in fairly+very active! 
- We see the most change on Saturday: users take more steps, burn more calories, and spend less time sedentary. Sunday is the most "lazy" day for users. 
- 54% of the users who recorded their sleep data spent 55 minutes awake in bed before falling asleep.
- Users takes the most steps from 5 PM to 7 PM
Users who are sedentary take minimal steps and burn 1500 to 2500 calories compared to users who are more active, take more steps, but still burn similar calories.



Marketing recommendations to expand globally:

##### 🔢  Obtain more data for an accurate analysis, encouraging users to use a wifi-connected scale instead of manual weight entries. 

##### 🚲  Educational healthy style campaign encourages users to have short active exercises during the week, longer during the weekends, especially on Sunday where we see the lowest steps and most sedentary minutes.

##### 🎁  Educational healthy style campaign can pair with a point-award incentive system. Users completing the whole week's exercise will receive Bellabeat points on products/memberships.

##### 🏃‍♂️ The product, such as Leaf wellness tracker, can beat or vibrate after a prolonged period of sedentary minutes, signaling the user it's time to get active! Similarly, it can also remind the user it's time to sleep after sensing a prolonged awake time in bed.
