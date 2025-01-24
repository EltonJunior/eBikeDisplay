import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    id: tripScreen
    width: 800
    height: 480
    visible: true


    GridLayout {
        x: 50
        y: 23
        width: 700
        height: 118
        columnSpacing: 16
        rows: 3
        columns: 4

        Text {
            color: "#9d9d9d"
            text: qsTr("Duration (h:m)")
            font.pixelSize: 24
        }

        Text {
            color: "#000000"
            text: "7:51"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
        }

        Text {
            color: "#9d9d9d"
            text:  "(mph)"
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
        }

        Text {
            color: "#000000"
            text:  "23.5"
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pixelSize: 24
        }

        Text {
            color: "#9d9d9d"
            text:  "(mi.)"
            font.pixelSize: 24
        }

        Text {
            color: "#000000"
            text:  "92.5"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
        }

        Text {
            color: "#9d9d9d"
            text: "(mph)"
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
        }

        Text {
            color: "#000000"
            text: "11.8"
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pixelSize: 24
        }

        Text {
            color: "#9d9d9d"
            text: qsTr("Calories (kcal)")
            font.pixelSize: 24
        }

        Text {
            color: "#000000"
            text: "2834.5"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
        }

        Text {
            color: "#9d9d9d"
            text: qsTr("Ascent (m)")
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
            visible: false
        }

        Text {
            color: "#000000"
            text: "0.0"
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pixelSize: 24
            visible: false
        }
    }



    Image {
        id: chart
        x: 0
        y: 102
        width: 800
        height: 380
        source: "../images/chart01.png"
    }

}

