/*markdown
### #3 Count records
*/

-- #3 Count records
SELECT COUNT(*)
FROM green_taxi_data
WHERE
    to_char(lpep_pickup_datetime, 'YYYY-MM-DD') = '2019-09-18'

/*markdown
### #4 Largest trip for each day
*/

-- #4 Largest trip for each day
SELECT lpep_pickup_datetime, trip_distance
FROM green_taxi_data
ORDER BY trip_distance DESC
LIMIT 1;

/*markdown
### #5 Three biggest pick up Boroughs

*/

-- SELECT * FROM tzlookup;

SELECT
    tzlookup."Borough",
    SUM(total_amount) AS sum_total_amount
FROM green_taxi_data
INNER JOIN tzlookup
    ON green_taxi_data."PULocationID" = tzlookup."LocationID"
WHERE
    to_char(lpep_pickup_datetime, 'YYYY-MM-DD') = '2019-09-18'
GROUP BY tzlookup."Borough"
HAVING SUM(total_amount) > 50000

/*markdown
### Largest tip
*/

WITH pickup_astoria_sept_2019 AS (
    SELECT
        green_taxi_data."PULocationID",
        tzlookup."LocationID",
        green_taxi_data."DOLocationID",
        green_taxi_data.tip_amount AS tip
    FROM green_taxi_data
    INNER JOIN tzlookup
        ON green_taxi_data."PULocationID" = tzlookup."LocationID"
    WHERE
        tzlookup."Zone" = 'Astoria' AND
        green_taxi_data.lpep_pickup_datetime >='2019-09-01' AND
        green_taxi_data.lpep_pickup_datetime < '2019-09-30'
    ORDER BY green_taxi_data.tip_amount DESC
)

SELECT
    tzlookup."Zone",
    pickup_astoria_sept_2019.tip
FROM tzlookup
INNER JOIN pickup_astoria_sept_2019
    ON tzlookup."LocationID" = pickup_astoria_sept_2019."DOLocationID"
ORDER BY pickup_astoria_sept_2019.tip DESC
LIMIT 1