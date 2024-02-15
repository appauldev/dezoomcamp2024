from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.google_cloud_storage import GoogleCloudStorage
from pandas import DataFrame
from os import path
import os
import pyarrow.parquet as pq
import pyarrow as pa

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def export_data_to_google_cloud_storage(df: DataFrame, **kwargs) -> None:
    # setup the environment for loading the config and GCP credentials
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'
    config_values = ConfigFileLoader(config_path, config_profile)
    os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = config_values['GOOGLE_SERVICE_ACC_KEY_FILEPATH']

    bucket_name = 'wk3_hw_bucket'
    object_key = 'green_taxi_dataset_parquet'
    bucket_path = f"{bucket_name}/{object_key}"

    GREEN_TAXI_DIR = kwargs['GREEN_TAXI_DIR']
    files = [f"{GREEN_TAXI_DIR}/{file}" for file in os.listdir(GREEN_TAXI_DIR) if file.endswith('.parquet')]
    gcs_fs = pa.fs.GcsFileSystem()

    for file in sorted(files):
        print(f"uploading {file}")
        table = pq.read_table(file)
        file_name = file.split("/")[-1].replace(".parquet", "")
        pq.write_to_dataset(
            table,
            root_path=f"{bucket_path}/{file_name}",
            filesystem=gcs_fs,
            basename_template="data_{i}.parquet"
        )
        print(f"{file} has been uploaded!")

    # 

    # GoogleCloudStorage.with_config(ConfigFileLoader(config_path, config_profile)).export(
    #     df,
    #     bucket_name,
    #     object_key,
    # )
