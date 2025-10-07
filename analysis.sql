-- Per-user averages
SELECT 
  Id,
  ROUND(AVG(total_steps),0) AS avg_steps,
  ROUND(AVG(total_minutes_asleep)/60,2) AS avg_sleep_hours,
  ROUND(AVG(calories),0) AS avg_calories,
  SUM(non_wear_day) AS non_wear_days
FROM `coursera-473006.Bellabeat.leaf_dataset`
GROUP BY Id
ORDER BY avg_steps DESC;
SELECT 
  column_name, data_type
FROM `coursera-473006.Bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'leaf_dataset';
SELECT 
  COUNT(*) AS total_rows,
  COUNTIF(total_minutes_asleep IS NULL) AS missing_sleep,
  COUNTIF(total_steps IS NULL) AS missing_steps
FROM `coursera-473006.Bellabeat.leaf_dataset`;
SELECT 
  Id,
  activity_date,
  total_steps,
  ROUND(total_minutes_asleep/60, 2) AS sleep_hours,
  calories
FROM `coursera-473006.Bellabeat.leaf_dataset`;
CREATE OR REPLACE TABLE `coursera-473006.Bellabeat.leaf_dataset_ready` AS
SELECT 
  Id,
  activity_date,
  total_steps,
  sedentary_minutes,
  calories,
  ROUND(total_minutes_asleep/60, 2) AS sleep_hours,
  total_time_in_bed,
  sleep_anomaly,
  non_wear_day
FROM `coursera-473006.Bellabeat.leaf_dataset`;
