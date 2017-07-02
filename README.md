# Cross compiling QT width piomxtextures

Based on https://wiki.qt.io/RaspberryPi2EGLFS, https://thebugfreeblog.blogspot.com and https://github.com/raspberrypi/tools

## Notes
 - Uses the `arm-rpi-4.9.3-linux-gnueabihf` toolchain
 - Tested only on RPi 3 (but should support pi1/pi2 just fine)
 - Tested on clean `Ubuntu 16.04 (64 bit)` as host and clean `Raspbian Jessie Lite 2017-06-21` on device
 - Make sure to use 64 bit host OS as that's what the used toolchain is built for
 - To use the toolchain manually from console you must run `source env.sh` first to setup environment variables

## Guide
1. on host install tools and clone this repo
    ```sh
    # install tools
    sudo apt-get install build-essential sshpass git python pkg-config re2c gperf bison flex ninja python ruby gcc-multilib g++-multilib

    # clone this repo
    mkdir -p ~/raspi
    cd ~/raspi
    git clone https://github.com/Kukkimonsuta/rpi-buildqt.git .
    
    # add executable permissions (this may not be required)
    chmod +x scripts/0_init.sh
    cd scripts
    ./0_init.sh
    ```
2. update values in `env.sh` (`RPIDEV_DEVICE_*`, qt version and other settings)
3. prepare RPi (ideally use clean 'RASPBIAN JESSIE LITE' image)
    ```sh
    # change gpu memory to 256 MB and Expand File System for SD Card
    sudo raspi-config

    # install tools and dependencies
    sudo apt-get update
    sudo apt-get install rsync

    # qtbase
    sudo apt-get install libboost1.55-all-dev libudev-dev libinput-dev libts-dev libmtdev-dev libjpeg-dev libfontconfig1-dev libssl-dev libdbus-1-dev libglib2.0-dev
    
    # qtmultimedia
    sudo apt-get install libasound2-dev libpulse-dev gstreamer1.0-omx libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
    
    # piomxtextures
    sudo apt-get install libssh-dev libsmbclient-dev libv4l-dev

    # qtwebengine
    sudo apt-get install libvpx-dev libsrtp0-dev libsnappy-dev

    # create qt install dir (must be at the path `QT_DEVICE_DIR` defined in `env.sh`)
    sudo mkdir -p /usr/local/qt5.8

    # register the lib directory in ld
    echo /usr/local/qt5.8/lib | sudo tee /etc/ld.so.conf.d/qt5.8.conf
    ```
4. run `1_tools.sh` - downloads and prepares toolchain
5. run `2_sysroot.sh` - synchronizes libs and headers from device to build host
6. run `3.0_download_qtbase.sh` - downloads latest version of `qtbase` from git (destroys all local changes!)
7. run `3.1_build_qtbase.sh` - builds `qtbase` and installs it to configured directories
8. run `4.0_download_modules.sh` - downloads latest versions of all configured or explicitly specified (ex. `4.0_download_modules.sh qtmultimedia`) modules from git (destroys all local changes!)
9. run `4.1_build_modules.sh` - builds all configured or explicitly specified (ex. `4.1_build_modules.sh qtmultimedia`) modules and installs them to configured directories
10. run `5.0_download_piomxtextures.sh` - downloads latest version of `piomxtextures`
11. run `5.1_build_piomxtextures.sh` - builds `piomxtextures` and installs it to configured directories
12. run `6_copy_to_device.sh` - copies built QT to configured directory on device
13. on RPi run `sudo ldconfig`
14. on RPi run `~/piomxtextures_pocplayer /opt/vc/src/hello_pi/hello_video/test.h264`
