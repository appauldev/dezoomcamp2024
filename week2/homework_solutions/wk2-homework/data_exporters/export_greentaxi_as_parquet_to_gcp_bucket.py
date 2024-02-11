from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.google_cloud_storage import GoogleCloudStorage
from pandas import DataFrame
import os
from os import path
import pyarrow as pa
import pyarrow.parquet as pq
import pyarrow.dataset as ds
from datetime import datetime


if "data_exporter" not in globals():
    from mage_ai.data_preparation.decorators import data_exporter



@data_exporter
def export_data_to_google_cloud_storage(df: DataFrame, **kwargs) -> None:
    """
    Template for exporting data to a Google Cloud Storage bucket.
    Specify your configuration settings in 'io_config.yaml'.

    Docs: https://docs.mage.ai/design/data-loading#googlecloudstorage
    """
    config_path = path.join(get_repo_path(), "io_config.yaml")
    config_profile = "default"


    config_values = ConfigFileLoader(config_path, config_profile)
    os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = config_values['GOOGLE_SERVICE_ACC_KEY_FILEPATH']

    bucket_name = "wk2_hw_bucket"
    object_key = "lpep_pickup_date_partitions"
    SAVE_DIR_PD = 'exported_datasets/green_taxi'
    root_path = f"{bucket_name}/{object_key}"


    # i thought pyarrow should be used to create the parquet files :3
    # main guide: https://arrow.apache.org/docs/python/getstarted.html
    # convert the dataframe to a readable format for pyarrow
    pq_main_table = pa.Table.from_pandas(df)
    # save the partitioned data as parquet files
    SAVE_DIR = "exported_datesets/green_taxi_dataset"
    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        pq_main_table,
        root_path=root_path,
        partition_cols=['lpep_pickup_date'],
        filesystem=gcs
    )

