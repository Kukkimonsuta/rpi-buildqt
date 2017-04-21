# Cross compiling QT width piomxtextures

Based on https://wiki.qt.io/RaspberryPi2EGLFS, https://thebugfreeblog.blogspot.com and https://github.com/raspberrypi/tools

## Notes
 - Uses the `arm-rpi-4.9.3-linux-gnueabihf` toolchain
 - Tested only on RPi 3 (but should support pi1/pi2 just fine)
 - Tested on clean `Ubuntu 16.04 (64 bit)` as host and clean `Raspbian Jessie Lite 2017-01-11` on device
 - Make sure to use 64 bit host OS as that's what the used toolchain is built for
 - To use the toolchain once downloaded you must run `source env.sh` first to setup environment variables.

## Guide
1. update values in `env.sh` (`RPIDEV_DEVICE_*` and optionally other settings)
2. on host install tools and clone this repo
    ```sh
    # install tools
    sudo apt-get install build-essential sshpass git python

    # clone this repo
    mkdir -p ~/raspi
    cd ~/raspi
    git clone https://github.com/Kukkimonsuta/rpi-buildqt.git .
    
    # add executable permissions (this may not be required)
    chmod +x scripts/0_init.sh
    ./scripts/0_init.sh
    ```
3. prepare RPi
    ```sh
    # change gpu memory to 256 MB
    sudo raspi-config

    # uncomment deb-src line
    sudo nano /etc/apt/sources.list

    # install qt dependencies
    sudo apt-get update
    sudo apt-get build-dep qt4-x11
    sudo apt-get build-dep libqt5gui5
    sudo apt-get install libudev-dev libinput-dev libts-dev libxcb-xinerama0-dev libxcb-xinerama0 libsmbclient-dev libssh-dev libv4l-dev libboost1.55-all-dev libbz2-dev

    # remove gstreamer
    sudo apt-get purge *gstreamer*

    # fix old egl
    sudo rm /usr/lib/arm-linux-gnueabihf/libEGL.so.1.0.0 /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2.0.0
    sudo ln -s /opt/vc/lib/libEGL.so /usr/lib/arm-linux-gnueabihf/libEGL.so.1.0.0
    sudo ln -s /opt/vc/lib/libGLESv2.so /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2.0.0

    # create qt install dir (must be at the path `QT_DEVICE_DIR`, owned by user `RPIDEV_DEVICE_USER` defined in `env.sh`)
    sudo mkdir -p /usr/local/qt5.8
    sudo chown pi:pi /usr/local/qt5.8

    # register the lib directory in ld
    echo /usr/local/qt5.8/lib | sudo tee /etc/ld.so.conf.d/qt5.8.conf
    ```
4. run `1_download.sh`, this will download all required repositories
5. run `2_sync.sh`, this will connect to RPi and creates a sysroot for crosscompilation
6. run `3.0_build_qtbase.sh`, this will build and install `qtbase`
7. run `3.*_build_*.sh`, this will build and install modules for qt. Feel free to add more from https://github.com/qt
8. run `4_build_piomxtextures.sh`, this will build and install `piomxtextures`
9. run `5_sync_to_device.sh`, this will copy qt5 to the device
10. on RPi run `ldconfig`
    ```
    sudo ldconfig
    ```
11. `~/piomxtextures_pocplayer /opt/vc/src/hello_pi/hello_video/test.h264`
