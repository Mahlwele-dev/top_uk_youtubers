/*
1. Define the variables
2. Create a CTE that rounds the average views per video
3. select the columns that required for the analytics
4. Filter the results by the youthube channels with highest subscriber bases
5. order by net_profit(from highest to lowest)

*/

DECLARE @conversionRate FLOAT = 0.02;
DECLARE @productCost FLOAT = 5.0;
DECLARE @campaignCost FLOAT = 50000;
-- 2 CTE THAT ROUNDS VIEWS PER VIDEO
WITH ChannelData AS (
	SELECT 
		channel_name,
		total_subscribers,
		total_views,ss
		total_videos,
		ROUND((CAST(total_views AS FLOAT)/ total_videos), -4) AS rounded_avg_views_per_video
	FROM view_uk_youtubers_2024
)


-- 3. select columns that are required for the analysis
SELECT 
	channel_name, 
	rounded_avg_views_per_video,
	(rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
	(rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
	(rounded_avg_views_per_video * @conversionRate *@productCost) - @campaignCost AS Net_profit

FROM 
	ChannelData
WHERE 
	Channel_name IN ( 'NoCopyrightSounds ', 'DanTDM', 'Dan Rhodes')
ORDER BY Net_profit DESC;