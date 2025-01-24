import QtQuick 2.0
import ButtonBehaviorClass 1.0

import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Item {
    id: principal
    width: 800
    height: 480
    x: 0
    y: 0

    ButtonBehavior{
     id: buttonBehavior
    }

    Item{
        id: mainScreenMoving
        width: 800 * 3
        height: 480
        x: 0
        y: 0

        MainBackground {
            id: mainBackground
            visible: true
            x: 0
            y: 0
        }

        MapScreen{
            id: mapScreen
            x:800
            y:0
        }

        TripScreen{
            id: tripScreen
            x:-800
            y:0

        }

        PropertyAnimation{
            id: animationLeft
            target: mainScreenMoving
            property: "x"
            to: -800
            duration: 500
        }
        PropertyAnimation{
            id: animationCenter
            target: mainScreenMoving
            property: "x"
            to: 0
            duration: 500
        }
        PropertyAnimation{
            id: animationRight
            target: mainScreenMoving
            property: "x"
            to: 800
            duration: 500
        }

    }

    BottonBackground {
        id: bottonBackground
    }

    Item{
        x: 652
        y: 361
        width: 140
        height: 90

        id: bikeImage
        visible: false
        BikeImage {
            anchors.fill: parent
        }

        MouseArea {
            id: mousebikeArea
            anchors.fill: parent
            onClicked: {
                buttonBehavior.setButtonObject(imgBottonNavigation,true);
                buttonBehavior.setButtonObject(bikeImage,false);
                buttonBehavior.setScreenMoveObject(animationCenter,1);
            }
        }


    }

    Item{
        x: 652
        y: 361
        width: 140
        height: 90

        id: imgBottonNavigation

        Image {
            anchors.fill: parent
            property bool isNavActive: false
            source: "../images/nav_nodir.png"
            fillMode: Image.PreserveAspectFit

        }

        MouseArea {
            id: mouseNavArea
            anchors.fill: parent
            onClicked: {
                buttonBehavior.setButtonObject(imgBottonNavigation,false);
                buttonBehavior.setButtonObject(bikeImage,true);
                buttonBehavior.setScreenMoveObject(animationLeft,1);
            }
        }


    }

    Item{
        x: 652
        y: 361
        width: 140
        height: 90
        visible: false
        id: imgBottonNavigationMain

        BikeImage {
            anchors.fill: parent
        }

        MouseArea {
            id: mouseNavAreaMain
            anchors.fill: parent
            onClicked: {
                buttonBehavior.setButtonObject(imgBottonNavigation,true);
                buttonBehavior.setButtonObject(imgBottonNavigationMain,false);
                buttonBehavior.setButtonObject(bikeImage,false);
                buttonBehavior.setScreenMoveObject(animationCenter,1);
            }
        }


    }

    Item {
        id: sleepModeArea
        anchors.fill: parent

        AnimatedImage {
            id: animatedImage
            anchors.fill: parent
            source: "qrc:/images/apresentacao_hmi.gif"
            playing: false
        }

        SleepClockMode{
            id: sleepClockMode
        }

        MouseArea {
            id: mousesleepModeArea
            anchors.fill: parent
            onClicked: {
                buttonBehavior.setButtonObject(sleepClockMode,false);
                animatedImage.playing = true;
            }
        }

        property int timerToSleep: 0
        property int timerToWakeUp: 0
        property bool sleepModeFlag: false

        function timeChanged() {
           // console.log("frame: " + animatedImage.currentFrame + " timerToSleep: " + timerToSleep  + " timerToWakeUp: " + timerToWakeUp )

            if(animatedImage.currentFrame >= 129){
                buttonBehavior.setButtonObject(sleepModeArea,false);
                animatedImage.playing = false;
                sleepModeFlag = true;
                buttonBehavior.setButtonObject(sleepClockMode,true);
                animatedImage.currentFrame = 0;
                timerToWakeUp = 0;
            }

            if( sleepModeFlag == true ){
                if(timerToSleep++ >= 1200){  /* which 1200 counter is igual 1 min */
                    buttonBehavior.setButtonObject(sleepModeArea,true);
                    sleepModeFlag = false;
                    timerToSleep = 0;

                }
            }
            else{

                if(timerToWakeUp++ >= 1200){
                    timerToWakeUp = 0;

                    buttonBehavior.setButtonObject(sleepClockMode,false);
                    animatedImage.playing = true;
                }

            }
        }

        Timer {
            interval: 50; running: true; repeat: true;
            onTriggered: sleepModeArea.timeChanged()
        }
    }

    // This Mouse area will call a new window where it will configurate the times animation
//    MouseArea {
//        id: mouseConfigurationArea
//        anchors.fill: parent
//        onClicked: {

//        }
//    }
}
