import QtQuick 2.0
import AnimationToMapClass 1.0
import AnimationToNumbersClass 1.0

Item {
    width: 800
    height: 480

    AnimationToMap{
        id: animationToMap
    }

    AnimationToNumbers{
        id: animationToNumbers
    }


    Image {
        id: mapBackground
        x: 0
        y: 0
        source: "qrc:/images/google_map.png"
    }


    Item {
        id: pointer
        x: animationToMap.ArrowMoveInXVar
        y: animationToMap.ArrowMoveInYVar
        rotation: animationToMap.ArrowMoveInRVar

        Image {
            id: circle
            visible: true
            source: "qrc:/images/blue_circle_gps_area.png"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/map_location_arrow.png"
            }
        }
    }



    Item {
        id: batteryPercetagem
        x: 67
        width: 230
        height: 70
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 40
        anchors.topMargin: 40

        Rectangle {
            id: backgroundBatteryPercetagem
            opacity: 0.3
            color: animationToNumbers.AlertLowBaterryToDigitVar
            border.width: 2
            anchors.fill: parent
        }

        Text {
            id: batteryPercetagemNumber
            color: "#000000"
            text: animationToNumbers.BatteryIncreaseVar
            anchors.left: parent.left
            anchors.right: simbolpercetagem.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignHCenter
            anchors.rightMargin: 0
            font.pixelSize: 62
            font.family: "Cherry"
        }

        Text {
            id: simbolpercetagem

            anchors.right: batteryPercetagem.right
            anchors.bottom: parent.bottom
            width: 44
            height: 40
            color: "#000000"
            text: "%"
            horizontalAlignment: Text.AlignLeft
            anchors.bottomMargin: 0
            font.pixelSize: 32
            font.family: "Cherry"
        }


        Image {
            id: imgBatteryIcon
            width: 80
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: "../images/battery.png"
            anchors.bottomMargin: -10
            anchors.leftMargin: -10
            anchors.topMargin: -10
        }
    }


    Item {
        id: speedValue
        width: 230
        height: 70
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.leftMargin: 40

        Rectangle {
            id: backgroundSpeedValue
            opacity: 0.3
            color: "#52576b"
            border.width: 2
            anchors.fill: parent
        }

        Text {
            id: speedNumber
            color: "#000000"
            text: animationToNumbers.SpeedIncreaseVar
            anchors.left: parent.left
            anchors.right: simbolSpeed.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignHCenter
            anchors.rightMargin: 0
            font.pixelSize: 62
            font.family: "Cherry"
        }

        Text {
            id: simbolSpeed

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 44
            color: "#000000"
            text: "mi"
            anchors.right: parent.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignBottom
            anchors.rightMargin: 80
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            font.pixelSize: 32
            font.family: "Cherry"
        }

        Image {
            id: imgSpeedIcon
            width: 70
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: "../images/speed.png"
            anchors.rightMargin: 0
        }
    }




}

