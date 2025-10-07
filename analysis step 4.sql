SELECT
  CORR(total_steps, sleep_hours) AS corr_steps_sleep,
  CORR(total_steps, calories) AS corr_steps_calories,
  CORR(sedentary_minutes, sleep_hours) AS corr_sedentary_sleep
FROM `coursera-473006.Bellabeat.leaf_dataset_ready`;
WITH user_sleep AS (
  SELECT
    Id,
    ROUND(AVG(sleep_hours),2) AS avg_sleep_hours,
    ROUND(AVG(total_steps),0) AS avg_steps,
    ROUND(AVG(calories),0) AS avg_calories
  FROM `coursera-473006.Bellabeat.leaf_dataset_ready`
  GROUP BY Id
)
SELECT
  CASE 
    WHEN avg_sleep_hours < 6 THEN 'Short Sleepers (<6h)'
    WHEN avg_sleep_hours BETWEEN 6 AND 8 THEN 'Normal Sleepers (6–8h)'
    ELSE 'Long Sleepers (>8h)'
  END AS sleep_group,
  ROUND(AVG(avg_steps),0) AS avg_steps,
  ROUND(AVG(avg_calories),0) AS avg_calories,
  COUNT(*) AS users
FROM user_sleep
GROUP BY sleep_group;
SELECT
  ROUND(AVG(sedentary_minutes),0) AS avg_sedentary_minutes,
  ROUND(AVG(total_steps),0) AS avg_steps,
  ROUND(AVG(sleep_hours),2) AS avg_sleep_hours
FROM `coursera-473006.Bellabeat.leaf_dataset_ready`;
SELECT
  COUNTIF(sleep_anomaly = 1) AS extreme_sleep_days,
  COUNTIF(non_wear_day = 1) AS non_wear_days,
  MIN(total_steps) AS min_steps,
  MAX(total_steps) AS max_steps,
  MIN(calories) AS min_calories,
  MAX(calories) AS max_calories
FROM `coursera-473006.Bellabeat.leaf_dataset_ready`;
