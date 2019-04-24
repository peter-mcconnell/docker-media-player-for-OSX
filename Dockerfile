FROM debian:sid-slim
LABEL maintainer "Peter McConnell <me@petermcconnell.com>"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
      ca-certificates \
      alsa-utils \
      libasound2 \
      libasound2-plugins \
      pulseaudio \
      pulseaudio-utils \
      python3.7-minimal \
      python3-setuptools \
      python3-pip \
      mplayer \
      mpv \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* && \
    pip3 install mps-youtube youtube-dl

ENV HOME /home/pulseaudio
RUN useradd --create-home --home-dir $HOME pulseaudio \
    && usermod -aG audio,pulse,pulse-access pulseaudio \
    && chown -R pulseaudio:pulseaudio $HOME

WORKDIR $HOME

COPY default.pa /etc/pulse/default.pa
COPY client.conf /etc/pulse/client.conf
COPY daemon.conf /etc/pulse/daemon.conf

ENTRYPOINT [ "mpsyt" ]
