# syntax=docker/dockerfile:1
FROM python:3.13-slim

ENV PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONPATH=/fpl-optimization

# minimal deps; add build-essential+cmake if you want fallback compile of highspy
RUN apt-get update \
 && apt-get install -y --no-install-recommends git ca-certificates \
 && update-ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /fpl-optimization
COPY . .

# deps
RUN python -m pip install -U pip wheel \
 && if [ -f requirements.txt ]; then pip install -r requirements.txt; fi \
 # prefer wheel for HiGHS
 && pip install --only-binary=:all: -U highspy

# --- If you want a compile fallback, swap the two lines above with:
# RUN apt-get update && apt-get install -y --no-install-recommends build-essential cmake \
#  && rm -rf /var/lib/apt/lists/* \
#  && python -m pip install -U pip wheel \
#  && if [ -f requirements.txt ]; then pip install -r requirements.txt; fi \
#  && (pip install --only-binary=:all: -U highspy || pip install --no-binary=:all: highspy)

# user + tmp
RUN useradd --create-home --shell /bin/bash app_user \
 && mkdir -p /fpl-optimization/run/tmp \
 && chown -R app_user /fpl-optimization
USER app_user

WORKDIR /fpl-optimization/run
CMD ["python", "solve.py"]
