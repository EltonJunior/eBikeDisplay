<div >
<div  align="left" > <h1 >eBikeDisplay DEVELOPMENT</h1> </div>
<div align="right" > <img  width="20%" src="./images/CES_logo.png" alt="CES_logo"> </div>
</div>



## Introdution

In this project, it could be used a Raspberry pi 3 or 4 to create a simple Eletronic Bike dashboard.

For this project it will need a

- Raspberry pi B+ 3 or B 4
- Raspberry Display HDMI
- SD Card greathen then 16 GB class A10
- A Host Computer

Althouth in It description will content a step-by-step setup of Raspberry pi 4 it might be the same in any raspberry that has support to display. 

The display used in this project will a 5' inch, but the size will depend on the project that it will apply for.

This steps was tested only in the Raspberry pi 3 and 4, So if you are going to try in other version, some step shall be different for you.

## Raspberry Setup 

In order to setup the Raspberry pi, it will need to install the Raspibian (the official Linux distribution to Raspberry) on a sd-card, basiclly it will need to download the Software from [Raspberry webpage](https://www.raspberrypi.com/software/operating-systems/). 

This project are using the [Raspberry Pi OS 64-bits with desktop](https://downloads.raspberrypi.org/raspios_arm64/images/raspios_arm64-2023-02-22/2023-02-21-raspios-bullseye-arm64.img.xz).

To mount the sd-card there is a lot of information about HOW-TO I will put here a link from [Getting Started](https://www.raspberrypi.com/documentation/computers/getting-started.html) from official Raspberry Webpage.

If you are going to use Windows, In resume there is basiclly 2 ways, to create a SD-Card.
1- download the Install [Raspberry Pi OS using Raspberry Pi Imager](https://www.raspberrypi.com/software/). This installer is easy to use and it is possible to config the raspberry, but I got some error in it when I try to use a 128 GB sd-card.
2- use the [Rufus](https://apps.microsoft.com/store/detail/rufus/9PC3H3V7Q9CH?hl=en-us&gl=us), I put the link from microsoft Apps because it look like more trustly. Rufus is a utility that helps format and create bootable USB flash drives, such as USB keys/pendrives, memory sticks, etc.

So, I intend that we are ready to jump in the next step, because those step above has a lot of informtion in web, I assume that it is peace of cake, Lets talking a little bit about Raspberry configuration.

## Raspberry Configuration

In this section, I will talking as the same as it can be found in internet, but some point here will be specific from our project.

When we want to create a embedded system, Raspberry is bringing in a lot of searching up because it is more knowing embedded Linux development enviroment and it is very simple and fast to start using. 

this is one of the reazon that this project will be using. I said all this words because every step that I will take was found in the internet or book.

This project will focus on 3 fundamental changes thinking in a final product, first it will change the SPLASH image, it is the image show up in the boot up, second the time of boot up, Raspberry does a lot of staff in it boot process, this project will reduce the time taking out some step that was not necessary for our project, and Third A interface grafic, for this step it will use the QT Creator as HMI software generator.

There is 2 ways to access the raspberry, with keyboard and mouse or via SSH, this step-by-step will use the SSH, but the commands here is the same no matter way you are going to use.

To use SSH the Host and Raspberry may be the same network connection, the it is simple to use "ssh raspi_name@raspi_IP".

This project will use the Windows as a Host, and will use the SHELL terminal to communication to Raspberry. In the first connection, it will authenticity the host. below has the command and the result.

```console
PS D:\ELTON> ssh pi@192.168.1.254
The authenticity of host '192.168.1.254 (192.168.1.254)' can't be established.
ECDSA key fingerprint is SHA256:yooizLRJ/fZCk+JTDvU5RTI3gQ1P/EVjCOxwBmRtYF0.
Are you sure you want to continue connecting (yes/no/[fingerprint])? y
Please type 'yes', 'no' or the fingerprint: yes
Warning: Permanently added '192.168.1.254' (ECDSA) to the list of known hosts.
pi@192.168.1.254's password:
Linux raspberrypi 5.15.84-v8+ #1613 SMP PREEMPT Thu Jan 5 12:03:08 GMT 2023 aarch64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Mon Feb 20 23:20:35 2023
pi@raspberrypi:~ $
```

After the step above, we are access the Raspberry, one thing that I always got problem is releated to the Super User, so lets put our user as a Super user.

the command 'sudo' will give a super user access, the 'nano' will open a file as a text editor and the file that we need to change is 'sudoers' inside of 'etc' folder, below you have the command.


```console
pi@raspberrypi:~ $sudo nano /etc/sudoers
```
In the sudoers, search for '# User privilege specification' and included the line, as shows in the code below.
```console
#
# This file MUST be edited with the 'visudo' command as root.
#
# Please consider adding local content in /etc/sudoers.d/ instead of
# directly modifying this file.
#
# See the man page for details on how to write a sudoers file.
#
Defaults        env_reset
Defaults        mail_badpass
Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Host alias specification

# User alias specification

# Cmnd alias specification

# User privilege specification
root    ALL=(ALL:ALL) ALL
pi      ALL=(ALL) ALL       #This is the line that should be included

# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL

# See sudoers(5) for more information on "@include" directives:

@includedir /etc/sudoers.d

```

To finishing and save, press 'ctrl+x' and digit 'y'  and 'Enter' to save and exit. 

Now, lets update and upgrade the Raspberry.

```console
pi@raspberrypi:~ $sudo apt-get update && sudo apt-get -y upgrade
```

**Be carful if you have been use the Raspberry a while, the upgrade may install update in all Software listed, and it somethimes may boke some codes.**

Lets wait the Raspberry finishing the process and lets start our modification.

### Raspberry SPLASH Image

The Splash image is a rainbow that come up when the Raspberry start, to remove it, edit the file 'config.txt', as shows below. 

```console
pi@raspberrypi:~ $sudo nano /boot/config.txt
```

then include the line at the end of the file.
> hdmi_cvt 800 480 60 6 0 0 0 \
> disable_splash=1

To finishing and save, press 'ctrl+x' and digit 'y'  and 'Enter' to save and exit. 

In the boot process, after the rainbow it will show all boot process message, Lets remove it as well.

Lets include in the cmdline.txt the following line .

```console
pi@raspberrypi:~ $ sudo nano /boot/cmdline.txt
```

> quiet splash loglevel=3 logo.nologo vt.global_cursor_default=0 plymouth.ignore-serial-consoles

Here are brief explanations about with command.
‘splash’ : enables splash image
‘quiet’ : disable boot message texts
‘plymouth.ignore-serial-consoles’ : not sure about this but seems it’s required when use Plymouth.
‘logo.nologo’ : removes Raspberry Pi logo in top left corner.
‘vt.global_cursor_default=0’ : removes blinking cursor. 

the final result shall be:

> ... rootwait quiet splash loglevel=3 logo.nologo vt.global_cursor_default=0 plymouth.ignore-serial-consoles

**It is important replace “console=tty1” with “console=tty3”.**

Now, it is time to start configure our new image, open a new terminal and send some image to Raspberry using the commang below.

```console
PS E:\> scp splash_image.png pi@192.168.1.254:/home/pi
pi@192.168.1.254's password:
splash_image.png                      100%   41KB   1.9MB/s   00:00
PS E:\>
```

put the Raspberry password and press 'Enter'


```console
pi@raspberrypi:~ $cd /usr/share/plymouth/themes/pix/
pi@raspberrypi:~ $sudo mv splash.png splash.png.bk
pi@raspberrypi:~ $sudo cp /home/pi/splash.png ./
```
In the command above 'cd' goes to folder '/pix', inside the folder lets make a copy of the origenal splash image and after that let move our image from '/pi' folder to '/pix' folder. To confirm the result final type 'ls' as shown below.

```console
pi@raspberrypi:/usr/share/plymouth/themes/pix $ ls
pix.plymouth  pix.script  splash.png  splash.png.bk
pi@raspberrypi:/usr/share/plymouth/themes/pix $
```

to test our first configuration, lets reboot the Raspberry and confirm the new splash image show up.

```console
pi@raspberrypi: $ sudo reboot
```

### Raspberry Reduce Boot time

 the Raspberry in its start up initialize a lot drives, you are able to remove some of then that was not import from your project, the command 'systemd-analyze' shows the time of starup from Raspberry.
 
```console
pi@raspberrypi: $ systemd-analyze
Startup finished in 1.943s (kernel) + 12.599s (userspace) = 14.542s
graphical.target reached after 6.712s in userspace
```
 
Its could be more specific in this list with the command 'systemd-analyze blame'

```console
pi@raspberrypi: $ systemd-analyze blame
Startup finished in 1.943s (kernel) + 12.599s (userspace) = 14.542s
graphical.target reached after 6.712s in userspace
example of answer: 
9.297s raspapd.service
1.547s dev-mmcblk0p2.device
1.412s raspi-config.service
1.065s lighttpd.service
1.007s rpi-eeprom-update.service
163ms systemd-udevd.service
142ms hostapd.service
129ms triggerhappy.service
126ms systemd-tmpfiles-setup.service
124ms fake-hwclock.service
86ms systemd-journal-flush.service
etc. [...]
```

so, to remove this application in the start up, use the command 'sudo systemctl disable name_application.service'
I put below some feature that had not big impact in the start up.

```console
sudo systemctl disable raspi-config.service
sudo systemctl disable keyboard-setup.service
sudo systemctl disable dphys-swapfile.service
sudo systemctl disable avahi-daemon.service
sudo systemctl disable sys-kernel-debug.mount
sudo systemctl disable raspi-config.service
sudo systemctl disable systemd-udev-trigger.service
sudo systemctl disable rpi-eeprom-update.service
sudo systemctl disable rsyslog.service
sudo systemctl disable systemd-journald.service
sudo systemctl disable systemd-fsck-root.service
sudo systemctl disable systemd-logind.service
sudo systemctl disable bluetooth.service
sudo systemctl disable hciuart.service
```

After remove the unecessario application, the result of our startup is

```console
pi@raspberrypi:~ $ systemd-analyze
Startup finished in 1.946s (kernel) + 6.388s (userspace) = 8.334s
graphical.target reached after 5.966s in userspace
```

Its look good, but can be even betten, but it will leave in this way.

Continue our Raspberry configuration, Lets install QT Creator.


### Raspberry QT Install

To install the Qt creator just tyoe de command below

```console
pi@raspberrypi: $ sudo apt-get install -y build-essential cmake unzip pkg-config gfortran qt5-default qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools qtcreator qtdeclarative5-dev
pi@raspberrypi: $ sudo apt-get install -y qml-module-qtquick2 qml-module-qtquick-controls2 qml-module-qtquick-layouts qml-module-qtquick-templates2 qml-module-qtquick-window2 qml-module-qtgraphicaleffects
```


that will install all depence that we are going to use to run our application.

after install, its time to test before send the final code.

### Raspberry Test the QT Install

Lets create a simple qt program that will show a windows with our famouse Hello World.

#### Create a QT program 

make sure that you are in the root

```console
pi@raspberrypi: $ cd
```

Lets create 2 file 'myQTApp.pro' and 'myQTApp.cpp' inside of the 'Project/myQTApp', First thing first, lets create a folder

```console
pi@raspberrypi: $ mkdir Project && cd Project && mkdir myQTApp && cd myQTApp
```

Now create a .pro file

```console
pi@raspberrypi: $ sudo nano myQTApp.pro
```
put the code in the file

```pro
TEMPLATE = app
TARGET = myQTApp
INCLUDEPATH += .

QT += gui widgets

DEFINES += QT_DEPRECATED_WARNING

SOURCES += myQTApp.cpp
```

To finishing and save, press 'ctrl+x' and digit 'y'  and 'Enter' to save and exit. 

Now create a .pro file

```console
pi@raspberrypi: $ sudo nano myQTApp.cpp
```
put the code in the file

```cpp
#include <QApplication>
#include <QLabel>
#include <QWidget>


int main(int argc, char *argv[]){

    QApplication app(argc, argv);
    QLabel hello("<center>HELLO WORLD!</center>");
    hello.setWindowTitle("My first QT");
    hello.resize(200,200);
    hello.show();

    return app.exec();
}
```

to finishing and run the application, first we need to create the .exe file, below the command of 'qmake' and 'make'


```console
pi@raspberrypi: $ qmake
Info: creating stash file /home/pi/Project/myQTApp/.qmake.stash
pi@raspberrypi: $ make
g++ -c -pipe -O2 -Wall -Wextra -D_REENTRANT -fPIC -DQT_DEPRECATED_WARNING -DQT_NO_DEBUG -DQT_WIDGETS_LIB -DQT_GUI_LIB -DQT_CORE_LIB -I. -I. -I/usr/include/aarch64-linux-gnu/qt5 -I/usr/include/aarch64-linux-gnu/qt5/QtWidgets -I/usr/include/aarch64-linux-gnu/qt5/QtGui -I/usr/include/aarch64-linux-gnu/qt5/QtCore -I. -I/usr/lib/aarch64-linux-gnu/qt5/mkspecs/linux-g++ -o myQTApp.o myQTApp.cpp
g++ -Wl,-O1 -o myQTApp myQTApp.o   /usr/lib/aarch64-linux-gnu/libQt5Widgets.so /usr/lib/aarch64-linux-gnu/libQt5Gui.so /usr/lib/aarch64-linux-gnu/libQt5Core.so -lGL -lpthread
pi@raspberrypi: $ ./myQTApp
-bash: /.myQTApp: No such file or directory
```

it is spected that Raspberry return a error when you try to run the '/.myQTApp', So, if its happen just type the command below and try agrain.

```console
pi@raspberrypi: $ export DISPLAY=:0.0
pi@raspberrypi: $ ./myQTApp
```

it will be expected to show the windows, to exit press ctrl+c.

#### Create a QT auto start 

Now, our 'hello world' program has been function, lets implement a auto start-up.

```console
pi@raspberrypi: $ sudo nano /etc/xdg/autostart/myQTApp.desktop
```
To finishing and save, press 'ctrl+x' and digit 'y'  and 'Enter' to save and exit. 
And lets put the lines below in the windows that openned

```desktop
[Desktop Entry]
Type=Application
Exec=/home/debian/Project/eBikeDisplay/./eBikeDisplay
Name=eBikeDisplay
Comment=Startup eBikeDisplay on load
``` 
 
to test, only we need to do is 'reboot' the Raspberry. 
 
```console
pi@raspberrypi: $ sudo reboot
```
 
Look at Raspberry, you shall see our splash image and after that our application will open, Great job!!!
 

To stop the script, ssh into the BBB and
 
```console
$ pkill -f ./eBikeDisplay
```

## Enable GPIO using WiringPi

Our project will turn on/off a LED and we are need to install WiringPi libery, lets clone the git and install it.

```console
pi@raspberrypi:~ $ cd
pi@raspberrypi:~ $ git clone https://github.com/WiringPi/WiringPi.git
pi@raspberrypi:~ $ cd WiringPi
pi@raspberrypi:~/WiringPi $ ./build
wiringPi Build script
=====================


WiringPi Library
[UnInstall]
[Compile] wiringPi.c
[Compile] wiringSerial.c
[Compile] wiringShift.c
[Compile] piHiPri.c
[Compile] piThread.c
[Compile] wiringPiSPI.c
[Compile] wiringPiI2C.c
[Compile] softPwm.c
[Compile] softTone.c
[Compile] mcp23008.c
[Compile] mcp23016.c
[Compile] mcp23017.c
[Compile] mcp23s08.c
[Compile] mcp23s17.c
[Compile] sr595.c
[Compile] pcf8574.c
[Compile] pcf8591.c
[Compile] mcp3002.c
[Compile] mcp3004.c
[Compile] mcp4802.c
[Compile] mcp3422.c
[Compile] max31855.c
[Compile] max5322.c
[Compile] ads1115.c
[Compile] sn3218.c
[Compile] bmp180.c
[Compile] htu21d.c
[Compile] ds18b20.c
[Compile] rht03.c
[Compile] drcSerial.c
[Compile] drcNet.c
[Compile] pseudoPins.c
[Compile] wpiExtensions.c
[Link (Dynamic)]
[Install Headers]
[Install Dynamic Lib]

WiringPi Devices Library
[UnInstall]
[Compile] ds1302.c
[Compile] maxdetect.c
[Compile] piNes.c
[Compile] gertboard.c
[Compile] piFace.c
[Compile] lcd128x64.c
[Compile] lcd.c
[Compile] scrollPhat.c
[Compile] piGlow.c
[Link (Dynamic)]
[Install Headers]
[Install Dynamic Lib]

GPIO Utility
[Compile] gpio.c
[Compile] readall.c
[Link]
[Install]

All Done.

NOTE: To compile programs with wiringPi, you need to add:
    -lwiringPi
  to your compile line(s) To use the Gertboard, MaxDetect, etc.
  code (the devLib), you need to also add:
    -lwiringPiDev
  to your compile line(s).

pi@raspberrypi:~/WiringPi $

```

after finishing of our installation, lets test if all was installed corrected.

```console

pi@raspberrypi:~/WiringPi $ gpio readall
eltonjunior@raspberrypi:~/WiringPi $ gpio readall
 +-----+-----+---------+------+---+---Pi 4B+-+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 |     |     |    3.3v |      |   |  1 || 2  |   |      | 5v      |     |     |
 |   2 |   8 |   SDA.1 | ALT0 | 1 |  3 || 4  |   |      | 5v      |     |     |
 |   3 |   9 |   SCL.1 | ALT0 | 1 |  5 || 6  |   |      | 0v      |     |     |
 |   4 |   7 | GPIO. 7 |   IN | 1 |  7 || 8  | 1 | ALT5 | TxD     | 15  | 14  |
 |     |     |      0v |      |   |  9 || 10 | 1 | ALT5 | RxD     | 16  | 15  |
 |  17 |   0 | GPIO. 0 |   IN | 0 | 11 || 12 | 0 | IN   | GPIO. 1 | 1   | 18  |
 |  27 |   2 | GPIO. 2 |   IN | 0 | 13 || 14 |   |      | 0v      |     |     |
 |  22 |   3 | GPIO. 3 |   IN | 0 | 15 || 16 | 0 | IN   | GPIO. 4 | 4   | 23  |
 |     |     |    3.3v |      |   | 17 || 18 | 0 | IN   | GPIO. 5 | 5   | 24  |
 |  10 |  12 |    MOSI | ALT0 | 0 | 19 || 20 |   |      | 0v      |     |     |
 |   9 |  13 |    MISO | ALT0 | 0 | 21 || 22 | 1 | IN   | GPIO. 6 | 6   | 25  |
 |  11 |  14 |    SCLK | ALT0 | 0 | 23 || 24 | 1 | OUT  | CE0     | 10  | 8   |
 |     |     |      0v |      |   | 25 || 26 | 1 | OUT  | CE1     | 11  | 7   |
 |   0 |  30 |   SDA.0 |   IN | 1 | 27 || 28 | 1 | IN   | SCL.0   | 31  | 1   |
 |   5 |  21 | GPIO.21 |   IN | 1 | 29 || 30 |   |      | 0v      |     |     |
 |   6 |  22 | GPIO.22 |   IN | 1 | 31 || 32 | 0 | IN   | GPIO.26 | 26  | 12  |
 |  13 |  23 | GPIO.23 |   IN | 0 | 33 || 34 |   |      | 0v      |     |     |
 |  19 |  24 | GPIO.24 |   IN | 0 | 35 || 36 | 0 | IN   | GPIO.27 | 27  | 16  |
 |  26 |  25 | GPIO.25 |   IN | 0 | 37 || 38 | 0 | IN   | GPIO.28 | 28  | 20  |
 |     |     |      0v |      |   | 39 || 40 | 0 | IN   | GPIO.29 | 29  | 21  |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+---Pi 4B+-+---+------+---------+-----+-----+
eltonjunior@raspberrypi:~/WiringPi $

```

If the return was the same as show above, all was installed correct. Let's include our final project.


## Compile the Final Code at Raspberry

Our project is ready to using in the Github, it will need only to clone the diretory, create a qmake, compile using make and included our application in the auto start, so lets do it so.


```console
pi@raspberrypi:~ $ cd
pi@raspberrypi:~ $ git clone  https://github.com/EltonJunior/eBikeDisplay.git
Cloning into 'eBikeDisplay'...
remote: Enumerating objects: 61, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (5/5), done.
Receiving objects:  78% (48/61), 333.98 MiB | 786.00 KiB/sremote: Total 61 (delta 1), reused 3 (delta 0), pack-reused 56Receiving objects:  80% (49/61), 333.98 MiB | 786.00 KiB/s
Receiving objects: 100% (61/61), 334.07 MiB | 766.00 KiB/s, done.
Resolving deltas: 100% (3/3), done.
Updating files: 100% (53/53), done.
```
after clone the project lets compile it and generate our final project.

```console
pi@raspberrypi:~ $ cd eBikeDisplay/eBikeDisplay
pi@raspberrypi:~/eBikeDisplay/eBikeDisplay $ qmake
Info: creating stash file /home/pi/eBikeDisplay/eBikeDisplay/.qmake.stash
pi@raspberrypi:~/eBikeDisplay/eBikeDisplay $ make
g++ -c -pipe -O2 -std=gnu++11 -Wall -Wextra -D_REENTRANT -fPIC -DQT_NO_DEBUG -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QMLMODELS_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB -I. -I/usr/local/include -I/usr/include/aarch64-linux-gnu/qt5 -I/usr/include/aarch64-linux-gnu/qt5/QtQuick -I/usr/include/aarch64-linux-gnu/qt5/QtGui -I/usr/include/aarch64-linux-gnu/qt5/QtQmlModels -I/usr/include/aarch64-linux-gnu/qt5/QtQml -I/usr/include/aarch64-linux-gnu/qt5/QtNetwork -I/usr/include/aarch64-linux-gnu/qt5/QtCore -I. -I/usr/lib/aarch64-linux-gnu/qt5/mkspecs/linux-g++ -o animationtomap.o animationtomap.cpp
g++ -c -pipe -O2 -std=gnu++11 -Wall -Wextra -D_REENTRANT -fPIC -DQT_NO_DEBUG -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QMLMODELS_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB -I. -I/usr/local/include -I/usr/include/aarch64-linux-gnu/qt5 -I/usr/include/aarch64-linux-gnu/qt5/QtQuick -I/usr/include/aarch64-linux-gnu/qt5/QtGui -I/usr/include/aarch64-linux-gnu/qt5/QtQmlModels -I/usr/include/aarch64-linux-gnu/qt5/QtQml -I/usr/include/aarch64-linux-gnu/qt5/QtNetwork -I/usr/include/aarch64-linux-gnu/qt5/QtCore -I. -I/usr/lib/aarch64-linux-gnu/qt5/mkspecs/linux-g++ -o animationtonumbers.o animationtonumbers.cpp
g++ -c -pipe -O2 -std=gnu++11 -Wall -Wextra -D_REENTRANT -fPIC -DQT_NO_DEBUG -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QMLMODELS_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB -I. -I/usr/local/include -I/usr/include/aarch64-linux-gnu/qt5 -I/usr/include/aarch64-linux-gnu/qt5/QtQuick -I/usr/include/aarch64-linux-gnu/qt5/QtGui -I/usr/include/aarch64-linux-gnu/qt5/QtQmlModels -I/usr/include/aarch64-linux-gnu/qt5/QtQml -I/usr/include/aarch64-linux-gnu/qt5/QtNetwork -I/usr/include/aarch64-linux-gnu/qt5/QtCore -I. -I/usr/lib/aarch64-linux-gnu/qt5/mkspecs/linux-g++ -o gpio.o gpio.cpp
g++ -c -pipe -O2 -std=gnu++11 -Wall -Wextra -D_REENTRANT -fPIC -DQT_NO_DEBUG -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QMLMODELS_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB -I. -I/usr/local/include -I/usr/include/aarch64-linux-gnu/qt5 -I/usr/include/aarch64-linux-gnu/qt5/QtQuick -I/usr/include/aarch64-linux-gnu/qt5/QtGui -I/usr/include/aarch64-linux-gnu/qt5/QtQmlModels -I/usr/include/aarch64-linux-gnu/qt5/QtQml -I/usr/include/aarch64-linux-gnu/qt5/QtNetwork -I/usr/include/aarch64-linux-gnu/qt5/QtCore -I. -I/usr/lib/aarch64-linux-gnu/qt5/mkspecs/linux-g++ -o main.o main.cpp
/usr/lib/qt5/bin/rcc -name qml qml.qrc -o qrc_qml.cpp
g++ -c -pipe -O2 -std=gnu++11 -Wall -Wextra -D_REENTRANT -fPIC -DQT_NO_DEBUG -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QMLMODELS_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB -I. -I/usr/local/include -I/usr/include/aarch64-linux-gnu/qt5 -I/usr/include/aarch64-linux-gnu/qt5/QtQuick -I/usr/include/aarch64-linux-gnu/qt5/QtGui -I/usr/include/aarch64-linux-gnu/qt5/QtQmlModels -I/usr/include/aarch64-linux-gnu/qt5/QtQml -I/usr/include/aarch64-linux-gnu/qt5/QtNetwork -I/usr/include/aarch64-linux-gnu/qt5/QtCore -I. -I/usr/lib/aarch64-linux-gnu/qt5/mkspecs/linux-g++ -o qrc_qml.o qrc_qml.cpp
g++ -pipe -O2 -std=gnu++11 -Wall -Wextra -dM -E -o moc_predefs.h /usr/lib/aarch64-linux-gnu/qt5/mkspecs/features/data/dummy.cpp
/usr/lib/qt5/bin/moc -DQT_NO_DEBUG -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QMLMODELS_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB --include /home/conti/eBikeDisplay/eBikeDisplay/moc_predefs.h -I/usr/lib/aarch64-linux-gnu/qt5/mkspecs/linux-g++ -I/home/conti/eBikeDisplay/eBikeDisplay -I/usr/local/include -I/usr/include/aarch64-linux-gnu/qt5 -I/usr/include/aarch64-linux-gnu/qt5/QtQuick -I/usr/include/aarch64-linux-gnu/qt5/QtGui -I/usr/include/aarch64-linux-gnu/qt5/QtQmlModels -I/usr/include/aarch64-linux-gnu/qt5/QtQml -I/usr/include/aarch64-linux-gnu/qt5/QtNetwork -I/usr/include/aarch64-linux-gnu/qt5/QtCore -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include/c++ -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include/c++/x86_64-w64-mingw32 -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include/c++/backward -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include-fixed -IC:/Qt/Qt5.12.12/Tools/mingw730_64/x86_64-w64-mingw32/include animationtomap.h -o moc_animationtomap.cpp
g++ -c -pipe -O2 -std=gnu++11 -Wall -Wextra -D_REENTRANT -fPIC -DQT_NO_DEBUG -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QMLMODELS_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB -I. -I/usr/local/include -I/usr/include/aarch64-linux-gnu/qt5 -I/usr/include/aarch64-linux-gnu/qt5/QtQuick -I/usr/include/aarch64-linux-gnu/qt5/QtGui -I/usr/include/aarch64-linux-gnu/qt5/QtQmlModels -I/usr/include/aarch64-linux-gnu/qt5/QtQml -I/usr/include/aarch64-linux-gnu/qt5/QtNetwork -I/usr/include/aarch64-linux-gnu/qt5/QtCore -I. -I/usr/lib/aarch64-linux-gnu/qt5/mkspecs/linux-g++ -o moc_animationtomap.o moc_animationtomap.cpp
/usr/lib/qt5/bin/moc -DQT_NO_DEBUG -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QMLMODELS_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB --include /home/conti/eBikeDisplay/eBikeDisplay/moc_predefs.h -I/usr/lib/aarch64-linux-gnu/qt5/mkspecs/linux-g++ -I/home/conti/eBikeDisplay/eBikeDisplay -I/usr/local/include -I/usr/include/aarch64-linux-gnu/qt5 -I/usr/include/aarch64-linux-gnu/qt5/QtQuick -I/usr/include/aarch64-linux-gnu/qt5/QtGui -I/usr/include/aarch64-linux-gnu/qt5/QtQmlModels -I/usr/include/aarch64-linux-gnu/qt5/QtQml -I/usr/include/aarch64-linux-gnu/qt5/QtNetwork -I/usr/include/aarch64-linux-gnu/qt5/QtCore -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include/c++ -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include/c++/x86_64-w64-mingw32 -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include/c++/backward -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include-fixed -IC:/Qt/Qt5.12.12/Tools/mingw730_64/x86_64-w64-mingw32/include animationtonumbers.h -o moc_animationtonumbers.cpp
g++ -c -pipe -O2 -std=gnu++11 -Wall -Wextra -D_REENTRANT -fPIC -DQT_NO_DEBUG -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QMLMODELS_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB -I. -I/usr/local/include -I/usr/include/aarch64-linux-gnu/qt5 -I/usr/include/aarch64-linux-gnu/qt5/QtQuick -I/usr/include/aarch64-linux-gnu/qt5/QtGui -I/usr/include/aarch64-linux-gnu/qt5/QtQmlModels -I/usr/include/aarch64-linux-gnu/qt5/QtQml -I/usr/include/aarch64-linux-gnu/qt5/QtNetwork -I/usr/include/aarch64-linux-gnu/qt5/QtCore -I. -I/usr/lib/aarch64-linux-gnu/qt5/mkspecs/linux-g++ -o moc_animationtonumbers.o moc_animationtonumbers.cpp
/usr/lib/qt5/bin/moc -DQT_NO_DEBUG -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QMLMODELS_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB --include /home/conti/eBikeDisplay/eBikeDisplay/moc_predefs.h -I/usr/lib/aarch64-linux-gnu/qt5/mkspecs/linux-g++ -I/home/conti/eBikeDisplay/eBikeDisplay -I/usr/local/include -I/usr/include/aarch64-linux-gnu/qt5 -I/usr/include/aarch64-linux-gnu/qt5/QtQuick -I/usr/include/aarch64-linux-gnu/qt5/QtGui -I/usr/include/aarch64-linux-gnu/qt5/QtQmlModels -I/usr/include/aarch64-linux-gnu/qt5/QtQml -I/usr/include/aarch64-linux-gnu/qt5/QtNetwork -I/usr/include/aarch64-linux-gnu/qt5/QtCore -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include/c++ -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include/c++/x86_64-w64-mingw32 -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include/c++/backward -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include -IC:/Qt/Qt5.12.12/Tools/mingw730_64/lib/gcc/x86_64-w64-mingw32/7.3.0/include-fixed -IC:/Qt/Qt5.12.12/Tools/mingw730_64/x86_64-w64-mingw32/include gpio.h -o moc_gpio.cpp
g++ -c -pipe -O2 -std=gnu++11 -Wall -Wextra -D_REENTRANT -fPIC -DQT_NO_DEBUG -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QMLMODELS_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB -I. -I/usr/local/include -I/usr/include/aarch64-linux-gnu/qt5 -I/usr/include/aarch64-linux-gnu/qt5/QtQuick -I/usr/include/aarch64-linux-gnu/qt5/QtGui -I/usr/include/aarch64-linux-gnu/qt5/QtQmlModels -I/usr/include/aarch64-linux-gnu/qt5/QtQml -I/usr/include/aarch64-linux-gnu/qt5/QtNetwork -I/usr/include/aarch64-linux-gnu/qt5/QtCore -I. -I/usr/lib/aarch64-linux-gnu/qt5/mkspecs/linux-g++ -o moc_gpio.o moc_gpio.cpp
g++ -Wl,-O1 -o eBikeDisplay animationtomap.o animationtonumbers.o gpio.o main.o qrc_qml.o moc_animationtomap.o moc_animationtonumbers.o moc_gpio.o   -L/usr/local/lib -lwiringPi /usr/lib/aarch64-linux-gnu/libQt5Quick.so /usr/lib/aarch64-linux-gnu/libQt5Gui.so /usr/lib/aarch64-linux-gnu/libQt5QmlModels.so /usr/lib/aarch64-linux-gnu/libQt5Qml.so /usr/lib/aarch64-linux-gnu/libQt5Network.so /usr/lib/aarch64-linux-gnu/libQt5Core.so -lGL -lpthread
pi@raspberrypi:~/eBikeDisplay/eBikeDisplay $
```

Lets test our application, before put it in the start up

```console
pi@raspberrypi:~/eBikeDisplay/eBikeDisplay $ export DISPLAY=:0.0
pi@raspberrypi:~/Project/QtCreator/eBikeDisplay $ ./eBikeDisplay
```

If everything was ok, lets put our application in the Raspberry startup
press ctrl+c and press enter.

```console
pi@raspberrypi: $ sudo nano /etc/xdg/autostart/myQTApp.desktop
```
in the new window, lets change the local of file 

FROM

>[Desktop Entry] \
>Type=Application \
>Exec=/home/conti/Project/QtCreator/eBikeDisplay/./eBikeDisplay \
>Name=eBikeDisplay \
>Comment=Startup eBikeDisplay on load \

TO

>[Desktop Entry] \
>Type=Application \
>Exec=/home/conti/eBikeDisplay/eBikeDisplay/./eBikeDisplay \
>Name=eBikeDisplay \
>Comment=Startup eBikeDisplay on load \

To finishing and save, press 'ctrl+x' and digit 'y'  and 'Enter' to save and exit. 
ok, Now lets test our application type

```console
pi@raspberrypi:~/Project/QtCreator/eBikeDisplay $ sudo reboot
```

Well done, The application was started!!!

<img src="./eBikeDisplay/images/presentation.gif" alt="CES_logo" />

## Reference

[1] https://www.tomshardware.com/how-to/custom-raspberry-pi-splash-screen \
[2] https://www.youtube.com/watch?v=m3rfls00OtY \
[3] https://www.youtube.com/watch?v=kdugp7DrODY \
[4]https://panther.software/configuration-code/raspberry-pi-3-4-faster-boot-time-in-few-easy-steps/#:~:text=If%20you%20are%20struggling%20with%20slow%20boot%20time,installation%20%2Fboot%2Fconfig.txt%20%23%20Disable%20bluetooth%20RPi%204%20 \
[5]https://www.interelectronix.com/raspberry-pi-4-autostart-qt-application-during-boot.html \
[6]https://www.hackster.io/kamaluddinkhan/changing-the-splash-screen-on-your-raspberry-pi-7aee31 \
[7]https://raspberrypi.stackexchange.com/questions/48084/custom-splash-screen-video \
[8]https://forums.raspberrypi.com/viewtopic.php?t=283323 \
[9]https://raspberry-projects.com/pi/pi-operating-systems/raspbian/custom-boot-up-screen \
[10]https://www.thedigitalpictureframe.com/customize-your-raspberry-pi-splash-screen-raspbian-stretch-april-2019-version/ \
[11]https://github.com/WiringPi/WiringPi \
[12]https://github.com/Shourov1/C-plus-plus-and-Qt5-Programming-for-Raspberry-Pi/blob/master/README.md \

