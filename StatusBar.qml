import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: statusBar
    height: 126
    width: 480

    Rectangle{
        id: infoBar
        width: parent.width
        height: 90
        color:"dodgerblue"

        RowLayout {
            id: avaPic
            spacing: 10
            Image {
                source:"qrc:/Image/OIG.png"
                sourceSize.width: 90
                sourceSize.height: 90
                fillMode: Image.PreserveAspectFit
            }

            ColumnLayout {
                spacing: 2
                Text {
                    font.pixelSize: 18
                    text: "Tên Người Dùng"
                    font.bold: true
                    color:"white"
                }
                Text {
                    font.pixelSize: 18
                    text: "Tuổi"
                    color:"white"
                    font.italic: true
                }
            }
        }
    }

    Rectangle{
        width:  parent.width
        height: 36
        color:"dodgerblue"
        anchors{
            left: parent.left
            right: parent.right
            top: infoBar.bottom
        }
        ToolButton {
            id: button1
            text: "Chụp Ảnh"
            anchors{
                rightMargin: 20
                leftMargin: 20
                left: parent.left
            }
            font.pixelSize: 20
            onClicked: {
                console.log("Clicked on Mục 1")
                mainLoader.source = "../Camera/camera.qml"
            }

            Rectangle {
                anchors.fill:parent
                border.width: 2
                border.color: "blue"
                opacity: 1.0
                radius:10
            }
        }

        ToolButton {
            id: button2
            anchors{
                rightMargin: 40
                leftMargin: 40
                left: button1.right
                right: button3.left
            }
            text: "Đơn thuốc"
            font.pixelSize: 20
            onClicked: {
                console.log("Clicked on Mục 2")
                mainLoader.source = "../database/donthuoc.qml"
            }

            Rectangle {
                anchors.fill:parent
                border.width: 2
                border.color: "blue"
                opacity: 1.0
                radius:10
            }
        }

        ToolButton {
            id: button3
            anchors{
                rightMargin: 20
                leftMargin: 20
                right: parent.right
            }
            font.pixelSize: 20
            text: "TT Cá nhân"
            onClicked: {
                console.log("Clicked on Mục 3")
                mainLoader.source = "ttcanhan.qml"
            }

            Rectangle {
                anchors.fill:parent
                border.width: 2
                border.color: "blue"
                opacity: 1.0
                radius:10
            }
        }
    }
}
