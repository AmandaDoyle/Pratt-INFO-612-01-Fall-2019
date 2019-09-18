# Assignment 2 answers

# 1 What is the most popular complaint type for the timeframe? (5 pts)
SELECT complaint_type, COUNT(*)
FROM table_311_service_requests
GROUP BY complaint_type
ORDER BY count DESC
# Noise - Residential

# 2 Which agency received the most complaints? (5 pts)
SELECT agency, COUNT(*)
FROM table_311_service_requests
GROUP BY agency
ORDER BY count DESC
# NYPD

# 3 Which borough made the most complaints? (5 pts)
SELECT borough, COUNT(*)
FROM table_311_service_requests
GROUP BY borough
ORDER BY count DESC
# Brooklyn

# 4 Which community district is the largest in area? (5 pts)
SELECT cd, ST_Area(the_geom_webmercator)
FROM nycd
ORDER BY ST_Area DESC
# Staten Island 03

# 5 Which, community district had the greatest number of complaints? (10 pts)
SELECT community_board, COUNT(*)
FROM table_311_service_requests
GROUP BY community_board
ORDER BY count DESC
# Manhattan 12

# 6 What is the most popular complaint type in Brooklyn community district 4? And who is the responsible agency? (10 pts)
SELECT complaint_type, agency, COUNT(*)
FROM table_311_service_requests
WHERE community_board = '04 BROOKLYN'
GROUP BY complaint_type, agency
ORDER BY count DESC
# Noise - Residential, NYPD

# 7 Which agency receives the most complaints in Manhattan?  Staten Island? (10 pts)
SELECT agency, COUNT(*)
FROM table_311_service_requests
WHERE borough = 'MANHATTAN'
GROUP BY agency
ORDER BY count DESC
# HPD, DSNY or New York Police Department if you used agency_name

# 8 Which community board has the densest number of 311 complaints? (15 pts)
SELECT COUNT(a.*), 
	b.shape_area, 
    b.borocd, 
    (COUNT(a.*)/b.shape_area) as density
FROM table_311_service_requests a, 
	nycd b
WHERE ST_Within(a.the_geom, b.the_geom)
GROUP BY b.borocd, b.shape_area
ORDER BY density DESC
#Bronx 05

# 9 If you had to recommend the Department of Sanitation to send more resources to one community district, which would it be and why? (15 pts)
# no correct answer or one way to approach question

# 10 Find the community board that you live in.  If you had to advocate for something in your neighborhood, what would it be and why?  Use the 311 data to support your answer.  (20 pts)
# no correct answer or one way to approach question