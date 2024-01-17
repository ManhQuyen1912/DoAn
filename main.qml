import QtQuick 2.15
import QtQuick.Controls 2.15


ApplicationWindow {
    visible: true
    width: 480
    height: 900
    title: "Ứng dụng Y Tế"

    property bool registrationConditionsMet: false

    StatusBar {
        id: statusBar
    }

    Loader {
        id: pageLoader
        anchors.fill: parent
        sourceComponent: loginPageComponent
    }

    Loader {
        id: mainLoader
        anchors {
            left: parent.left
            right: parent.right
            top: statusBar.bottom
            bottom: parent.bottom
        }
    }

    Component {
        id: mainPageComponent
        StatusBar {} // Assuming MainPage.qml is the file containing your main page
    }

    Component {
        id: loginPageComponent
        Login {
            onSignUpClicked: {
                pageLoader.sourceComponent = registrationPageComponent;
            }
        }
    }

    Component {
        id: registrationPageComponent
        Signup {
            onBackClicked: {
                pageLoader.sourceComponent = loginPageComponent;
            }
        }
    }

    function saveUserDataToFirebase(username, password, email, notiSignup, errorTimer) {
        var firebaseURL = "https://databaseapp-c992e-default-rtdb.firebaseio.com/AccountUsers/" + username + ".json";

        var request = new XMLHttpRequest();
        request.open("GET", firebaseURL, true);

        request.onreadystatechange = function () {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === 200) {
                    var existingData = JSON.parse(request.responseText);

                    if (existingData) {
                        notiSignup.text = "Username đã tồn tại trong cơ sở dữ liệu.";
                        errorTimer.start();
                    } else {
                        var putRequest = new XMLHttpRequest();
                        putRequest.open("PUT", firebaseURL, true);
                        putRequest.setRequestHeader("Content-Type", "application/json");

                        var userData = {
                            password: password,
                            email: email
                        };

                        putRequest.onreadystatechange = function () {
                            if (putRequest.readyState === XMLHttpRequest.DONE) {
                                if (putRequest.status === 200 || putRequest.status === 201) {
                                    console.log("Dữ liệu người dùng đã được lưu vào Firebase");
                                    registrationConditionsMet = true;
                                    console.log(registrationConditionsMet);
                                    registrationSuccessSignal();
                                } else {
                                    console.error("Lỗi khi lưu dữ liệu người dùng vào Firebase:", putRequest.responseText);
                                }
                            }
                        };

                        putRequest.send(JSON.stringify(userData));
                    }
                } else {
                    console.error("Lỗi khi kiểm tra dữ liệu người dùng từ Firebase:", request.responseText);
                }
            }
        };
        request.send();
    }

    function isValidRegistration(username, password, rePassword, fullName, age, healthStatus)
    {
        return (password === rePassword);
    }

    function registrationSuccessSignal()
    {
        if (registrationConditionsMet)
        {
            pageLoader.sourceComponent = loginPageComponent;
        }
    }

    function validateLogin(username, password, errorLogin, errorTimer)
    {
        var firebaseURL = "https://databaseapp-c992e-default-rtdb.firebaseio.com/AccountUsers/" + username + ".json";

        var xhr = new XMLHttpRequest();
        xhr.open("GET", firebaseURL, true);
        xhr.setRequestHeader("Content-Type", "application/json");

        xhr.onreadystatechange = function ()
        {
            if (xhr.readyState === XMLHttpRequest.DONE)
            {
                if (xhr.status === 200)
                {
                    var userData = JSON.parse(xhr.responseText);

                    if (userData && userData.password === password)
                    {
                        console.log("Đăng nhập thành công!");
                        // Perform actions after successful login
                        errorLogin.text = "Đăng nhập thành công!";
                        loadStackViewPage();
                    }
                    else
                    {
                        console.log("Đăng nhập không thành công. Vui lòng kiểm tra lại thông tin.");
                        errorLogin.text = "Sai tài khoản hoặc mật khẩu!";
                        errorTimer.start();
                    }
                }
                else
                {
                    console.error("Lỗi khi kiểm tra dữ liệu người dùng từ Firebase:", xhr.responseText);
                }
            }
        };
        xhr.send();
    }

    function loadStackViewPage() {
        pageLoader.sourceComponent = mainPageComponent;
    }
}


