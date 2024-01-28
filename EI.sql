--Retrieve all columns from the "Developing Asia" subregion for the year 2020.
SELECT * FROM Economicdata 
WHERE subregion = 'Developing Asia' AND year = 2020

--List the countries in the "Caucasus and Central Asia" subregion along with their inflation rates for the year 2019.
SELECT regionalmember , inflation FROM Economicdata 
WHERE subregion = 'Caucasus and Central Asia' AND regionalmember != 'Caucasus and Central Asia'

--Get the GDP growth and current account balance for Armenia for the years 2017 and 2018.
SELECT regionalmember, gdpgrowth , currentaccountbalance FROM Economicdata 
WHERE regionalmember = 'Armenia' AND year IN (2017,2018)

--Calculate the average inflation rate for each subregion across all available years.
SELECT subregion, AVG (inflation )AS AVG_inflation FROM Economicdata
GROUP BY subregion
order by AVG_inflation

--Find the top 3 countries with the highest GDP growth in 2021. Include subregion, country code, and GDP growth in the result.
SELECT subregion, regionalmember, gdpgrowth , countrycode FROM Economicdata 
WHERE year = 2021
ORDER BY gdpgrowth DESC
LIMIT 3

--Retrieve the years where the inflation rate was above 5% for any country in the "East Asia" subregion. Include subregion, country, year, and inflation rate in the result.
SELECT year, subregion, regionalmember, inflation  FROM Economicdata
WHERE subregion = 'East Asia' AND inflation > 5 

--For each subregion, find the year with the highest GDP growth and the corresponding country. Include subregion, country, and GDP growth in the result.
WITH Rankedgdp AS
(
SELECT subregion, 
	regionalmember, 
	year, 
	gdpgrowth,
    RANK() OVER (PARTITION BY subregion ORDER BY gdpgrowth DESC) AS Rank_gdpgrowth
	FROM Economicdata)
   SELECT subregion, regionalmember, year, gdpgrowth 
   FROM Rankedgdp 
   WHERE Rank_gdpgrowth = 1;

--Calculate the cumulative GDP growth for each country in the "South Asia" subregion from 2017 to 2022. Display subregion, country, and cumulative GDP growth.
SELECT subregion, 
	regionalmember, 
	year, 
	gdpgrowth,
    SUM(gdpgrowth) OVER (PARTITION BY regionalmember ORDER BY year DESC) AS cumulative_GDP 
	FROM Economicdata 
	WHERE subregion = 'South Asia' AND year BETWEEN 2017 AND 2022
	
--Identify the country with the highest current account balance in 2023. Include subregion, country, and current account balance in the result.
    SELECT subregion, 
	regionalmember, 
	year, currentaccountbalance FROM Economicdata 
	ORDER BY currentaccountbalance DESC 
	LIMIT 1
	


