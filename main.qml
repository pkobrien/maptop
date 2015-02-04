import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2

ApplicationWindow {
    title: qsTr("MapTop")
    width: 640
    height: 480

    property var awesome: FontAwesome { }
    property var fa: awesome.icons

//    menuBar: MenuBar {
//        Menu {
//            title: qsTr("&File")
//            MenuItem {
//                text: qsTr("E&xit")
//                onTriggered: Qt.quit();
//            }
//        }
//    }

    MapTop {
        anchors.fill: parent
    }

//    Test {
//        anchors.fill: parent
//    }

}
