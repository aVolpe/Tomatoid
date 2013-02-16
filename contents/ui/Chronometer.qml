/*
 *   Copyright 2012 Arthur Taborda <arthur.hvt@gmail.com>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 1.1
import org.kde.plasma.components 0.1 as PlasmaComponents

Item {
    property string stopButtonImage: "media-playback-stop"
    property string playButtonImage: "media-playback-start"
    property string pauseButtonImage: "media-playback-pause"

    property string timeString: Qt.formatTime(new Date(0,0,0,0,0, seconds), "mm:ss")

    property bool playing: true
    property int seconds
    property int totalSeconds

    signal stopPressed()
    signal playPressed()
    signal pausePressed()

    Row {
        id: buttons
        spacing: 3
        visible: inPomodoro

        PlasmaComponents.Button {
            id: playPauseButton
            iconSource: {
	      if(playing) return pauseButtonImage
	      else return playButtonImage
	    }

            onClicked: {
                if(playing) {
                    pausePressed()
                } else {
                    playPressed()
                }
                playing = !playing
            }
        }

        PlasmaComponents.Button {
            id: stopButton
            iconSource: stopButtonImage
            onClicked: {
	      playing = !playing
	      stopPressed()
	    }
        }
    }

    PlasmaComponents.ProgressBar {
        id: progressBar
        minimumValue: 0
        maximumValue: 1
        value: seconds / totalSeconds
        anchors {
            margins: 4
            left: {
                if(buttons.visible)
                    return buttons.right
                    else
                        return parent.left
            }
            right: parent.right
            bottom: parent.bottom
            top: parent.top
        }
    }


    Rectangle {
        id: timerRect
        radius: 5
        width: 50
        height: 20
        border.width: 1
        border.color: "#777777"
        anchors {
            verticalCenter: progressBar.verticalCenter
            horizontalCenter: progressBar.horizontalCenter
        }
    }

    PlasmaComponents.Label {
        text: timeString
        color: "#000000"
        font.pointSize: 12
        anchors {
            verticalCenter: timerRect.verticalCenter
            horizontalCenter: timerRect.horizontalCenter
        }
    }
}