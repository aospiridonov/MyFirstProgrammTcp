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
            spacing: Theme.paddingMedium
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
                            listModel.append({"icon": "image://theme/icon-m-back", "rot": 90})
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
                            listModel.append({"icon": "image://theme/icon-m-back", "rot": -90})
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
                            listModel.append({"icon": "image://theme/icon-m-rotate-left", "rot": 0})
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
                            listModel.append({"icon": "image://theme/icon-m-rotate-right", "rot": 0})
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

                GridView {
                    id: gridView
                    width: parent.width-20
                    height: Theme.itemSizeLarge*5


                    anchors.horizontalCenter: parent.horizontalCenter
                    cellWidth: width/4
                    cellHeight: Theme.itemSizeLarge
                    model: ListModel {
                        id: listModel
                    }
                    Rectangle {
                        id: programFieldBackground
                        anchors.fill: parent
                        color: Theme.highlightBackgroundColor
                        opacity: 0.1
                    }

                    delegate: Item {
                        width: GridView.view.cellWidth
                        height: GridView.view.cellHeight
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
                }
            }

            Column {
                id: viewCommands
                width: page.width
                height: 100
                spacing: Theme.paddingSmall
                Row {
                    spacing: Theme.paddingLarge
                    anchors.horizontalCenter: parent.horizontalCenter

                    Button {
                        preferredWidth: 100
                        Image {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            source: "image://theme/icon-l-play"
                        }
                        onClicked:
                        {
                            console.log("Timer Run")
                        }
                    }
                    Button {
                        preferredWidth: 100
                        Image {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            source: "image://theme/icon-l-clear"
                        }
                        onClicked:
                        {
                            listModel.clear()
                        }
                    }
                }

            }

        }
    }
}


