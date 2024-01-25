FROM python:3.9

RUN pip install pandas

WORKDIR /main

COPY pipeline.py pipeline.py

ENTRYPOINT [ "python", "pipeline.py" ]