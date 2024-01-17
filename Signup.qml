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
                spacing: 10

                    Image
                    {
                        source: "qrc:/images/images.jpeg"
                        width: 150
                        height: 150
                        fillMode: Image.PreserveAspectFit
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    TextField
                    {
                        id: regUsernameInput
                        placeholderText: "Tên đăng nhập"
                        font.bold: true
                        width: 200
                        height: 30
                    }

                    TextField
                    {
                        id: regPasswordInput
                        placeholderText: "Mật khẩu"
                        font.bold: true
                        width: 200
                        height: 30
                        echoMode: TextInput.Password
                    }

                    TextField
                    {
                        id: regRePasswordInput
                        placeholderText: "Nhập lại mật khẩu"
                        font.bold: true
                        width: 200
                        height: 30
                        echoMode: TextInput.Password
                    }

                    TextField
                    {
                        id: regEmail
                        placeholderText: "Email"
                        font.bold: true
                        width: 200
                        height: 30
                    }

                    Button
                    {
                        text: "Đăng ký"
                        font.bold: true
                        onClicked: {
                            var username = regUsernameInput.text;
                            var password = regPasswordInput.text;
                            var rePassword = regRePasswordInput.text;
                            var email = regEmail.text;

                            if (isValidRegistration(username, password, rePassword, email))
                            {
                                saveUserDataToFirebase(username, password, email, notiSignup, errorTimer);
                            }
                            else
                            {
                                console.log("Đăng ký không thành công. Vui lòng kiểm tra lại thông tin.");
                                notiSignup.text = "Mật khẩu không khớp. Vui lòng nhập lại.";
                                errorTimer.start();
                            }
                        }
                    }

                    Button
                    {
                        text: "Quay lại"
                        font.bold: true
                        onClicked:
                        {
                            backClicked();
                        }
                    }

                    Text
                    {
                        id: notiSignup
                        color: "red"
                        text: ""
                    }

                    Timer
                    {
                        id: errorTimer
                        interval: 3000
                        onTriggered:
                        {
                            notiSignup.text = "";
                        }
                    }
                }
            }
        }
    signal backClicked();
}
