import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Templates 2.5 as T
import QtGraphicalEffects 1.0
import QtQml 2.3

T.Button {
    id: root
    implicitHeight: 56
    implicitWidth: (root.text != "") ? label.contentWidth + padding + padding : root.icon.width + padding + padding
    padding: 26
    font.weight: Font.Bold
    property int minWidth: 112
    property bool isLongPress: false
    property int elevation: 6
    property double shadowAngle: 0.0
    property double radius: 16
    property double borderWidth: 2

    Timer {
        id: longPressTimer
        interval: 1000
        running: false
        onTriggered: {
            isLongPress = true;
            control.onPressAndHold();
        }
    }

    Keys.onPressed: {
        if (!event.isAutoRepeat) {
            if (event.key === Qt.Key_Enter) {
                root.down = true;
                if (root.onPressAndHold != null) {
                    longPressTimer.restart();
                }

                event.accepted = true;
            }
        }
    }

    Keys.onReleased: {
        if (!event.isAutoRepeat) {
            if (event.key === Qt.Key_Enter) {
                if (onPressAndHold != null) {
                    longPressTimer.stop();
                    if (!isLongPress) {
                        root.onPressed();
                    }
                    else {
                        isLongPress = false;
                    }
                }
                else {
                    root.onPressed();
                }
                root.down = false;
                event.accepted = true;
            }
        }
    }

    background: Item {
        anchors.fill: parent
        children: [
            Rectangle {
                id: focusIndicator
                anchors.fill: parent
                color: ColorPalette.buttonFocused
                radius: root.radius + 6
                opacity: 0
                transform: Scale {
                    id: focusIndicatorScale
                    origin.x: width / 2
                    origin.y: height / 2
                    xScale: 0.5
                    yScale: 0.5
                }
            },
            Rectangle {
                id: shadow
                anchors.topMargin: background.anchors.margins * 2
                anchors.leftMargin: (shadowAngle >= 0 ? background.anchors.margins : (elevation + elevation * shadowAngle) / 2) + background.border.width
                anchors.rightMargin: (shadowAngle <= 0 ? background.anchors.margins : (elevation - elevation * shadowAngle) / 2) + background.border.width
                anchors.fill: parent
                color: "black"
                opacity: 0.2
                radius: root.radius
                transform: Translate {
                    id: shadowTranslate
                    y: -2
                }
            },
            Rectangle {
                id:background
                anchors.margins: 6
                anchors.fill: parent
                color: Qt.darker(foreground.color, 1.4)
                border.color: "#212121"
                border.width: borderWidth + 1
                radius: root.radius + 2
                children: Rectangle {
                    id: highlight
                    anchors.fill: parent
                    anchors.margins: background.border.width
                    radius: root.radius
                    color: Qt.lighter(foreground.color, 1.6)
                    transform: Translate {
                        id: foregroundTranslate
                        y: -elevation
                    }

                    children: [
                        Rectangle {
                            id: subHighlight
                              anchors.fill: parent
                              anchors.topMargin: borderWidth
                              color: Qt.lighter(foreground.color, 1.2)
                              radius: root.radius
                        },
                        Rectangle {
                            id:foreground
                            anchors.fill: parent
                            anchors.margins: borderWidth
                            color: ColorPalette.buttonDefault
                            radius: root.radius - 2
//                            border.color: Qt.lighter(ColorPalette.buttonDefault, 1.2)
//                            border.width: 2


                            children: [
                                Label {
                                    id: label
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    color: ColorPalette.textPrimary
                                    text: root.text
                                },
                                Image {
                                    id: icon
                                    anchors.centerIn: parent
                                    width: root.icon.width
                                    height: root.icon.height
                                    source: root.icon.source
                                }

                            ]
                        },
                        Rectangle {
                            id: pressShadow
                            height: highlight.height
                            width: highlight.width
                            color: "#000000"
                            radius: root.radius
                            opacity: 0
                        }
                    ]
                }
            }
        ]
    }




    states: [
        State {
            name: "disabledAndFocused"; when: !root.enabled && root.highlighted;
            PropertyChanges { target: pressShadow; opacity: 0.25 }
            PropertyChanges { target: shadow;  anchors.leftMargin: background.anchors.margins + background.border.width; anchors.rightMargin: background.anchors.margins + background.border.width}
            PropertyChanges { target: focusIndicator; opacity: 1.0; }
            PropertyChanges { target: focusIndicatorScale; xScale: 1.0; yScale: 1.0; }
            PropertyChanges { target: foregroundTranslate;  y: 0}
            PropertyChanges { target: shadowTranslate;  y: -background.anchors.margins}
        },
        State {
            name: "disabled"; when: !root.enabled;
            PropertyChanges { target: pressShadow; opacity: 0.25 }
            PropertyChanges { target: shadow;  anchors.leftMargin: background.anchors.margins + background.border.width; anchors.rightMargin: background.anchors.margins + background.border.width}
            PropertyChanges { target: foregroundTranslate;  y: 0}
            PropertyChanges { target: shadowTranslate;  y: -background.anchors.margins}
        },
        State {
            name: "pressed"; when: root.down
            PropertyChanges { target: pressShadow; opacity: 0.15 }
            PropertyChanges { target: shadow;  anchors.leftMargin: background.anchors.margins + background.border.width; anchors.rightMargin: background.anchors.margins + background.border.width}
            PropertyChanges { target: foreground;  color: Qt.lighter(ColorPalette.buttonDefault, 1.2)}
            PropertyChanges { target: foregroundTranslate;  y: 0}
            PropertyChanges { target: shadowTranslate;  y: -background.anchors.margins}
            PropertyChanges { target: focusIndicator; opacity: 1.0; }
            PropertyChanges { target: focusIndicatorScale; xScale: 1.0; yScale: 1.0; }
        },
        State {
            name: "focused"; when: root.highlighted
            PropertyChanges { target: foreground;  color: Qt.lighter(ColorPalette.buttonDefault, 1.2) }
            PropertyChanges { target: focusIndicator; opacity: 1.0; }
            PropertyChanges { target: focusIndicatorScale; xScale: 1.0; yScale: 1.0; }
        }
    ]

    transitions: [
        Transition {
            reversible: true
            ColorAnimation { duration: 200; easing.type: Easing.InOutSine }
            NumberAnimation { properties: "anchors.leftMargin"; duration: 200; easing.type: Easing.InOutSine }
            NumberAnimation { properties: "anchors.rightMargin"; duration: 200; easing.type: Easing.InOutSine }
            NumberAnimation { properties: "opacity"; duration: 200; easing.type: Easing.InOutSine }
            NumberAnimation { properties: "y"; duration: 200; easing.type: Easing.InOutSine }
            NumberAnimation { properties: "xScale"; duration: 200; easing.type: Easing.InOutSine }
            NumberAnimation { properties: "yScale"; duration: 200; easing.type: Easing.InOutSine }
        }
    ]
}
