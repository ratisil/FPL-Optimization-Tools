FROM python:3.11-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends git wget ca-certificates build-essential cmake \
  && update-ca-certificates \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/*

# Install HiGHS solver
RUN wget https://github.com/ERGO-Code/HiGHS/archive/refs/tags/v1.10.0.tar.gz -O highs.tar.gz && \
    tar -xf highs.tar.gz && \
    cd HiGHS-1.10.0 && \
    mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install && \
    cd ../.. && \
    rm -rf HiGHS-1.10.0 highs.tar.gz

RUN useradd --create-home --shell /bin/bash app_user

WORKDIR /fpl-optimization

COPY . .

# Upgrade pip and install packages without cache
RUN python -m pip install -r requirements.txt
# RUN python -m pip install --upgrade pip
# RUN python -m pip install --no-cache-dir -r requirements.txt

RUN chown -R app_user /fpl-optimization
RUN chmod -R 755 /fpl-optimization

WORKDIR /fpl-optimization/run/

# Create tmp folder
RUN mkdir -p /fpl-optimization/run/tmp

USER app_user

# ENTRYPOINT [ "python", "solve_regular.py" ]  <- REMOVE THIS
CMD ["tail", "-f", "/dev/null"]  # Keep-alive command