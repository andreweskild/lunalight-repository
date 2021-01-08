import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4

import "./controls" as Controls


ApplicationWindow {
    id: window
    width: 1920
    height: 1080
    visible: true
    title: qsTr("Luna")
    font.pointSize: 16

    background: Rectangle {
        anchors.fill: parent
        color: "black"
        children: Rectangle {
            anchors.fill: parent
            radius: 18
            color: ColorPalette.background
        }
    }

    FocusScope {
        focus: true
        anchors.fill: parent
        ListView {
            id: gamesList
            focus: true
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height
            width: parent.width / 2.5
            model: 20
            highlightMoveDuration: 200
            preferredHighlightBegin: 72
            preferredHighlightEnd: height - 128
            highlightRangeMode: ListView.StrictlyEnforceRange
            spacing: 4
            delegate: Controls.ListButton {
                display: AbstractButton.IconOnly
                height: gamesList.height / 5.75
                width: gamesList.width
                highlighted: gamesList.focus && gamesList.currentIndex == index && !gamesList.headerItem.activeFocus
                icon.source: "qrc:/icons/test_poster.jpg"
                onPressed: console.log(index)
            }
            header: ListView {
                id: viewSelectionList
                anchors.horizontalCenter: parent.horizontalCenter
                width: contentWidth
                height: 72
                orientation: ListView.Horizontal
                model:2
                spacing: 4
                delegate: Button {
                    anchors.verticalCenter: parent.verticalCenter
                    highlighted: gamesList.headerItem.activeFocus && viewSelectionList.currentIndex == index
                    display: AbstractButton.IconOnly
                    icon.source: "icons/grid.svg"
                    icon.color: ColorPalette.textPrimary
                    icon.width: 20
                    icon.height: 20
                    elevation: 4
                }
                Keys.onDownPressed: {
                    gamesList.currentItem.focus = true;
                    event.accepted = true;
                }
            }

            Keys.onUpPressed: {
                if(gamesList.currentIndex == 0) {
                    headerItem.focus = true;
                }
                else {
                    gamesList.decrementCurrentIndex();
                }
                event.accepted = true;
            }

            Keys.onRightPressed: {
                alphabetList.focus = true;
                event.accepted = true;
            }

            Rectangle {
                height: 100
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                gradient: Gradient {
                    orientation: Gradient.Vertical
                    GradientStop {position: 0.0; color: "transparent"}
                    GradientStop {position: 1.0; color: ColorPalette.background}
                }
            }

        }

        ListView {
            id: alphabetList
            anchors.left: gamesList.right
            anchors.leftMargin: 4
            width: contentWidth
            height: parent.height
            highlightMoveDuration: 200
            preferredHighlightBegin: 96
            preferredHighlightEnd: height - 128
            highlightRangeMode: ListView.StrictlyEnforceRange
            model:26
            spacing: 4
            delegate: Button {
                elevation: 4
                text: "A"
                highlighted: alphabetList.activeFocus && alphabetList.currentIndex == index
                height: implicitWidth
                enabled: !(index == 4)
                onPressed: console.log("A")
            }
            Keys.onLeftPressed: {
                gamesList.focus = true;
                event.accepted = true;
            }
        }
    }

}
