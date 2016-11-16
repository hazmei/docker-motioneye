FROM resin/rpi-raspbian:latest

MAINTAINER hazmei

# Enable systemd
ENV INITSYSTEM on
ENV TAG 0.1

RUN apt-get update \
	&& apt-get install -y wget \
	libjpeg8 \
	libjpeg8-dev \
	python \
	python-dev \
	build-essential \
	gcc \
	nano

RUN apt-get remove -y libavcodec-extra-56 \
	libavformat56 \
	libavresample2 \
	libavutil54

RUN apt-get install -y python-pip \
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
	v4l-utils

RUN echo 'bcm2835-v4l2' >> /etc/modules \
	&& wget https://github.com/ccrisan/motioneye/wiki/precompiled/ffmpeg_3.1.1-1_armhf.deb \
	&& dpkg -i ffmpeg_3.1.1-1_armhf.deb \
	&& wget https://github.com/Motion-Project/motion/releases/download/release-4.0.1/pi_jessie_motion_4.0.1-1_armhf.deb \
	&& dpkg -i pi_jessie_motion_4.0.1-1_armhf.deb \
	&& pip install motioneye \
	&& mkdir -p /etc/motioneye \
	&& cp /usr/local/share/motioneye/extra/motioneye.conf.sample /etc/motioneye/motioneye.conf \
	&& mkdir -p /var/lib/motioneye \
	&& cp /usr/local/share/motioneye/extra/motioneye.systemd-unit-local /etc/systemd/system/motioneye.service \
	&& echo '# set to 'yes' to enable the motion daemon' > /etc/default/motion \
	&& echo 'start_motion_daemon=yes' >> /etc/default/motion

EXPOSE 8765

USER root

ENTRYPOINT []

CMD modprobe bcm2835-v4l2
CMD /usr/local/bin/meyectl startserver -c /etc/motioneye/motioneye.conf
