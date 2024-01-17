import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.1

Rectangle{
    width: parent.width; height: parent.height; visible: true
    Image{
        source : "qrc:/Image/images1.jpeg"
        opacity: 0.9
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        fillMode: Image.PreserveAspectFit
    }
    property var lines: []
    property var parts: []
    property int itemsPerPage: 10
    property int currentPage: 0
    ListModel{
        id:lCategory
    }
    ListModel{
        id:lPrice
    }
    ListModel{
        id:lName
    }
    ListModel{
        id:lPharmacy
    }

    GridLayout {
        id: grid
        anchors.fill: parent
        columns: 4
        rowSpacing: 5
        columnSpacing: 5
        anchors.margins: 5

        Repeater {
            model: lCategory
            TextArea {
                Layout.row: index
                Layout.column: 0
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: modelData
            }
        }

        Repeater {
            model: lName
            TextArea {
                Layout.row: index
                Layout.column: 1
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: modelData
            }
        }

        Repeater {
            model: lPrice
            TextArea {
                Layout.row: index
                Layout.column: 2
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: modelData
            }
        }

        Repeater {
            model: lPharmacy
            TextArea {
                Layout.row: index
                Layout.column: 3
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: modelData
            }
        }
    }

    function updateGridView() {
        var startIdx = currentPage * itemsPerPage;
        var endIdx = Math.min(startIdx + itemsPerPage, lines.length);

        // Xóa tất cả dữ liệu trong ListModel trước khi thêm dữ liệu mới
        lCategory.clear();
        lName.clear();
        lPrice.clear();
        lPharmacy.clear();

        // Thêm từng dòng vào ListModel
        for (var i = startIdx; i < endIdx; i++) {
            // Tách dữ liệu từ dòng văn bản
            parts = lines[i].match(/(?:[^,"]|"[^"]*")+/g);
            var category = parts[0];
            var productName = parts[1];
            var price = parts[2];
            var pharmacyName =parts[3];

            // Thêm dữ liệu vào ListModel
            lCategory.append({category: category});
            lName.append({productName: productName});
            lPrice.append({price: price});
            lPharmacy.append({pharmacyName: pharmacyName});
        }
    }

    Row {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter : parent.horizontalCenter
        spacing: 10

        Button {
            text: "Trang trước"
            onClicked: {
                if (currentPage > 0) {
                    currentPage--;
                    updateGridView();
                }
            }
        }

        ComboBox {
            model: Math.ceil(lines.length / itemsPerPage)
            currentIndex: currentPage
            onCurrentIndexChanged: {
                currentPage = currentIndex;
                updateGridView();
            }
        }

        Button {
            text: "Trang sau"
            onClicked: {
                if (currentPage < Math.ceil(lines.length / itemsPerPage) - 1) {
                    currentPage++;
                    updateGridView();
                }
            }
        }
    }

    function readTextFile(fileUrl) {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", fileUrl); // set Method and File
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) { // if request_status == DONE
                var response = xhr.responseText;
                lines = response.split("\n");
                currentPage = 0; // Reset về trang đầu tiên khi đọc dữ liệu mới
                updateGridView();
            }
        }
        xhr.send(); // begin the request
    }

    // Đọc tệp văn bản khi ứng dụng bắt đầu
    Component.onCompleted: {
        readTextFile("data.csv");
    }
}
