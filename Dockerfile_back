FROM python:3.8-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends git wget \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/*

# Install HiGHS solver
RUN wget https://github.com/ERGO-Code/HiGHS/releases/download/v1.6.0/highs-v1.6.0-Linux.tar.gz && \
    tar -xf highs-v1.6.0-Linux.tar.gz && \
    cp highs-v1.6.0-Linux/bin/highs /usr/local/bin/ && \
    rm -rf highs-v1.6.0-Linux highs-v1.6.0-Linux.tar.gz

RUN useradd --create-home --shell /bin/bash app_user

WORKDIR /fpl-optimization

COPY . .

RUN python -m pip install -r requirements.txt

RUN chown -R app_user /fpl-optimization
RUN chmod -R 755 /fpl-optimization

WORKDIR /fpl-optimization/run/

USER app_user

ENTRYPOINT [ "python", "solve_regular.py" ]
# NO CMD HERE