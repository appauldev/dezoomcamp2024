import io
import pandas as pd
import requests

if "data_loader" not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if "test" not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    months = [10, 11, 12]
    urls = [
        f"https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-{month_num}.csv.gz"
        for month_num in months
    ]

    # indicate the data types to make good use of memory
    taxi_dtypes = {
        "VendorID": pd.Int64Dtype(),
        "passenger_count": pd.Int64Dtype(),
        "trip_distance": float,
        "RatecodeID": pd.Int64Dtype(),
        "store_and_fwd_flag": str,
        "PULocationID": pd.Int64Dtype(),
        "DOLocationID": pd.Int64Dtype(),
        "payment_type": pd.Int64Dtype(),
        "trip_type": pd.Int64Dtype(),
        "fare_amount": float,
        "extra": float,
        "ehail_fee": float,
        "mta_tax": float,
        "tip_amount": float,
        "tolls_amount": float,
        "improvement_surcharge": float,
        "total_amount": float,
        "congestion_surcharge": float,
    }
    cols_date = ["lpep_pickup_datetime", "lpep_dropoff_datetime"]

    # pd.concat is better used when all the dataframes are collected first before the concatenation
    # as suggested here https://pandas.pydata.org/pandas-docs/stable/user_guide/merging.html#concat
    downloaded_dfs = []
    for url in urls:
        new_df = pd.read_csv(
            url, compression="gzip", dtype=taxi_dtypes, parse_dates=cols_date
        )
        downloaded_dfs.append(new_df)

    green_taxi_df = pd.concat(downloaded_dfs)

    return green_taxi_df
    # response = requests.get(url)

    # return pd.read_csv(io.StringIO(response.text), sep=',')


# @test
# def test_output(output, *args) -> None:
#     """
#     Template code for testing the output of the block.
#     """
#     assert output is not None, 'The output is undefined'
