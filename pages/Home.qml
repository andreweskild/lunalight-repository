import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4

FocusScope {
    anchors.fill: parent
    focus: true
    children: [
        ListView {
            id: controllerList
            populate: Transition {
                NumberAnimation { properties: "x,y"; duration: 1000 }
            }
            property int count: 1
            anchors.top: parent.top
            anchors.topMargin: 56
            anchors.horizontalCenter: parent.horizontalCenter
            width: contentWidth
            orientation: ListView.Horizontal
            model:count
            spacing: 20
            delegate: Button {
                text: "Controller " + (index + 1)
                focus: (index == controllerList.currentIndex) && controllerList.activeFocus
                elevation: 4
                onPressed: controllerList.count += 1
                shadowAngle: (x - platformList.currentItem.x) / 960
            }
            Keys.onDownPressed: {
                platformList.focus = true;
                event.accepted = true;
            }
        },
        ListView {
            id: platformList
            focus: true
            height: 224
            anchors.centerIn: parent
            width: window.width
            orientation: ListView.Horizontal
            model: 20
            highlightMoveDuration: 200
            preferredHighlightBegin: (window.width / 2) - (height / 2)
            preferredHighlightEnd: (window.width / 2) + (height / 2)
            highlightRangeMode: ListView.StrictlyEnforceRange
            spacing: 20
            keyNavigationWraps: true
            delegate: Button {
                display: AbstractButton.IconOnly
                icon.color: "white"
                icon.source: "qrc:/icons/PC_Logo.svg"
                icon.width: 72
                icon.height: 72
                enabled: ((index % 2) == 0)
                focus: (index == platformList.currentIndex) && platformList.activeFocus
                height: platformList.height
                width: platformList.height
                onPressed: console.log(platformList.highlightItem.x)
                onPressAndHold: console.log("long press my buttons.")
                shadowAngle: (x - platformList.currentItem.x) / 960
                elevation: 6
            }

            Keys.onUpPressed: {
                controllerList.focus = true;
                event.accepted = true;
            }
            Keys.onDownPressed: {
                settingsButton.focus = true;
                event.accepted = true;
            }
        },
        Button {
            id: settingsButton
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 56
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Settings"
            elevation: 4
            Keys.onUpPressed: {
                platformList.focus = true;
                event.accepted = true;
            }
        },
        Rectangle {
            height: parent.height / 2
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {position: 0.0; color: ColorPalette.background}
                GradientStop {position: 1.0; color: "transparent"}
            }
        },
        Rectangle {
            height: parent.height / 2
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {position: 0.0; color: "transparent"}
                GradientStop {position: 1.0; color: ColorPalette.background}
            }
        }

    ]
}
