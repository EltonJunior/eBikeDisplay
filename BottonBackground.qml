import QtQuick 2.0
import QtQuick.Controls 2.12
import AnimationToNumbersClass 1.0


Item{
    id: itemBottonBackground
    width: imgBottonBackground.width
    height: imgBottonBackground.height
    anchors.bottom: parent.bottom

    AnimationToNumbers{
        id: animationToNumbers
    }

    Image {
        id: imgBottonBackground
        x: 0
        y: 0

        source: "qrc:/images/botton-background.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgHighbeam
        anchors.bottom: imgBottonBackground.bottom
        anchors.bottomMargin: 35

        anchors.left: imgBottonBackground.left
        anchors.leftMargin: 35

        visible: true
        property bool isActive: false
        source: isActive ? "qrc:/images/lights_on.png" : "qrc:/images/lights_off.png"
        fillMode: Image.PreserveAspectFit

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked:{
            parent.isActive = !parent.isActive
            if(parent.isActive)
                output.pinHigh();
            else
                output.pinLow();
                }
            }
        }


    Item {
        id: odometerValue
        width: 200
        height: 40
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: odometerNumber
            color: "#FFFFFF"
            text: animationToNumbers.OdometerIncreaseVar
            anchors.left: parent.left
            anchors.right: simbolOdometer.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignHCenter
            anchors.rightMargin: 0
            font.pixelSize: 32
            font.family: "Cherry"
        }

        Text {
            id: simbolOdometer

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: "#FFFFFF"
            text: "mi"
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignBottom
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            font.pixelSize: 22
            font.family: "Cherry"
        }

    }

}

