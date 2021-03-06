/***************************************************************************
* Copyright (c) 2013 Abdurrahman AVCI <abdurrahmanavci@gmail.com>
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge,
* publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included
* in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
* OR OTHER DEALINGS IN THE SOFTWARE.
*
***************************************************************************/

import QtQuick 2.0

Rectangle {
    id: container
    width: 640
    height: 480

    Connections {
        target: sessionManager

        onSuccess: {
            errorMessage.color = "steelblue"
            errorMessage.text = qsTr("Login succeeded.")
        }

        onFail: {
            errorMessage.color = "red"
            errorMessage.text = qsTr("Login failed.")
        }
    }
    
    Background {
        id: background
        anchors.fill: parent
        image: "background.jpg"
        // video: "video.avi"
    }

    Clock {
        id: clock
        anchors.fill: parent
    }
    
    Image {
        id: rectangle
        anchors.centerIn: parent
        width: 320; height: 320

        source: "rectangle.png"

        Column {
            anchors.centerIn: parent
            spacing: 12
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                color: "black"
                text: qsTr("Welcome to ") + sessionManager.hostName
                font.pixelSize: 24
            }

            Column {
                width: parent.width
                spacing: 4
                Text {
                    id: lblName
                    width: 60
                    text: qsTr("User name")
                    font.bold: true
                    font.pixelSize: 12
                }

                TextBox {
                    id: name
                    width: parent.width; height: 30
                    text: sessionManager.lastUser
                    font.pixelSize: 14

                    KeyNavigation.backtab: rebootButton; KeyNavigation.tab: password

                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return) {
                            sessionManager.login(name.text, password.text, session.index)
                            event.accepted = true
                        }
                    }
                }
            }

            Column {
                width: parent.width
                spacing : 4
                Text {
                    id: lblPassword
                    width: 60
                    text: qsTr("Password")
                    font.bold: true
                    font.pixelSize: 12
                }

                TextBox {
                    id: password
                    width: parent.width; height: 30
                    font.pixelSize: 14

                    echoMode: TextInput.Password

                    KeyNavigation.backtab: name; KeyNavigation.tab: session

                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return) {
                            sessionManager.login(name.text, password.text, session.index)
                            event.accepted = true
                        }
                    }
                }
            }

            Column {
                width: parent.width
                spacing : 4
                Text {
                    id: lblSession
                    width: 60
                    text: qsTr("Session")
                    font.bold: true
                    font.pixelSize: 12
                }

                SpinBox {
                    id: session
                    width: parent.width; height: 30
                    font.pixelSize: 14

                    items: sessionManager.sessionNames
                    index: sessionManager.lastSessionIndex

                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return) {
                            sessionManager.login(name.text, password.text, session.index)
                            event.accepted = true
                        }
                    }

                    KeyNavigation.backtab: password; KeyNavigation.tab: loginButton
                }
            }

            Column {
                width: parent.width
                Text {
                    id: errorMessage
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Enter your user name and password.")
                    font.pixelSize: 10
                }
            }

            Row {
                spacing: 4
                anchors.horizontalCenter: parent.horizontalCenter
                Button {
                    id: loginButton
                    text: qsTr("Login")

                    onClicked: sessionManager.login(name.text, password.text, session.index)

                    KeyNavigation.backtab: session; KeyNavigation.tab: shutdownButton
                }

                Button {
                    id: shutdownButton
                    text: qsTr("Shutdown")

                    onClicked: sessionManager.shutdown()

                    KeyNavigation.backtab: loginButton; KeyNavigation.tab: rebootButton
                }

                Button {
                    id: rebootButton
                    text: qsTr("Reboot")

                    onClicked: sessionManager.reboot()

                    KeyNavigation.backtab: shutdownButton; KeyNavigation.tab: name
                }
            }
        }
    }

    Component.onCompleted: {
        if (name.text == "")
            name.focus = true
        else
            password.focus = true
    }
}
