FROM python:3.8-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends git wget ca-certificates build-essential cmake curl unzip \
  && update-ca-certificates \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/*

# Install Google Chrome (stable)
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update \
    && apt-get install -y --no-install-recommends google-chrome-stable

# Install ChromeDriver (matching Chrome version)
RUN CHROME_VERSION=$(google-chrome --version | cut -d ' ' -f 3 | cut -d '.' -f 1) \
    && CHROMEDRIVER_URL=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION") \
    && wget -q --no-verbose -O /tmp/chromedriver_linux64.zip "$CHROMEDRIVER_URL/chromedriver_linux64.zip" \
    && unzip /tmp/chromedriver_linux64.zip -d /usr/local/bin/ \
    && rm -f /tmp/chromedriver_linux64.zip \
    && chmod +x /usr/local/bin/chromedriver

# Install HiGHS solver
RUN wget https://github.com/ERGO-Code/HiGHS/archive/refs/tags/v1.9.0.tar.gz -O highs.tar.gz && \
    tar -xf highs.tar.gz && \
    cd HiGHS-1.9.0 && \
    mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install && \
    cd ../.. && \
    rm -rf HiGHS-1.9.0 highs.tar.gz

RUN useradd --create-home --shell /bin/bash app_user

WORKDIR /fpl-optimization

COPY . .

RUN python -m pip install -r requirements.txt

RUN chown -R app_user /fpl-optimization
RUN chmod -R 755 /fpl-optimization

WORKDIR /fpl-optimization/run/

# Create tmp folder
RUN mkdir -p /fpl-optimization/run/tmp

USER app_user

ENTRYPOINT [ "python", "solve_regular.py" ]
# NO CMD HERE