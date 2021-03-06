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

import QtQuick 1.1

FocusScope {
    id: container
    width: 80; height: 30

    property color color: "white"
    property color borderColor: "#ababab"
    property color focusColor: "#266294"
    property color hoverColor: "#5692c4"
    property alias font: textInput.font
    property alias textColor: textInput.color
    property alias echoMode: textInput.echoMode
    property alias text: textInput.text

    Rectangle {
        id: border

        property bool hover: false

        anchors.fill: parent

        color: container.color
        border.color: hover ? container.hoverColor : (container.activeFocus ? container.focusColor : container.borderColor)
        border.width: 1

        Behavior on border.color { ColorAnimation { duration: 200 } }

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent

            onEntered: parent.hover = true
            onExited: parent.hover = false
        }
    }

    TextInput {
        id: textInput
        width: parent.width - 16
        anchors.centerIn: parent

        color: "black"

        clip: true
        focus: true

        passwordCharacter: "\u25cf"
    }
}
