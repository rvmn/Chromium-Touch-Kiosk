# FluiddScreen
Shows Fluid on a connected display (MIPI-DSI/HDMI/..) automatically on startup. The idea is basically like KlipperScreen, a (touch) screen that lets you control your printer directly, but then using a kiosk-mode chromium that opens fluidd. I added a nice virtual keyboard to fluidd (Javascript lib called Mottie, very nice)

# Installation
Do a ```sudo raspi-config``` and in interface options turn on SPI and I2C, go back and in system options turn on autologin of the pi user
Reboot
Install this script with 

```wget -O - https://raw.githubusercontent.com/rvmn/FluiddScreen/main/run.sh > /tmp/run.sh && sudo chmod +x /tmp/run.sh && /tmp/run.sh && sudo rm /tmp/run.sh```

# Maintenance
If you upgrade fluidd, rerun the script to reinstall Mottie keyboard into fluidd

