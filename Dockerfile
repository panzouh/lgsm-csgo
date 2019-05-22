FROM ubuntu:18.04
ENV TERM=xterm
LABEL maintainer="13paulmurith@gmail.com"

RUN dpkg --add-architecture i386 && \
        apt-get update -y && \
        apt-get install -y \
                binutils \
                bc \
                jq \
                curl \
                wget \
                file \
                bzip2 \
                gzip \
                bsdmainutils \
                unzip \
                python \
                ca-certificates \
                tmux \
                lib32gcc1 \
                libstdc++6 \
                libstdc++6:i386 \
                libstdc++5:i386 \
                libsdl1.2debian \
                default-jdk \
                lib32tinfo5 \
                speex:i386 \
                libtbb2 \
                libcurl4-gnutls-dev:i386 \
                libtcmalloc-minimal4:i386 \
                libncurses5:i386 \
                zlib1g:i386 \
                libldap-2.4-2:i386 \
                libxrandr2:i386 \
                libglu1-mesa:i386 \
                libxtst6:i386 \
                libusb-1.0-0-dev:i386 \
                libxxf86vm1:i386 \
                libopenal1:i386 \
                libssl1.0.0:i386 \
                libgtk2.0-0:i386 \
                libdbus-glib-1-2:i386 \
                libnm-glib-dev:i386 \
                sudo \
                nano

RUN adduser --disabled-password --gecos "" --quiet customuser
RUN usermod -aG sudo customuser
RUN mkdir /csgo
RUN chown customuser:customuser /csgo
RUN chown customuser:customuser /sbin
COPY --chown=customuser:customuser ip /sbin/

USER customuser
RUN chmod -R 755 /csgo
RUN wget https://linuxgsm.com/dl/linuxgsm.sh -P /csgo
WORKDIR /csgo/
RUN chown customuser:customuser linuxgsm.sh
RUN chmod +x linuxgsm.sh
RUN bash linuxgsm.sh csgoserver

RUN chown admin:admin csgoserver
RUN chmod +x csgoserver
RUN ./csgoserver auto-install
RUN bash csgoserver start
RUN bash csgoserver dt
EXPOSE 27015/udp
EXPOSE 27020/udp
EXPOSE 27005/tcp

