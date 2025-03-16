FROM python:3.8-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends git \
  && apt-get install -y coinor-cbc \
  && apt-get install -y coinor-libcbc-dev \
  && apt-get install -y wget \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /fpl-optimization

COPY . .

RUN pip install -r requirements.txt

WORKDIR /fpl-optimization/run/

ENTRYPOINT [ "python", "solve_regular.py" ]