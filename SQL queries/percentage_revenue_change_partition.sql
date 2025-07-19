-- Calculate the percentage of revenue change from the previous day, break down by campaign an date 

WITH revenue_by_day AS (
  SELECT 
    campaign_id,
    date,
    SUM(revenue_usd) AS daily_revenue
  FROM `ad_data.campaign_data`
  GROUP BY campaign_id, date
),
revenue_with_lag AS (
  SELECT 
    campaign_id,
    date,
    daily_revenue,
    LAG(daily_revenue) OVER (PARTITION BY campaign_id ORDER BY date) AS prev_day_revenue
  FROM revenue_by_day
)
SELECT 
  campaign_id,
  date,
  daily_revenue,
  prev_day_revenue,
  daily_revenue - prev_day_revenue AS revenue_change,
  ROUND(
    SAFE_DIVIDE(daily_revenue - prev_day_revenue, prev_day_revenue) * 100, 
    2
  ) AS pct_change
FROM revenue_with_lag
WHERE prev_day_revenue IS NOT NULL
