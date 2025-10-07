CREATE OR REPLACE TABLE `coursera-473006.Bellabeat.user_summary` AS
SELECT 
  Id,
  ROUND(AVG(total_steps),0) AS avg_steps,
  ROUND(AVG(sleep_hours),2) AS avg_sleep_hours,
  ROUND(AVG(calories),0) AS avg_calories,
  SUM(non_wear_day) AS total_non_wear_days
FROM `coursera-473006.Bellabeat.leaf_dataset_ready`
GROUP BY Id;
-- Create user-level summary
CREATE OR REPLACE TABLE `coursera-473006.Bellabeat.user_summary` AS
SELECT 
  Id,
  ROUND(AVG(total_steps),0) AS avg_steps,
  ROUND(AVG(sleep_hours),2) AS avg_sleep_hours,
  ROUND(AVG(calories),0) AS avg_calories,
  SUM(non_wear_day) AS total_non_wear_days
FROM `coursera-473006.Bellabeat.leaf_dataset_ready`
GROUP BY Id;

-- Segment users by sleep group
SELECT
  CASE 
    WHEN avg_sleep_hours < 6 THEN 'Short Sleepers (<6h)'
    WHEN avg_sleep_hours BETWEEN 6 AND 8 THEN 'Normal Sleepers (6–8h)'
    ELSE 'Long Sleepers (>8h)'
  END AS sleep_group,
  ROUND(AVG(avg_steps),0) AS avg_steps,
  ROUND(AVG(avg_calories),0) AS avg_calories,
  COUNT(DISTINCT Id) AS users
FROM `coursera-473006.Bellabeat.user_summary`
GROUP BY sleep_group
ORDER BY avg_steps DESC;
SELECT
  CASE 
    WHEN avg_steps >= (SELECT AVG(avg_steps) FROM `coursera-473006.Bellabeat.user_summary`)
    THEN 'More Active Users'
    ELSE 'Less Active Users'
  END AS activity_group,
  ROUND(AVG(avg_sleep_hours),2) AS avg_sleep,
  ROUND(AVG(avg_calories),0) AS avg_calories,
  COUNT(*) AS users
FROM `coursera-473006.Bellabeat.user_summary`
GROUP BY activity_group;
SELECT
  CASE 
    WHEN total_non_wear_days = 0 THEN 'Highly Engaged'
    WHEN total_non_wear_days BETWEEN 1 AND 10 THEN 'Moderately Engaged'
    ELSE 'Low Engagement'
  END AS engagement_group,
  COUNT(*) AS users,
  ROUND(AVG(avg_steps),0) AS avg_steps,
  ROUND(AVG(avg_sleep_hours),2) AS avg_sleep
FROM `coursera-473006.Bellabeat.user_summary`
GROUP BY engagement_group
ORDER BY users DESC;
