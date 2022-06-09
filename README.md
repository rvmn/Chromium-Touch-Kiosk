# FluiddScreen
Shows Fluid on a connected display (MIPI-DSI/HDMI/..) automatically on startup. The idea is basically like KlipperScreen, a (touch) screen that lets you control your printer directly, but then using a kiosk-mode chromium that opens fluidd. I added a nice virtual keyboard to fluidd (Javascript lib called Mottie, very nice)

# Installation
- Assumed is that you have your screen set up and working, I tested this on RPi OS desktop but it should work on any Debian/Ubuntu OS, as long as SPI is turned on and xserver is installed.
1. On RPi OS, do a ```sudo raspi-config``` and in interface options turn on SPI and I2C, go back and in system options turn on autologin of the pi user
2. Reboot
3. Install this script with 

```wget -O - https://raw.githubusercontent.com/rvmn/FluiddScreen/main/run.sh > /tmp/run.sh && sudo chmod +x /tmp/run.sh && /tmp/run.sh && sudo rm /tmp/run.sh```

# Maintenance
If you upgrade fluidd, rerun the script to reinstall Mottie keyboard into fluidd

