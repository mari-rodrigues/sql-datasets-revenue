-- Question 2: Which ad and in which channel the performance was the highest?

SELECT
  a.format,
  a.channel,
  a.image_style,
  SUM (impressions) as total_impressions,
  SUM (c.clicks) as total_clicks,
  SUM (c.conversions) as total_conversions,
  ROUND (SUM (c.conversions) / SUM(clicks), 2) as Conversion_Rate,
  ROUND (SUM (c.clicks) / SUM (c.impressions), 2) as CTR,
  ROUND (SUM (c.conversions) / SUM (c.impressions), 4) as Impression_To_Conversion
FROM `ad_data.ad_creatives` a
JOIN `ad_data.campaign_data`c on c.campaign_id = a.campaign_id
GROUP BY 1,2,3
ORDER BY Impression_To_Conversion DESC 
