# docker-motioneye
Container for motionEye, a web-based user interface for motion.
( https://github.com/ccrisan/motioneye )

## Notes
* By default the container will expose the webinterface on port **tcp/8765**.
* This docker is based on **resin/rpi-raspbian:latest** images with motioneye configured.

## Prerequisite:
1. Enable camera module on rpi using `sudo raspi-config`
2. Run the following command `sudo modprobe bcm2835-v4l2` so raspbian loads the module for the camera.

## Usage

Fire up an instance with web interface available on port 8000:  
`docker run -ti --device=/dev/video0 -p 8000:8765 -v ~/motioneye/setting:/etc/motioneye -v ~/motioneye/data:/var/lib/motioneye hazmei/motioneye`
