############################################################
# Dockerfile to build motioneye container
# Based on resin/rpi-raspbian:latest image
############################################################

FROM resin/rpi-raspbian:latest

MAINTAINER hazmei

# Enable systemd
ENV INITSYSTEM on
ENV TAG 0.2

RUN apt-get update \
&& apt-get clean \
&& apt-get install -y wget \
	libjpeg8 \
	libjpeg8-dev \
	python \
	python-dev \
	build-essential \
	gcc \
	v4l-utils \
&& echo 'bcm2835-v4l2' >> /etc/modules \
	&& wget https://github.com/ccrisan/motioneye/wiki/precompiled/ffmpeg_3.1.1-1_armhf.deb \
	&& dpkg -i ffmpeg_3.1.1-1_armhf.deb \
&& apt-get remove -y libavcodec-extra-56 \
	libavformat56 \
	libavresample2 \
	libavutil54 \
&& apt-get install -y python-pip \
	python-dev \
	curl \
	libssl-dev \
	libcurl4-openssl-dev \
	libjpeg-dev \
	libx264-142 \
	libavcodec56 \
	libavformat56 \
	libmysqlclient18 \
	libswscale3 \
	libpq5 \
&& wget https://github.com/Motion-Project/motion/releases/download/release-4.0.1/pi_jessie_motion_4.0.1-1_armhf.deb \
	&& dpkg -i pi_jessie_motion_4.0.1-1_armhf.deb \
	&& pip install motioneye \
	&& pip install pytz \
	&& mkdir -p /etc/motioneye \
	&& cp /usr/local/share/motioneye/extra/motioneye.conf.sample /etc/motioneye/motioneye.conf \
	&& mkdir -p /var/lib/motioneye \
	&& cp /usr/local/share/motioneye/extra/motioneye.systemd-unit-local /etc/systemd/system/motioneye.service \
	&& echo '# set to 'yes' to enable the motion daemon' > /etc/default/motion \
	&& echo 'start_motion_daemon=yes' >> /etc/default/motion \
	&& rm ffmpeg_3.1.1-1_armhf.deb pi_jessie_motion_4.0.1-1_armhf.deb \
&& apt-get purge -y gcc \
	wget \
	motion \
&& apt-get autoremove -y \
&& apt-get clean \
&& apt-get install -y rpi-update \
	motion \
	&& rpi-update \
	&& apt-get purge -y rpi-update \
	&& apt-get clean

# Set volume directory that will be shared with host
VOLUME ["/etc/motioneye","/var/lib/motioneye"]

EXPOSE 8765

USER root

ENTRYPOINT []

CMD /usr/local/bin/meyectl startserver -c /etc/motioneye/motioneye.conf
