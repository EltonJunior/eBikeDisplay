import QtQuick 2.0

Item {
    id: clock
    width: 800
    height: 480


//    property alias city: cityLabel.text
    property int hours
    property int minutes
    property int seconds
    property real shift
    property bool night: false
    property bool internationalTime: false //Unset for local time

    function timeChanged() {
        var date = new Date;
        hours = internationalTime ? date.getUTCHours() + Math.floor(clock.shift) : date.getHours()
        night = ( hours < 7 || hours > 19 )
        minutes = internationalTime ? date.getUTCMinutes() + ((clock.shift % 1) * 60) : date.getMinutes()
        seconds = date.getUTCSeconds();

        //console.log("H: " + (date.getHours()+ Math.floor(clock.shift)) + " m: " + minutes + " s: " + seconds )
    }

    Timer {
        interval: 100; running: true; repeat: true;
        onTriggered: clock.timeChanged()
    }

    Image {
        id: background2
        source: "qrc:/images/clock/background-CES.png"
        visible: true
    }

    Item {
        id: barcode
        width: 300
        height: 300
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.rightMargin: 50

        Rectangle {
            id: shadon
            color: "#60020202"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width / 2 + 10
            height: parent.height / 2 + 10
        }

        Image {
            id: imgBarcode
            width: parent.width / 2
            height: parent.height / 2
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/images/clock/barcode.gif"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Item {
        id: itemClock
        width: 300
        height: 300
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.leftMargin: 50

        Image {
            id: background
            source: "qrc:/images/clock/clock.png"
            visible: true
            anchors.fill: parent
        }

        Image {
            id: backgroundBlack
            source: "qrc:/images/clock/clock-night.png"
            visible: false
            anchors.fill: parent
        }

        Image {
            source: "qrc:/images/clock/background.png"
            visible: true
            anchors.fill: parent
        }

        Item {
            id: pointerHour
            width: 10
            height: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            //rotation: 0

            Image {
                x: -6
                y: -72
                width: 21
                height: 77
                source: "qrc:/images/clock/hour.png"
            }

            rotation: (clock.hours * 30) + (clock.minutes * 0.5)
            Behavior on rotation {
                SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
            }
        }

        Item {
            id: pointerMinute
            width: 10
            height: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            //rotation: 45

            Image {
                x: -5
                y: -100
                width: 20
                height: 105
                source: "qrc:/images/clock/minute.png"
            }

            rotation: clock.minutes * 6
            Behavior on rotation {
                SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
            }
        }

        Item {
            id: pointerSecond
            width: 10
            height: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            //rotation: 35

            Image {
                x: 0
                y: -95
                width: 10
                height: 99
                source: "qrc:/images/clock/second.png"
            }

            rotation: clock.seconds * 6
            Behavior on rotation {
                SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
            }
        }

        Image {
            anchors.verticalCenter: parent.verticalCenter
            anchors.centerIn: background
            source: "qrc:/images/clock/center.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

