/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Show Page 2")
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("My First Program")
            }

            Column {
                id: viewActions
                width: page.width
                height: 100
                spacing: Theme.paddingSmall

                Label {
                    text: "Команды"
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: Theme.secondaryColor
                    anchors.leftMargin: 10
                }

                Row {
                    spacing: Theme.paddingLarge
                    anchors.horizontalCenter: parent.horizontalCenter

                    Button {
                        preferredWidth: 100
                        Image {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            source: "image://theme/icon-m-back"
                            rotation: 90
                        }
                        onClicked:
                        {
                            listModel.append({"command": "forwar", "icon": "image://theme/icon-m-back", "rot": 90})
                        }
                    }
                    Button {
                        preferredWidth: 100
                        Image {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            source: "image://theme/icon-m-back"
                            rotation: -90
                        }
                        onClicked:
                        {
                            listModel.append({"command": "back", "icon": "image://theme/icon-m-back", "rot": -90})
                        }
                    }
                    Button {
                        preferredWidth: 100
                        Image {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            source: "image://theme/icon-m-rotate-left"
                        }
                        onClicked:
                        {
                            listModel.append({"command": "left", "icon": "image://theme/icon-m-rotate-left", "rot": 0})
                        }
                    }
                    Button {
                        preferredWidth: 100
                        Image {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            source: "image://theme/icon-m-rotate-right"
                        }
                        onClicked:
                        {
                            listModel.append({"command": "right", "icon": "image://theme/icon-m-rotate-right", "rot": 0})
                        }
                    }
                }
            }

            Column {
                width: page.width
                spacing: Theme.paddingSmall

                Label {
                    text: "Поле программы"
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: Theme.secondaryColor
                }

                SilicaGridView {
                    id: gridView
                    width: parent.width-20
                    height: Theme.itemSizeLarge*5

                    anchors.horizontalCenter: parent.horizontalCenter
                    cellWidth: width/4
                    cellHeight: Theme.itemSizeLarge
                    currentIndex: -1
                    clip: true
                    snapMode: GridView.SnapOneRow

                    model: ListModel {
                        id: listModel
                    }
                    Rectangle {
                        id: programFieldBackground
                        anchors.fill: parent
                        color: Theme.highlightBackgroundColor
                        opacity: 0.1
                    }

                    highlight: Rectangle {
                        //color: "lightsteelblue";
                        color: Theme.highlightColor
                        radius: 5
                    }

                    delegate: Item {
                        width: GridView.view.cellWidth
                        height: GridView.view.cellHeight

                        Component.onCompleted: gridView.scrollToBottom()

                        Button {
                            preferredWidth: 100
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            Image {
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                source: icon
                                rotation: rot
                            }
                        }
                    }

                    VerticalScrollDecorator {flickable: gridView}
                }
            }

            Row {
                id: viewCommands
                spacing: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter

                IconButton {
                    icon.source: "image://theme/icon-l-play"
                    onClicked:
                    {
                        console.log("Timer Run")
                        timer.idx = 0;
                        timer.start()
                    }
                }
                IconButton {
                    icon.source: "image://theme/icon-l-clear"
                    onClicked:
                    {
                        listModel.clear()
                    }
                }
            }

            Timer {
                id: timer
                interval: 1000; repeat: true
                running: false
                triggeredOnStart: false
                property var idx;
                onTriggered: {
                    console.log("Timer tick")
                    if (idx !== gridView.count)
                    {
                        console.log(gridView.model.get(idx).command)
                        if (gridView.model.get(idx).command === "back")
                        {
                            console.log("is_back")
                        }
                        else if(gridView.model.get(idx).command === "forward")
                        {
                            console.log("is_forward")
                        }
                        else if(gridView.model.get(idx).command === "left")
                        {
                            console.log("is_left")
                        }
                        else if(gridView.model.get(idx).command === "right")
                        {
                            console.log("is_right")
                        }

                        gridView.currentIndex = idx;
                        idx ++;
                    }
                    else
                    {
                        console.log("stop command")
                        gridView.currentIndex = -1;
                        timer.stop();
                    }
                }
            }

        }
    }
}


