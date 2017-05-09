FROM vielasis/ubuntu-base

# Set android home
ENV ANDROID_HOME /opt/android-sdk-linux

# Copy additional tools
COPY tools /opt/tools

# Download additional packages
RUN dpkg --add-architecture i386 \
  && apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-8-jdk libc6:i386 libstdc++6:i386 libgcc1:i386 libncurses5:i386 libz1:i386 \
  && rm -rf /var/lib/apt/lists/*

# Download Android SDK & accept android-sdk-license
RUN cd /opt \
    && wget -q https://dl.google.com/android/repository/tools_r25.2.5-linux.zip -O android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm -f android-sdk-tools.zip \
    && mkdir -p ${ANDROID_HOME}/licenses && echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > ${ANDROID_HOME}/licenses/android-sdk-license

# Setup env vars
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

# Install all the necessary items
RUN sdkmanager --package_file=/opt/tools/build-tools.pkgs --package_file=/opt/tools/platform.pkgs --package_file=/opt/tools/extra.pkgs

# Accept other licenses
RUN yes | sdkmanager --licenses

# Version name
ENV ANDROID_LITE_REV 2.0.0