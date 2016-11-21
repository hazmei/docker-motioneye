# docker-motioneye
Container for motionEye, a web-based user interface for motion.
( https://github.com/ccrisan/motioneye )

## Notes
* By default the container will expose the webinterface on port **tcp/8765**.
* This docker is based on **resin/rpi-raspbian:latest** images with motioneye configured.

## Prerequisite
1. Enable camera module on rpi using `sudo raspi-config`
2. Run the following command `sudo modprobe bcm2835-v4l2` so raspbian loads the module for the camera on boot.
3. Install docker via `curl -sSL https://get.docker.com | sh`
4. Motioneye data directory as well as motioneye setting directory and file exist in the directory specified. You will need the motioneye setting file (motioneye.conf) from this repo.

## Usage

Fire up an instance with web interface available on port 8000:  
`sudo docker run --restart=always -ti -d --device=/dev/video0 -p 8000:8765 -v ~/motioneye/setting:/etc/motioneye -v ~/motioneye/data:/var/lib/motioneye -v /etc/localtime:/etc/localtime:ro hazmei/motioneye`

You may set your own directory for motioneye settings and data as well as the host port  
`sudo docker run --restart=always -ti -d --device=/dev/video0 -p <host_port>:8765 -v <host_motioneye_setting_dir>:/etc/motioneye -v <host_motioneye_data_dir>:/var/lib/motioneye -v /etc/localtime:/etc/localtime:ro hazmei/motioneye`

## Building docker image from Dockerfile
1. Download the Dockefile configuration into the pi.
2. Make sure docker is installed. (look under prerequisite on how to install docker)
3. Run the following command `sudo docker build -t <repo>/<buildname> .`
