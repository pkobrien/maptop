import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0
import "." as App

Rectangle {
    id: faButton

    property var awesome: App.FontAwesome
    property var fa: App.FontAwesome.icons

    property bool dimmed: false

    width: 40
    height: 40

    color: "white"
    border.width: 1
    border.color: "#666666"
    radius: 4

    layer.enabled: true
    layer.effect: DropShadow {
        color: Qt.rgba(0, 0, 0, 0.3)
        horizontalOffset: 1
        verticalOffset: 1
        radius: 2
        samples: 16
        source: faButton
        transparentBorder: true
    }

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        border.width: parent.border.width
        border.color: parent.border.color
        gradient: Gradient {
            GradientStop { position: 0.0; color: "white" }
            GradientStop { position: 1.0; color: "lightgray" }
        }
        radius: parent.radius
        visible: true
    }

    Rectangle {
        id: hoverBackground
        anchors.fill: parent
        border.width: parent.border.width
        border.color: "steelblue"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "white" }
            GradientStop { position: 1.0; color: "lightsteelblue" }
        }
        radius: parent.radius
        visible: false
    }

    Rectangle {
        id: pressedBackground
        anchors.fill: parent
        border.width: parent.border.width
        border.color: "steelblue"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "white" }
            GradientStop { position: 1.0; color: "steelblue" }
        }
        radius: parent.radius
        visible: false
    }

    property alias text: label.text

    signal clicked

    Text {
        id: label
        text: fa.question
        anchors.fill: parent
        antialiasing: false
        color: "black"
        font.family: awesome.family
        font.pointSize: 18
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true
        onClicked: parent.clicked();
        onDoubleClicked: { } // Keep the map from getting this event.
    }

    states: [
        State {
            name: "dimmed"
            when: faButton.dimmed
            PropertyChanges { target: label; color: "dimgray" }
        },
        State {
            name: "pressed"
            when: mouseArea.containsPress && !faButton.dimmed
            PropertyChanges { target: pressedBackground; visible: true }
        },
        State {
            name: "hovered"
            when: mouseArea.containsMouse && !faButton.dimmed
            PropertyChanges { target: hoverBackground; visible: true }
        }
    ]
}
