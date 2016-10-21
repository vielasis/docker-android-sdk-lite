FROM vielasis/ubuntu-base

MAINTAINER Viel Asis <its.viel@gmail.com>

# Set android home
ENV ANDROID_HOME /opt/android-sdk-linux

# Download additional packages
RUN dpkg --add-architecture i386 \
  && apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-8-jdk libc6:i386 libstdc++6:i386 libgcc1:i386 libncurses5:i386 libz1:i386 \
  && rm -rf /var/lib/apt/lists/*

# Download Android SDK
RUN cd /opt && wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz -O android-sdk.tgz \
  && tar -xzf android-sdk.tgz \
  && rm -f android-sdk.tgz

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Update SDK
RUN  echo y | android update sdk -u -a --filter platform-tools \
  && echo y | android update sdk -u -a --filter extra-android-support \
  && echo y | android update sdk -u -a --filter android-25 \
  && echo y | android update sdk -u -a --filter android-24 \
  && echo y | android update sdk -u -a --filter android-23 \
  && echo y | android update sdk -u -a --filter android-22 \
  && echo y | android update sdk -u -a --filter android-21 \
  && echo y | android update sdk -u -a --filter build-tools-25.0.0 \
  && echo y | android update sdk -u -a --filter build-tools-24.0.3 \
  && echo y | android update sdk -u -a --filter build-tools-24.0.2 \
  && echo y | android update sdk -u -a --filter build-tools-24.0.1 \
  && echo y | android update sdk -u -a --filter build-tools-24.0.0 \
  && echo y | android update sdk -u -a --filter build-tools-23.0.3 \
  && echo y | android update sdk -u -a --filter build-tools-23.0.2 \
  && echo y | android update sdk -u -a --filter build-tools-23.0.1 \
  && echo y | android update sdk -u -a --filter build-tools-22.0.1 \
  && echo y | android update sdk -u -a --filter build-tools-21.1.2 \
  && echo y | android update sdk -u -a --filter extra-android-m2repository \
  && echo y | android update sdk -u -a --filter extra-google-m2repository \
  && echo y | android update sdk -u -a --filter extra-google-google_play_services \
  && echo y | android update sdk -u -a --filter addon-google_apis-google-24 \
  && echo y | android update sdk -u -a --filter addon-google_apis-google-23 \
  && echo y | android update sdk -u -a --filter addon-google_apis-google-22 \
  && echo y | android update sdk -u -a --filter addon-google_apis-google-21

# yyyy-MM-dd_v
ENV ANDROID_LITE_REV 2016-09-21_v1