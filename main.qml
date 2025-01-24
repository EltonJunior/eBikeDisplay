import QtQuick 2.12
import QtQuick.Window 2.12

Window {

    id: mainWindow
    width: 800
    height: 480
    visible: true
    title: qsTr("QtHmiProjectFinal")

    ScreenMoving {
        id: screenMoving
    }

    //visibility:Window.FullScreen

}
