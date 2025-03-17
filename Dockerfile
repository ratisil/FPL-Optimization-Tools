FROM python:3.8-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends git wget ca-certificates \
  && update-ca-certificates \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/*

# Install HiGHS solver (using the new URL)
RUN wget https://github.com/ERGO-Code/HiGHS/archive/refs/tags/v1.9.0.tar.gz -O highs.tar.gz && \
    tar -xf highs.tar.gz && \
    find . -name "highs" -type f -executable -print -exec cp {} /usr/local/bin/ \; && \
    rm -rf HiGHS-* highs.tar.gz

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