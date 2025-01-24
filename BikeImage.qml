import QtQuick 2.0

Item {
    id: imgBike
    x: 204
    y: 65
    width: 388
    height: imgBike.width * 0.6134
    visible: true

    Image {
        id: imgBikeRedWheelFront
        opacity: 0

        width: parent.width * 0.4149
        height: (parent.width * 0.4149) * 1.0372
        anchors.right: imgBike.right
        anchors.bottom: imgBike.bottom

        source: "qrc:/images/bike-red-wheel.png"
        fillMode: Image.PreserveAspectFit
    }

    SequentialAnimation {
        running: true
        loops: -1
        PauseAnimation {
            duration: 20000 // Wait for 20000ms
        }
        NumberAnimation {
            target: imgBikeRedWheelFront
            property: 'opacity'
            to: 1.0
            duration: 500 // Then fade away for 500ms

        }
        NumberAnimation {
            target: imgBikeRedWheelFront
            property: 'opacity'
            to: 0
            duration: 500
        }
        NumberAnimation {
            target: imgBikeRedWheelFront
            property: 'opacity'
            to: 1.0
            duration: 500
        }
        NumberAnimation {
            target: imgBikeRedWheelFront
            property: 'opacity'
            to: 0
            duration: 500
        }
    }

    Image {
        id: imgBikeRedWheelRear
        opacity: 0
        width: parent.width * 0.4149
        height: (parent.width * 0.4149) * 1.0372
        anchors.left: imgBike.left
        anchors.bottom: imgBike.bottom

        source: "qrc:/images/bike-red-wheel.png"
        fillMode: Image.PreserveAspectFit

    }

    SequentialAnimation {
        running: true
        loops: -1
        PauseAnimation {
            duration: 10000 // Wait for 10000ms
        }
        NumberAnimation {
            target: imgBikeRedWheelRear
            property: 'opacity'
            to: 1.0
            duration: 500 // Then fade away for 500ms
        }
        NumberAnimation {
            target: imgBikeRedWheelRear
            property: 'opacity'
            to: 0
            duration: 500
        }
        NumberAnimation {
            target: imgBikeRedWheelRear
            property: 'opacity'
            to: 1.0
            duration: 500
        }
        NumberAnimation {
            target: imgBikeRedWheelRear
            property: 'opacity'
            to: 0
            duration: 500
        }
    }

    Image {
        id: bikeBackground
        width: parent.width
        height: parent.height

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/images/bike-rearwheel-main.png"
        fillMode: Image.PreserveAspectFit
    }
}
