#!/bin/bash
sudo apt install chromium-browser unclutter matchbox-window-manager

firsttime_install(){
# install the runner
echo "if [ $(tty) == "/dev/tty1" ]; then\
while true; do startx -- -nocursor; echo "Again [$?]..."; done\
fi" >> ~/.bashrc

# install the service to autostart 
echo "[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin op --noclear %I 38400 linux" | sudo tee /etc/systemd/system/getty@tty1.service.d/autologin.conf
sudo systemctl enable getty@tty1.service

# install the xinitrc
echo "#Disable DPMS.
xset -dpms
xset s off
xset s noblank
#Lets remove a lock file that could be caused due to a crash.
rm /home/pi/.config/chromium/SingletonLock
while true; do
    # Clean up previously running apps, gracefully at first then harshl
    killall -TERM chromium-browser 2>/dev/null;
    killall -TERM matchbox-window-manager 2>/dev/null;
    sleep 2;
    killall -9 chromium-browser 2>/dev/null;
    killall -9 matchbox-window-manager 2>/dev/null;
    # Launch window manager without title bar.
    exec matchbox-window-manager -use_titlebar no -use_cursor no -theme bluebox &
    # Run unclutter to hide the mouse pointer
    unclutter &
    # Set brightness and timeout
    DISPLAY=:0 xset dpms 60 0 0
    echo 100 | sudo tee /sys/class/backlight/*/brightness
    # Launch browser.
    chromium-browser --incognito --kiosk --noerrdialogs --disable-translate --disable-cache --disk-cache-dir=/dev/null --disk-cache-size=1 --app=http://localhost/
done;" > ~/.xinitrc
}
if [ -f "~/.xinitrc"] || firsttime_install

# install the mottie keyboard
 cd /tmp 
 wget https://github.com/Mottie/Keyboard/archive/master.tar.gz
 tar -xzvf master.tar.gz
 rsync -r Key*/* ~/fluid/
 echo '<link href="docs/css/jquery-ui.min.css" rel="stylesheet"> <script src="docs/js/jquery-latest-slim.min.js"></script> <script src="docs/js/jquery-migrate-3.1.0.min.js"></script> <script src="docs/js/jquery-ui-custom.min.js"></script> <!-- keyboard widget css & script (required) --> <link href="css/keyboard.css" rel="stylesheet"> <script src="js/jquery.keyboard.js"></script> <!-- keyboard extensions (optional) --> <script src="js/jquery.mousewheel.js"></script> <script src="js/jquery.keyboard.extension-typing.js"></script> <script src="js/jquery.keyboard.extension-autocomplete.js"></script> <script src="js/jquery.keyboard.extension-caret.js"></script> <!-- demo only --> <link rel="stylesheet" href="docs/css/bootstrap.min.css"> <link rel="stylesheet" href="docs/css/font-awesome.min.css"> <link href="docs/css/demo.css" rel="stylesheet"> <link href="docs/css/tipsy.css" rel="stylesheet"> <link href="docs/css/prettify.css" rel="stylesheet"> <script src="docs/js/bootstrap.min.js"></script><script src="docs/js/jquery.tipsy.min.js"></script> <script src="docs/js/prettify.js"></script>
 <script>function loadKeyboard(){
        $.keyboard.keyaction.undo = function (base) {
                base.execCommand("undo");
                return false;
        };
        $.keyboard.keyaction.redo = function (base) {
                base.execCommand("redo");
                return false;
        };
        $("textarea").keyboard({
                usePreview: false,
                useCombos: false,
                autoAccept: true,
                layout: "custom",
                customLayout: {
                        "normal": [
                                "` 1 2 3 4 5 6 7 8 9 0 - = {del} {b}",
                                "{tab} q w e r t y u i o p [ ]",
                                "a s d f g h j k l ; \" {enter}",
                                "{shift} z x c v b n m , . / {shift}",
                                "{accept} {space} {left} {right} {undo:Undo} {redo:Redo}"
                        ],
                        "shift": [
                                "~ ! @ # $ % ^ & * ( ) _ + {del} {b}",
                                "{tab} Q W E R T Y U I O P { } |",
                                "A S D F G H J K L : \" {enter}",
                                "{shift} Z X C V B N M < > ? {shift}",
                                "{accept} {space} {left} {right} {undo:Undo} {redo:Redo}"
                        ]
                },
                display: {
                        del: "\u2326:Delete",
                        redo: "↻",
                        undo: "↺"
                }
        });
};</script>' >> ~/fluidd/index.html
