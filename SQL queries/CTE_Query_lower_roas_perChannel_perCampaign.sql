-- Which campaigns and channels had ROAS below 0.9 and how many conversions did they have

WITH google_low_roas AS (
  SELECT
    campaign_id,
    channel,
    country,
    SUM(conversions) as conversions,
    ROUND (SUM(revenue_usd), 2) total_revenue,
    ROUND (SUM(spend_usd), 2) total_spend,
    ROUND(SUM(revenue_usd) / NULLIF(SUM(spend_usd), 0), 2) AS roas
  FROM `ad_data.campaign_data`
  GROUP BY 1,2,3
  HAVING roas < 0.9
)

SELECT
  campaign_id,
  channel,
  conversions,
  total_spend,
FROM google_low_roas
GROUP BY 1,2,3,4
ORDER BY total_spend DESC;
