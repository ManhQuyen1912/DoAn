import QtQuick 2.2
import QtQuick.Controls 2.0

Rectangle
{
    width: parent.width
    height: parent.height

    Rectangle
    {
        width: parent.width
        height: parent.height
        color: "#B5DEF1"
        Rectangle
        {
            width: parent.width
            height: parent.height
            color: "white"
            opacity: 0.5

            Column
            {
                anchors.centerIn: parent
                spacing: 1.5

                Image
                {
                    source: "qrc:/images/images.jpeg"
                    width: 300
                    height: 200
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                TextField
                {
                    id: usernameInput
                    placeholderText: "Tên đăng nhập"
                    font.bold: true
                    width: 300
                    height: 50
                }

                TextField
                {
                    id: passwordInput
                    placeholderText: "Mật khẩu"
                    font.bold: true
                    width: 300
                    height: 50
                    echoMode: TextInput.Password
                }

                Button
                {
                    text: "Đăng nhập"
                    font.bold: true
                    onClicked:
                    {
                        var username = usernameInput.text;
                        var password = passwordInput.text;

                        // Call a function to validate login against the database
                        validateLogin(username, password, errorLogin, errorTimer);
                    }
                }

                Button
                {
                    text: "Đăng ký"
                    font.bold: true
                    onClicked:
                    {
                        // Emit signal to notify the click event
                        signUpClicked();
                    }
                }

                Text
                {
                    id: errorLogin
                    color: "red"
                    text: ""
                }

                Timer
                {
                    id: errorTimer
                    interval: 3000
                    onTriggered:
                    {
                        errorLogin.text = "";
                    }
                }
            }
        }
    }
    signal signUpClicked();
}
