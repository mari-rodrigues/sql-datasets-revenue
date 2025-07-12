-- Question 3: From the channels with ROAS highes than 1, what is the avg. number of conversions?

WITH campaign_roas AS (
  SELECT
    campaign_id,
    channel,
    SUM(revenue_usd) AS total_revenue,
    SUM(spend_usd) AS total_spend,
    SUM(conversions) AS total_conversions,
    ROUND(SUM(revenue_usd) / NULLIF(SUM(spend_usd), 0), 2) AS roas
  FROM `ad_data.campaign_data`
  GROUP BY campaign_id, channel
)

SELECT
  channel,
  COUNT(campaign_id) AS num_campaigns,
  ROUND(AVG(total_conversions), 2) AS avg_conversions
FROM campaign_roas
WHERE roas > 1
GROUP BY channel
ORDER BY avg_conversions DESC;



