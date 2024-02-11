import pandas as pd

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    # remove rides where there is no passenger
    data = data[data["passenger_count"] > 0]
    
    # remove rides where the trip distance is 0
    data = data[data["trip_distance"] > 0]

    # create lpep_pickup_date column
    data["lpep_pickup_date"] = data["lpep_pickup_datetime"].dt.date

    # rename nonCamelCase columns
    data.rename(
    columns={
        "VendorID": "vendor_id",
        "RatecodeID": "rate_code_id",
        "PULocationID": "pu_lid",
        "DOLocationID": "do_lid",
    },
    inplace=True,
    )

    # # check the unique data under vendor_id
    # print(set(data['vendor_id']))
    
    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

@test
def test_passenger_count_no_zero(output, *args) -> None:
    assert output["passenger_count"].isin([0]).sum() == 0, "ERROR: Rides with zero (0) passengers exist."

@test
def test_trip_distance_no_zero(output, *args) -> None:
    assert output["trip_distance"].isin([0]).sum() == 0, "ERROR: Trips with zero (0) distance exist."

@test
def check_if_vendor_id_col_exist(output, *args) -> None:
    assert "vendor_id" in output.columns, "ERROR: vendor_id column does not exist"
