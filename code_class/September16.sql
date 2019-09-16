# areal interpolation

# get the values that you need
SELECT a.boroct2010, 
	a.population, 
	ST_Area(a.the_geom) as total, 
	ST_Area(ST_Intersection(a.the_geom,b.the_geom)) as infloodplain
FROM nyc_census_tracts_2010_pop_queens a, 
floodplain_2020s_100_year b 

# create a sub-query block
WITH areavalues as (
SELECT a.boroct2010, 
	a.population, 
	ST_Area(a.the_geom) as total,
	ST_Area(ST_Intersection(a.the_geom,b.the_geom)) as infloodplain
FROM nyc_census_tracts_2010_pop_queens a, 
floodplain_2020s_100_year b)

SELECT * FROM areavalues
WHERE infloodplain > 0

# compute population by census tract within floodplain
WITH areavalues as (
SELECT a.boroct2010, 
	a.population, 
	ST_Area(a.the_geom) as total,
	ST_Area(ST_Intersection(a.the_geom,b.the_geom)) as infloodplain
FROM nyc_census_tracts_2010_pop_queens a, 
floodplain_2020s_100_year b)
SELECT boroct2010, population, infloodplain, total, infloodplain / total as percentinflood, population * (infloodplain / total) as popinflood
FROM areavalues

# map the number of people within the floodplain
WITH areavalues as (
SELECT a.boroct2010, 
	a.population, 
	ST_Area(a.the_geom) as total,
	ST_Area(ST_Intersection(a.the_geom,b.the_geom)) as infloodplain,
	a.the_geom_webmercator,
  a.the_geom
FROM nyc_census_tracts_2010_pop_queens a, 
floodplain_2020s_100_year b)

SELECT boroct2010, population, infloodplain / total as percentinflood, population * (infloodplain / total) as popinflood, the_geom_webmercator,the_geom
FROM areavalues