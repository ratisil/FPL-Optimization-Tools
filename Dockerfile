# syntax=docker/dockerfile:1
FROM python:3.13-slim

ENV PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# minimal system deps (no compiler needed if we use highspy wheels)
RUN apt-get update \
 && apt-get install -y --no-install-recommends git ca-certificates \
 && update-ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /fpl-optimization
COPY . .

# Upgrade pip and install deps
RUN python -m pip install -U pip wheel \
 && if [ -f requirements.txt ]; then pip install -r requirements.txt; fi \
 # ensure HiGHS Python wrapper is latest (prefer wheel)
 && pip install --only-binary=:all: -U highspy

# non-root user + writable tmp
RUN useradd --create-home --shell /bin/bash app_user \
 && mkdir -p /fpl-optimization/run/tmp \
 && chown -R app_user /fpl-optimization
USER app_user

WORKDIR /fpl-optimization/run
# run once by default; change to tail if you prefer a keep-alive container
CMD ["python", "solve.py"]
