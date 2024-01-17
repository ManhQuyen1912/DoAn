import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    Rectangle {
        id: page3
        width: parent.width
        height: parent.height
        Image{
            source : "qrc:/Image/images2.jpeg"
            opacity: 0.8
            sourceSize.width: parent.width
            sourceSize.height: parent.height
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: aV
            source: "qrc:/Image/OIG.png"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 40
            }
        }

        ColumnLayout {
            anchors {
                top: aV.bottom
                horizontalCenter: aV.horizontalCenter
                topMargin: 40
            }

            Text {
                text: "Tên Người Dùng: " //+ userInfo.name
                font.pixelSize: 22
                font.bold: true
                // anchors.horizontalCenter: parent.horizontalCenter
                Layout.alignment: Qt.AlignHCenter
                color: "black"
            }

            Text {
                text: "Tuổi: " //+ userInfo.age
                font.pixelSize: 22
                //anchors.horizontalCenter: parent.horizontalCenter
                Layout.alignment: Qt.AlignHCenter
                color: "black"
                font.bold: true
            }

            Text {
                text: "Tình trạng sức khỏe: " //+ userInfo.age
                font.pixelSize: 22
                //anchors.horizontalCenter: parent.horizontalCenter
                Layout.alignment: Qt.AlignHCenter
                color: "black"
                font.bold: true
            }
        }
        // Rectangle {
        //     width: parent.width
        //     height: 100
        //     color: "transparent"  // Màu trong suốt
        //     anchors {
        //         top: parent.top
        //         left: parent.left
        //         right: parent.right
        //     }

        //     RowLayout {
        //         anchors.fill: parent
        //         TextField {
        //             width: parent.width
        //             placeholderText: "Nhập tên của bạn"
        //             font.pixelSize: 20
        //             color: "white"
        //             background: Rectangle {
        //                 color: "black"
        //                 opacity: 0.5  // Độ trong suốt của khung nhập
        //             }
        //         }
        //     }
        // }
    }
}
