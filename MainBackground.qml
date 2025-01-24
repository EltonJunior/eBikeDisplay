import QtQuick 2.0
import AnimationToNumbersClass 1.0

Item {
    width: 800
    height: 480

    AnimationToNumbers{
        id: animationToNumbers
    }

    Image {
        id: imgMainScreenBackground
        x: 0
        y: 0
        width: 800
        height: 480

        source: "qrc:/images/background.png"
        fillMode: Image.PreserveAspectFit
    }

    Item {
        id: imgMainScreenSpeedBatteryBackground
        x: 80
        y: 20
        width: 640
        height: 390
        visible: true

        Image {
            id: leftBackground
            x: 32
            y: 24

            source: "qrc:/images/left-arc-main.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: arrowLeft
            x: 81
            y: 74

            source: "qrc:/images/arrow-left-main.png"
            rotation: animationToNumbers.OdoAnalogIncreaseVar
            fillMode: Image.PreserveAspectFit

        }

        Image {
            id: rightBackgroundRed
            x: 255
            y: 25

            source: animationToNumbers.AlertLowBatteryVar
            fillMode: Image.PreserveAspectFit
        }


        Image {
            id: arrowRight
            x: 292
            y: 56
            // -5 to 265
            source: "qrc:/images/arrow-right-main.png"
            rotation: animationToNumbers.OdoAnalogIncreaseVar - 90
            fillMode: Image.PreserveAspectFit

        }
    }

    BikeImage {
        id: bikeImageMain
    }

    Item {
        id: batteryPercetagem
        width: 149
        height: 74
        x: 444
        y: 298

        Text {
            id: batteryPercetagemNumber
            anchors.left: batteryPercetagem.left
            width: 115
            height: 82
            color: "#FFFFFF"
            text: animationToNumbers.BatteryIncreaseVar
            horizontalAlignment: Text.AlignRight
            font.pixelSize: 62
            font.family: "Cherry"

        }

        Text {
            id: simbolpercetagem

            anchors.right: batteryPercetagem.right
            anchors.bottom: batteryPercetagem.bottom
            width: 44
            height: 40
            color: "#FFFFFF"
            text: "%"
            horizontalAlignment: Text.AlignRight
            font.pixelSize: 32
            font.family: "Cherry"
        }
    }

    Item {
        id: speedValue
        width: 149
        height: 74
        x: 208
        y: 298

        Text {
            id: simbolSpeed

            anchors.right: speedValue.right
            anchors.bottom: speedValue.bottom
            width: 44
            height: 40
            color: "#FFFFFF"
            text: "mi"
            horizontalAlignment: Text.AlignRight
            font.pixelSize: 32
            font.family: "Cherry"
        }

        Text {
            id: speedNumber
            anchors.left: speedValue.left
            width: 115
            height: 82
            color: "#FFFFFF"
            text: animationToNumbers.SpeedIncreaseVar
            horizontalAlignment: Text.AlignRight
            font.pixelSize: 62
            font.family: "Cherry"

        }
    }

    Image {
        id: imgBatteryIcon
        x: 500
        width: 100
        height: 100
        anchors.right: parent.right
        anchors.top: parent.top
        source: "../images/battery.png"
        rotation: 270
        anchors.topMargin: 60
        anchors.rightMargin: 200
    }


    Image {
        id: imgSpeedIcon
        width: 100
        height: 100
        anchors.left: parent.left
        anchors.top: parent.top
        source: "../images/speed.png"
        anchors.leftMargin: 200
        anchors.topMargin: 60
    }

    Item {
        id: itemCalories
        width: 160
        height: 80
        visible: true
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 20
        anchors.topMargin: 20

        Image {
            id: imgCalories
            width: 80
            height: 80
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            source: "../images/calories.png"
            anchors.rightMargin: 0
            fillMode: Image.PreserveAspectFit
        }

        Text {

            id: imgCaloriesLabel
            width: 80
            height: 40
            color: "#fdfdfd"
            text: qsTr("2699")
            anchors.right: parent.right
            anchors.top: parent.top
            font.letterSpacing: 1
            font.pixelSize: 26
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            anchors.topMargin: 0
            anchors.leftMargin: 0
        }

        Text {

            id: imgCaloriesLabelUnit
            width: 80
            height: 40
            color: "#6d6d6d"
            text: qsTr("kcal")
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            font.letterSpacing: 1
            font.pixelSize: 26
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
        }

        MouseArea {
            id: mouseCaloriesArea
            anchors.fill: parent
            onClicked: {
                buttonBehavior.setButtonObject(imgBottonNavigationMain,true);
                buttonBehavior.setButtonObject(imgBottonNavigation,false);
                buttonBehavior.setButtonObject(bikeImage,false);
                buttonBehavior.setScreenMoveObject(animationRight,1);
            }
        }
    }

    Item {
        id: itemTrip
        width: 160
        height: 80
        visible: true
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 20
        anchors.topMargin: 20

        Image {
            id: imgAssist
            width: 80
            height: 80
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            source: "../images/trip.png"
            anchors.rightMargin: 0
            fillMode: Image.PreserveAspectFit
        }

        Text {

            id: imgAssistabel
            width: 80
            height: 40
            color: "#fdfdfd"
            text: qsTr("86.9")
            anchors.left: parent.left
            anchors.top: parent.top
            font.letterSpacing: 1
            font.pixelSize: 26
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            anchors.topMargin: 0
            anchors.leftMargin: 0
        }

        Text {

            id: imgTripLabelUnit
            width: 80
            height: 40
            color: "#6d6d6d"
            text: qsTr("mi")
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            font.letterSpacing: 1
            font.pixelSize: 26
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
        }


        MouseArea {
            id: mouseTripArea
            anchors.fill: parent
            onClicked: {
                buttonBehavior.setButtonObject(imgBottonNavigationMain,true);
                buttonBehavior.setButtonObject(imgBottonNavigation,false);
                buttonBehavior.setButtonObject(bikeImage,false);
                buttonBehavior.setScreenMoveObject(animationRight,1);
            }
        }
    }

}

