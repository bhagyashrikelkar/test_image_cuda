FROM nvcr.io/nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04

RUN apt-get update && apt-get install gcc g++ git curl software-properties-common -y python3.10 python3.10-dev python3.10-distutils && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && /usr/bin/python3.10 get-pip.py pip==22.3.1 setuptools==65.6.3 wheel==0.38.4 && rm get-pip.py

# RUN pip3 install databricks-connect==13.0.0

RUN /usr/local/bin/pip3.10 install --no-cache-dir virtualenv==20.16.7 && sed -i -r 's/^(PERIODIC_UPDATE_ON_BY_DEFAULT) = True$/\1 = False/' /usr/local/lib/python3.10/dist-packages/virtualenv/seed/embed/base_embed.py && /usr/local/bin/pip3.10 download pip==22.3.1 --dest /usr/local/lib/python3.10/dist-packages/virtualenv_support/

RUN virtualenv --python=/usr/bin/python3.10 /databricks/python3 --system-site-packages --no-download

# RUN /databricks/python3/bin/pip install six==1.16.0 jedi==0.18.1 ipython==8.14.0 ipython-genutils==0.2.0 numpy==1.23.5 pandas==1.5.3 pyarrow==8.0.0 matplotlib==3.7.0 Jinja2==3.1.2 ipykernel==6.25.0 protobuf==4.23.3 grpcio==1.48.2 grpcio-status==1.48.1 databricks-sdk==0.1.6

RUN /databricks/python3/bin/pip install --upgrade pip && \
    pip install six==1.16.0 jedi==0.19.1 ipython==8.22.1 ipython-genutils==0.2.0 numpy==1.26.4 pandas==2.2.0 pyarrow==15.0.0 matplotlib==3.8.3 Jinja2==3.1.3 ipykernel==6.29.2 protobuf==4.25.3 grpcio==1.62.0 grpcio-status==1.62.0 databricks-sdk==0.20.0

ENV PYSPARK_PYTHON=/databricks/python3/bin/python3

RUN /databricks/python3/bin/pip cache purge