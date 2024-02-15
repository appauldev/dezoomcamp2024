import io
import pandas as pd
import requests
import os
from concurrent.futures import ThreadPoolExecutor
from itertools import repeat
from pathlib import Path

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

# function to download the file (https://realpython.com/python-download-file-from-url/#performing-parallel-file-downloads)
def download_file(url, directory_path):
    response = requests.get(url)
    if "content-disposition" in response.headers:
        content_disposition = response.headers["content-disposition"]
        filename = content_disposition.split("filename=")[1]
    else:
        filename = url.split("/")[-1]
        save_path = Path(directory_path + "/" + filename)
    with open(save_path, mode="wb+") as file:
        file.write(response.content)
    print(f"Downloaded file {directory_path}/{filename}")

@data_loader
def load_data_from_api(*args, **kwargs):

    base_url = 'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-{month_num}.parquet'
    month_nums = ['01', '02', '03',
                '04', '05', '06',
                '07', '08', '09',
                '10', '11', '12']

    urls = [base_url.format(month_num=num) for num in month_nums]
    GREEN_TAXI_DIR = kwargs['GREEN_TAXI_DIR']
    # print(urls)

    with ThreadPoolExecutor() as executor:
        if not os.path.exists(GREEN_TAXI_DIR):
            os.makedirs(GREEN_TAXI_DIR)
        executor.map(download_file, urls, repeat(GREEN_TAXI_DIR))

    # response = requests.get(urls[0])

    # print(response.content)

    # return pd.read_csv(io.StringIO(response.text), sep=',')
    return 1


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
