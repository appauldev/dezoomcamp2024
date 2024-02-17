-- create external table from the parquet files from gcs bucket
CREATE OR REPLACE EXTERNAL TABLE
  week3_homework.green_taxi_data OPTIONS ( format = 'PARQUET',
    uris = ['gs://wk3_hw_bucket/green_taxi_dataset_parquet/*.parquet'] )

-- create materialized tables
-- non-partitioned table
CREATE OR REPLACE TABLE
  week3_homework.green_taxi_data_nonp AS
SELECT
  *
FROM
  week3_homework.green_taxi_data
-- partitioned table
CREATE OR REPLACE TABLE
  week3_homework.green_taxi_data_partitioned
PARTITION BY
  DATE(lpep_pickup_datetime) AS
SELECT
  *
FROM
  week3_homework.green_taxi_data

-- question 2
-- external
SELECT
  DISTINCT PULocationID
FROM
  week3_homework.green_taxi_data
-- materialized
SELECT
  DISTINCT PULocationID
FROM
  week3_homework.green_taxi_data_nonp

-- question 3
SELECT
  COUNT(*)
FROM
  week3_homework.green_taxi_data_nonp
WHERE
  fare_amount = 0

-- question 5
-- non-partitioned
SELECT
  DISTINCT PULocationID
FROM
  week3_homework.green_taxi_data_nonp
WHERE
  DATE(lpep_pickup_datetime) BETWEEN '2022-06-01'
  AND '2022-06-30'
-- partitioned
SELECT
  DISTINCT PULocationID
FROM
  week3_homework.green_taxi_data_partitioned
WHERE
  DATE(lpep_pickup_datetime) BETWEEN '2022-06-01'
  AND '2022-06-30'