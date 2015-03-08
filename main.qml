import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import "." as App

ApplicationWindow {
    width: 640
    height: 480
    title: qsTr("MapTop")

    property var awesome: App.FontAwesome
    property var fa: App.FontAwesome.icons

    App.MapTop { }
}
