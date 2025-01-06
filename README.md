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
-  [Analysis #1: Exploratory](#Analysis-#1:-Exploratory)
-  [Total Steps](#total-steps)
-  [Interesting Finds](#interesting-finds)
-  [Sleep](#sleep)


### **Further Data Cleaning and Manipulation via PostgreSQL**
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


### **Analysis #1: Exploratory**
[Back to Analyze](#4-analyze)

```
percentage <- data.frame(
  level=c("Sedentary", "Lightly", "Fairly", "Very Active"),
  minutes=c(sedentary_percentage,lightly_percentage,fairly_percentage,active_percentage)
)

plot_ly(percentage, labels = ~level, values = ~minutes, type = 'pie',textposition = 'outside',textinfo = 'label+percent') %>%
  layout(title = 'Activity Level Minutes',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
```

![newplot](https://user-images.githubusercontent.com/62857660/136252582-96e1f52a-dfe0-4247-a882-82d179d9b2b9.png)


The American Heart Association and World Health Organization recommend at least 150 minutes of moderate-intensity activity or 75 minutes of vigorous activity, or a combination of both, each week. That means it needs an daily goal of 21.4 minutes of FairlyActiveMinutes or 10.7 minutes of VeryActiveMinutes.

In our dataset, **30 users** met fairly active minutes or very active minutes.
```
active_users <- daily_activity %>%
  filter(FairlyActiveMinutes >= 21.4 | VeryActiveMinutes>=10.7) %>% 
  group_by(Id) %>% 
  count(Id) 
```

### Noticeable Day:
[Back to Analyze](#4-analyze)

The bar graph shows that there is a jump on Saturday: user spent LESS time in sedentary minutes and take MORE steps. Users are out and about on Saturday. 

![image](https://user-images.githubusercontent.com/62857660/136281021-fea4e732-982c-4404-8650-c3e943076856.png)
![image](https://user-images.githubusercontent.com/62857660/136281035-2b190f9e-a5a5-44c2-8183-20b1f7441e8d.png)





### Total Steps:
[Back to Analyze](#4-analyze)

Let's look at how active the users are per hourly in total steps. From 5PM to 7PM the users take the most steps. 
```
ggplot(data=hourly_step, aes(x=Hour, y=StepTotal, fill=Hour))+
  geom_bar(stat="identity")+
  labs(title="Hourly Steps")
```
![image](https://user-images.githubusercontent.com/62857660/136235391-bb22c15d-93aa-494d-bce2-76a984274fb7.png)


How active the users are weekly in total steps. Tuesday and Saturdays the users take the most steps. 
```
ggplot(data=merged_data, aes(x=Weekday, y=TotalSteps, fill=Weekday))+ 
  geom_bar(stat="identity")+
  ylab("Total Steps")
```
![image](https://user-images.githubusercontent.com/62857660/136252217-53d355de-2c25-4185-8e6d-27ba087573ae.png)




### Interesting Finds:
[Back to Analyze](#4-analyze)

The more active that you're, the more steps you take, and the more calories you will burn. This is an obvious fact, but we can still look into the data to find any interesting. Here we see that some users who are sedentary, take minimal steps, but still able to burn over 1500 to 2500 calories compare to users who are more active, take more steps, but still burn similar calories.

```
ggplot(data=daily_activity, aes(x=TotalSteps, y = Calories, color=SedentaryMinutes))+ 
  geom_point()+ 
  stat_smooth(method=lm)+
  scale_color_gradient(low="steelblue", high="orange")

```
![image](https://user-images.githubusercontent.com/62857660/136260311-a379b303-76ac-426c-9c30-ea2695569632.png)

Comparing the four active levels to the total steps, we see most data is concentrated on users who take about 5000 to 15000 steps a day. These users spent an average between 8 to 13 hours in sedentary, 5 hours in lightly active, and 1 to 2 hour for fairly and very active. 

![image](https://user-images.githubusercontent.com/62857660/136269396-7019cf93-6e0c-4216-9944-5e58e017f593.png)

According to [this healthline.com article](https://www.healthline.com/nutrition/how-many-calories-per-day#average-calorie-needs), moderately active woman between the ages of 26–50 needs to eat about 2,000 calories per day and moderately active man between the ages of 26–45 needs 2,600 calories per day to maintain his weight. Comparing the four active levels to the calories, we see most data is concentrated on users who burn 2000 to 3000 calories a day. These users also spent an average between 8 to 13 hours in sedentary, 5 hours in lightly active, and 1 to 2 hour for fairly and very active. Additionally, we see that the sedentary line is leveling off toward the end while fairly + very active line is curing back up. This indicate that the users who burn more calories spend less time in sedentary, more time in fairly + active. 

![image](https://user-images.githubusercontent.com/62857660/136263632-ac5c1958-23db-4374-b810-df6f322b047b.png)

### Sleep:
[Back to Analyze](#4-analyze)

According to article: [Fitbit Sleep Study](https://blog.fitbit.com/sleep-study/#:~:text=The%20average%20Fitbit%20user%20is,is%20spent%20restless%20or%20awake.&text=People%20who%20sleep%205%20hours,the%20beginning%20of%20the%20night.), 55 minutes are spent awake in bed before going to sleep. We have 13 users in our dataset spend 55 minutes awake before alseep. 

```
awake_in_bed <- mutate(sleep_day, AwakeTime = TotalTimeInBed - TotalMinutesAsleep)
awake_in_bed <- awake_in_bed %>% 
  filter(AwakeTime >= 55) %>% 
  group_by(Id) %>% 
  arrange(AwakeTime) 
```

We can use regression analysis look at the variables and correlation. For R-squared, 0% indicates that the model explains none of the variability of the response data around its mean. Higher % indicates that the model explains more of the variability of the response data around its mean. Postive slope means variables increase/decrease with each other, and negative means one variable go up and the other go down. We want to look at if users who spend more time in sedentary minutes spend more time sleeping as well. We can use regression analysis ```lm()``` to check for the dependent and indepedent variables. We also find that how many minutes an user asleep have an very weak correlation with how long they spend in sedentary minutes during the day.  
```
sedentary_vs_sleep.mod <- lm(SedentaryMinutes ~ TotalMinutesAsleep, data = merged_data)
summary(sedentary_vs_sleep.mod)
```
![calvssteps2](https://user-images.githubusercontent.com/62857660/136107919-65c86392-4f12-4038-b3d3-09166d8d5381.PNG)

How about calories vs asleep? Do people sleep more burn less calories? Plotting the two variables we can see that there is not much a correlation. 
```
ggplot(data=merged_data, aes(x=TotalMinutesAsleep, y = Calories, color=TotalMinutesAsleep))+ 
  geom_point()+ 
  labs(title="Total Minutes Asleep vs Calories")+
  xlab("Total Minutes Alseep")+
  stat_smooth(method=lm)+
  scale_color_gradient(low="orange", high="steelblue")
```
![image](https://user-images.githubusercontent.com/62857660/136283073-360f9a07-e4ef-4307-9c65-4b877f62e58b.png)



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
