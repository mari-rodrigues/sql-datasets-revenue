-- Question 1: Which channel delivers the highest ROAS

SELECT
  distinct channel,
  ROUND(SUM(revenue_usd), 2) AS total_revenue,
  ROUND(SUM(spend_usd), 2) AS total_spend,
  ROUND(SUM(revenue_usd) / NULLIF(SUM(spend_usd), 0), 2) AS roas
FROM `ad_data.campaign_data`
GROUP BY channel
ORDER BY roas DESC;