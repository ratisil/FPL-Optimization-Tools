# syntax=docker/dockerfile:1
FROM python:3.13-slim

ENV PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

RUN apt-get update \
 && apt-get install -y --no-install-recommends git ca-certificates \
 && update-ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /fpl-optimization
COPY . .

# deps
RUN python -m pip install -U pip wheel \
 && if [ -f requirements.txt ]; then pip install -r requirements.txt; fi \
 && pip install --only-binary=:all: -U highspy

# helper: convenient manual runner that sets the right path
RUN printf '#!/bin/sh\ncd /fpl-optimization\nexec env PYTHONPATH=/fpl-optimization python -m run.solve "$@"\n' \
    > /usr/local/bin/solve && chmod +x /usr/local/bin/solve

# non-root user + tmp
RUN useradd --create-home --shell /bin/bash app_user \
 && mkdir -p /fpl-optimization/run/tmp \
 && chown -R app_user /fpl-optimization
USER app_user

# stay alive; you’ll run the solver manually
WORKDIR /fpl-optimization
CMD ["tail", "-f", "/dev/null"]
