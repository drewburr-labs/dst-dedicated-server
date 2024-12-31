FROM debian:latest

LABEL \
    description="Don't Starve Together dedicated server" \
    source="https://github.com/drewburr-labs/dst-dedicated-server"

# Create specific user to run DST server
RUN useradd -ms /bin/bash/ dst
WORKDIR /home/dst

# Install required packages
RUN set -x && \
    dpkg --add-architecture i386 && \
    apt-get update && apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y wget ca-certificates lib32gcc-s1 lib32stdc++6 libcurl4-gnutls-dev:i386 && \
    # Download Steam CMD (https://developer.valvesoftware.com/wiki/SteamCMD#Downloading_SteamCMD)
    wget -q -O - "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - && \
    chown -R dst:dst ./ && \
    # https://github.com/a8m/envsubst
    wget -q -O /usr/local/bin/envsubst https://github.com/a8m/envsubst/releases/download/v1.2.0/envsubst-`uname -s`-`uname -m` && \
    chmod +x /usr/local/bin/envsubst && \
    # Cleanup
    apt-get autoremove --purge -y wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER dst

# Install Don't Starve Together
RUN ./steamcmd.sh \
    +@ShutdownOnFailedCommand 1 \
    +@NoPromptForPassword 1 \
    +force_install_dir /home/dst/server_dst \
    +login anonymous \
    +app_update 343050 validate \
    +quit

RUN mkdir -p /home/dst/.klei/DoNotStarveTogether/DSTWhalesCluster /home/dst/server_dst/mods
VOLUME ["/home/dst/.klei/DoNotStarveTogether/", "/home/dst/server_dst/mods"]

ADD DSTConfigTemplates /home/dst/DSTConfigTemplates
COPY start-container-server.sh /home/dst/
ENTRYPOINT ["/home/dst/start-container-server.sh"]
