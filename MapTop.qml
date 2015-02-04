import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtLocation 5.3
import QtPositioning 5.2

Item {
    id: root
    width: 640
    height: 480
    focus: true

    Map {
        id: map
        anchors.fill: parent
        center { latitude: 41.8337329; longitude: -87.7321555 }
        gesture.enabled: true
        gesture.flickDeceleration: 3000
        plugin: Plugin { name: "osm" }
        zoomLevel: Math.round((maximumZoomLevel - minimumZoomLevel) / 2)

        MouseArea {
            id: mapMouseArea
            anchors.fill: parent
            onDoubleClicked: {
//                map.center = mouse.coordinate;
                zoomInAction.trigger();
            }
        }
    }

    Action {
        id: zoomInAction
        text: "Zoom In"
        shortcut: StandardKey.ZoomIn
        enabled: (map.zoomLevel < map.maximumZoomLevel)
        onTriggered: {
            map.zoomLevel += 1;
//            console.log("zoomInAction", map.minimumZoomLevel, map.zoomLevel, map.maximumZoomLevel);
        }
    }

    Action {
        id: zoomOutAction
        text: "Zoom Out"
        shortcut: StandardKey.ZoomOut
        enabled: (map.zoomLevel > map.minimumZoomLevel)
        onTriggered: {
            map.zoomLevel -= 1;
//            console.log("zoomOutAction", map.minimumZoomLevel, map.zoomLevel, map.maximumZoomLevel);
        }
    }

    Rectangle {
        id: zoomBox
        anchors.bottom: zoomText.top
        anchors.bottomMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 20
        border.color: "#666666"
        border.width: 1
        color: Qt.rgba(1, 1, 1, 0.8)
        width: childrenRect.width + 8
        height: childrenRect.height + 8
        radius: 2

        Column {
            id: zoomColumn
            anchors.top: parent.top
            anchors.topMargin: 4
            anchors.left: parent.left
            anchors.leftMargin: 4
            spacing: 4

            Slider {
                id: zoomSlider
                anchors.horizontalCenter: parent.horizontalCenter
                maximumValue: map.maximumZoomLevel
                minimumValue: map.minimumZoomLevel
                orientation: Qt.Vertical
                updateValueWhileDragging: true
                value: map.zoomLevel
                width: 40
                onValueChanged: map.zoomLevel = value
            }

            FaButton {
                id: zoomInButton
                anchors.horizontalCenter: parent.horizontalCenter
                dimmed: !zoomInAction.enabled
                text: fa.plus
                onClicked: zoomInAction.trigger();
            }

            FaButton {
                id: zoomOutButton
                anchors.horizontalCenter: parent.horizontalCenter
                dimmed: !zoomOutAction.enabled
                text: fa.minus
                onClicked: zoomOutAction.trigger();
            }

            populate: Transition {
                NumberAnimation {
                    properties: "y";
                    from: 0;
                    duration: 1000;
                    easing.type: Easing.OutBounce
                }
            }
        }
    }

    Text {
        id: zoomText
        text: qsTr("Zoom: %L1").arg(map.zoomLevel)
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        font.pointSize: 10
        font.bold: true
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Plus) {
            zoomInAction.trigger();
        } else if (event.key === Qt.Key_Minus) {
            zoomOutAction.trigger();
        } else if (event.key === Qt.Key_T) {
            if (map.activeMapType === MapType.StreetMap) {
                map.activeMapType = MapType.SatelliteMapDay;
            } else if (map.activeMapType === MapType.SatelliteMapDay) {
                map.activeMapType = MapType.StreetMap;
            }
        }
    }
}
