# Exploring your dataset with SQL and doing some spatial analyses

# Get the number of records in the file
SELECT COUNT(*) 
FROM table_311_service_requests

# Get the unique complaints
SELECT DISTINCT complaint_type 
FROM table_311_service_requests
ORDER BY complaint_type

# Get the top ten most common complaints
SELECT COUNT(*), complaint_type 
FROM table_311_service_requests
GROUP BY complaint_type
ORDER BY count DESC
LIMIT 10

# Get the area of the neighborhoods
SELECT ST_Area(the_geom), ntaname
FROM nynta
ORDER BY ST_Area DESC

# Return the centroid of each neighborhood
SELECT ST_Centroid(the_geom), ntaname
FROM nynta

# Return the 311 data with the nta that the complaint is in 
# by doing a spatial join between the 311 points and nta polygons
SELECT a.*, b.ntaname
FROM table_311_service_requests a,  nynta b
WHERE ST_Within(a.the_geom, b.the_geom)

# Return the top 5 NTAs with the most 311 complaints
SELECT COUNT(a.*), b.ntaname
FROM table_311_service_requests a,  nynta b
WHERE ST_Within(a.the_geom, b.the_geom)
GROUP BY  b.ntaname
ORDER BY count DESC
LIMIT 10

# Return the complaints that happened in a specific neighborhood
SELECT a.*, b.ntaname
FROM table_311_service_requests a,  nynta b
WHERE ST_Within(a.the_geom, b.the_geom)
AND ntaname = 'East New York'

# Return the complaints for a specific agency that happened in a specific neighborhood
SELECT a.*, b.ntaname
FROM table_311_service_requests a,  nynta b
WHERE ST_Within(a.the_geom, b.the_geom)
AND ntaname = 'East New York'
AND agency = 'DEP'

# Return the distinct complaints for two agencies
SELECT DISTINCT complaint_type, agency
FROM table_311_service_requests
WHERE agency = 'DPR'
OR agency = 'DEP'
ORDER BY complaint_type

# Return complaints that contain tree in the description
SELECT * 
FROM table_311_service_requests
WHERE lower(descriptor) LIKE '%tree%'

# Return agencies with the most complaints where the status is not closed
SELECT agency, COUNT(*) 
FROM table_311_service_requests
WHERE status <> 'Closed'
GROUP BY agency
ORDER BY count DESC

