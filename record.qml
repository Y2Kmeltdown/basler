import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    visible: true
    width: 1280
    height: 720
    title: "Basler"

    property var basler_maximum_width
    property var basler_width_increment
    property var basler_maximum_height
    property var basler_height_increment
    property var basler_maximum_framerate
    property var basler_minimum_exposure
    property var basler_maximum_exposure
    property var basler_minimum_gain
    property var basler_maximum_gain

    property var event_diff_increment
    property var event_diff_off_increment
    property var event_diff_on_increment
    property var event_maximum_diff
    property var event_minimum_diff
    property var event_maximum_diff_on
    property var event_minimum_diff_on
    property var event_maximum_diff_off
    property var event_minimum_diff_off

    Timer {
        property var trigger_index: 0
        interval: 16
        running: true
        repeat: true
        onTriggered: {
            ++trigger_index
            image_display.source = `image://camera/${trigger_index}`
            event_image_display.source = `image://eventcamera/${trigger_index}`
        }
    }

    RowLayout{
        spacing: 0
        width: window.width
        height: window.height

        Rectangle {
            id: image_display_container
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "#090909"

            Text {
                id: basler_label
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 10
                text: "Basler Camera"
                color: "#FFFFFF"
                font: monospace_font
                z: 1
            }

            Image {
                id: image_display
                anchors.fill: image_display_container
                fillMode: Image.PreserveAspectFit
                source: `image://camera/0`
            }
        }

        Rectangle {
            id: event_image_display_container
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "#090909"

            Text {
                id: event_label
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 10
                text: "Event Camera"
                color: "#FFFFFF"
                font: monospace_font
                z: 1
            }

            Image {
                id: event_image_display
                anchors.fill: event_image_display_container
                fillMode: Image.PreserveAspectFit
                source: `image://eventcamera/0`
            }
        }

        Rectangle {
            id: menu
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            Layout.minimumWidth: 320
            Layout.maximumWidth: 320
            color: "#191919"

            ScrollView {
                width: menu.width
                height: menu.height
                clip: true
                topPadding: 20
                leftPadding: 20
                rightPadding: 20
                bottomPadding: 20

                ColumnLayout {
                    width: menu.width - 40

                    Text {
                        Layout.topMargin: 10
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        text: "Basler Camera Settings"
                        color: "#FFFFFF"
                        font.family: monospace_font.family
                        font.pixelSize: monospace_font.pixelSize
                        font.bold: true
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            text: "Width"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        SpinBox {
                            palette.button: "#393939"
                            palette.buttonText: "#FFFFFF"
                            palette.text: "#FFFFFF"
                            palette.base: "#191919"
                            palette.mid: "#494949"
                            palette.highlight: "#1E88E5"
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            from: basler_width_increment
                            to: basler_maximum_width
                            value: configuration && configuration.basler_width ? configuration.basler_width : 0
                            stepSize: basler_width_increment
                            editable: true
                            enabled: configuration?.basler_recording_name == null
                            font: monospace_font

                            onValueModified: {
                                configuration.basler_width = value;
                            }
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            text: "Height"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        SpinBox {
                            palette.button: "#393939"
                            palette.buttonText: "#FFFFFF"
                            palette.text: "#FFFFFF"
                            palette.base: "#191919"
                            palette.mid: "#494949"
                            palette.highlight: "#1E88E5"
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            from: basler_height_increment
                            to: basler_maximum_height
                            value: configuration && configuration.basler_height ? configuration.basler_height : 0
                            stepSize: basler_height_increment
                            editable: true
                            enabled: configuration?.basler_recording_name == null
                            font: monospace_font

                            onValueModified: {
                                configuration.basler_height = value;
                            }
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            text: "X offset"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        SpinBox {
                            palette.button: "#393939"
                            palette.buttonText: "#FFFFFF"
                            palette.text: "#FFFFFF"
                            palette.base: "#191919"
                            palette.mid: "#494949"
                            palette.highlight: "#1E88E5"
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            from: 0
                            to: basler_maximum_width
                            value: configuration && configuration.basler_x_offset ? configuration.basler_x_offset : 0
                            stepSize: basler_width_increment
                            editable: true
                            enabled: configuration?.basler_recording_name == null
                            font: monospace_font

                            onValueModified: {
                                configuration.basler_x_offset = value;
                            }
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            text: "Y offset"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        SpinBox {
                            palette.button: "#393939"
                            palette.buttonText: "#FFFFFF"
                            palette.text: "#FFFFFF"
                            palette.base: "#191919"
                            palette.mid: "#494949"
                            palette.highlight: "#1E88E5"
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            from: 0
                            to: basler_maximum_height
                            value: configuration && configuration.basler_y_offset ? configuration.basler_y_offset : 0
                            stepSize: basler_height_increment
                            editable: true
                            enabled: configuration?.basler_recording_name == null
                            font: monospace_font

                            onValueModified: {
                                configuration.basler_y_offset = value;
                            }
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            text: "Maximum frame rate"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        SpinBox {
                            id: frame_rate_spinbox
                            palette.button: "#393939"
                            palette.buttonText: "#FFFFFF"
                            palette.text: "#FFFFFF"
                            palette.base: "#191919"
                            palette.mid: "#494949"
                            palette.highlight: "#1E88E5"
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            from: 1
                            to: basler_maximum_framerate
                            stepSize: 1
                            value: 10000
                            editable: true
                            enabled: configuration?.basler_recording_name == null
                            font: monospace_font

                            validator: DoubleValidator {
                                bottom: frame_rate_spinbox.from
                                top: frame_rate_spinbox.to
                                decimals: 1
                                notation: DoubleValidator.StandardNotation
                            }

                            textFromValue: function(value, locale) {
                                return Number(value / 10).toLocaleString(locale, 'f', 1)
                            }

                            valueFromText: function(text, locale) {
                                return Math.round(Number.fromLocaleString(locale, text) * 10)
                            }

                            onValueModified: {
                                configuration.basler_framerate = value;
                            }
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            text: "Exposure (µs)"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        SpinBox {
                            palette.button: "#393939"
                            palette.buttonText: "#FFFFFF"
                            palette.text: "#FFFFFF"
                            palette.base: "#191919"
                            palette.mid: "#494949"
                            palette.highlight: "#1E88E5"
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            from: basler_minimum_exposure
                            to: basler_maximum_exposure
                            value: 3000
                            stepSize: 1
                            editable: true
                            enabled: configuration?.basler_recording_name == null
                            font: monospace_font

                            onValueModified: {
                                configuration.basler_exposure = value;
                            }
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            text: "Gain"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        SpinBox {
                            id: gain_spinbox
                            palette.button: "#393939"
                            palette.buttonText: "#FFFFFF"
                            palette.text: "#FFFFFF"
                            palette.base: "#191919"
                            palette.mid: "#494949"
                            palette.highlight: "#1E88E5"
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            from: basler_minimum_gain
                            to: basler_maximum_gain
                            stepSize: 1
                            value: 0
                            editable: true
                            enabled: configuration?.basler_recording_name == null
                            font: monospace_font

                            validator: DoubleValidator {
                                bottom: gain_spinbox.from
                                top: gain_spinbox.to
                                decimals: 1
                                notation: DoubleValidator.StandardNotation
                            }

                            textFromValue: function(value, locale) {
                                return Number(value / 100).toLocaleString(locale, 'f', 2)
                            }

                            valueFromText: function(text, locale) {
                                return Math.round(Number.fromLocaleString(locale, text) * 100)
                            }

                            onValueModified: {
                                configuration.basler_gain = value;
                            }
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 10
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: "Calculated frame rate"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: configuration && configuration.basler_calculated_framerate ? configuration.basler_calculated_framerate.toFixed(1) : "-"
                            color: "#FFFFFF"
                            font: monospace_font
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: "Measured frame rate"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: configuration && configuration.basler_measured_framerate ? configuration.basler_measured_framerate.toFixed(1) : "-"
                            color: "#FFFFFF"
                            font: monospace_font
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: "USB buffer usage"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: configuration ? `${configuration.basler_queued_buffers} / ${configuration.basler_maximum_queued_buffers}` : "-"
                            color: "#FFFFFF"
                            font: monospace_font
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        spacing: 20

                        ComboBox {
                            model: ["Direct mode", "Circular buffer"]
                            enabled: configuration?.basler_recording_name == null
                            onCurrentIndexChanged: {
                                configuration.basler_mode = currentIndex;
                            }
                        }
                    }

                    RowLayout {
                        visible: configuration?.basler_mode == 0
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: "RAM buffer"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: configuration ? configuration.basler_buffered_frames : "-"
                            color: "#FFFFFF"
                            font: monospace_font
                        }
                    }

                    ColumnLayout {
                        visible: configuration?.basler_mode == 1
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        spacing: 5

                        RowLayout {
                            Layout.topMargin: 5
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            spacing: 20
                            Text {
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                                text: "Duration"
                                color: "#CCCCCC"
                                font: monospace_font
                            }
                            ComboBox {
                                model: ["100 ms", "200 ms", "500 ms", "1 s", "2 s", "5 s", "10 s", "20 s"]
                                currentIndex: 5
                                enabled: configuration?.basler_recording_name == null
                                onCurrentIndexChanged: {
                                    configuration.basler_circular_buffer_duration = model[currentIndex];
                                }
                            }
                        }
                    }

                    RowLayout {
                        visible: configuration?.basler_mode == 1
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: "Circular buffer"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: configuration && configuration.basler_circular_buffer_usage ? configuration.basler_circular_buffer_usage : "-"
                            color: "#FFFFFF"
                            font: monospace_font
                        }
                    }

                    // Event Camera Controls Section
                    Rectangle {
                        Layout.topMargin: 20
                        Layout.fillWidth: true
                        height: 1
                        color: "#494949"
                    }

                    Text {
                        Layout.topMargin: 10
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        text: "Event Camera Settings"
                        color: "#FFFFFF"
                        font.family: monospace_font.family
                        font.pixelSize: monospace_font.pixelSize
                        font.bold: true
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            text: "Diff On"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        SpinBox {
                            palette.button: "#393939"
                            palette.buttonText: "#FFFFFF"
                            palette.text: "#FFFFFF"
                            palette.base: "#191919"
                            palette.mid: "#494949"
                            palette.highlight: "#1E88E5"
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            from: event_minimum_diff_on
                            to: event_maximum_diff_on
                            value: configuration && configuration.event_diff_on ? configuration.event_diff_on : 140
                            stepSize: event_diff_on_increment
                            editable: true
                            enabled: configuration?.basler_recording_name == null
                            font: monospace_font

                            onValueModified: {
                                configuration.event_diff_on = value;
                            }
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            text: "Diff Off"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        SpinBox {
                            palette.button: "#393939"
                            palette.buttonText: "#FFFFFF"
                            palette.text: "#FFFFFF"
                            palette.base: "#191919"
                            palette.mid: "#494949"
                            palette.highlight: "#1E88E5"
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            from: event_minimum_diff_off
                            to: event_maximum_diff_off
                            value: configuration && configuration.event_diff_off ? configuration.event_diff_off : 80
                            stepSize: event_diff_off_increment
                            editable: true
                            enabled: configuration?.event_recording_name == null
                            font: monospace_font

                            onValueModified: {
                                configuration.event_diff_off = value;
                            }
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            text: "Diff"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        SpinBox {
                            palette.button: "#393939"
                            palette.buttonText: "#FFFFFF"
                            palette.text: "#FFFFFF"
                            palette.base: "#191919"
                            palette.mid: "#494949"
                            palette.highlight: "#1E88E5"
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            from: event_minimum_diff
                            to: event_maximum_diff
                            value: configuration && configuration.event_diff ? configuration.event_diff : 100
                            stepSize: event_diff_increment
                            editable: true
                            enabled: configuration?.event_recording_name == null
                            font: monospace_font

                            onValueModified: {
                                configuration.event_diff = value;
                            }
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            text: "Buffer Duration (ms)"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        SpinBox {
                            palette.button: "#393939"
                            palette.buttonText: "#FFFFFF"
                            palette.text: "#FFFFFF"
                            palette.base: "#191919"
                            palette.mid: "#494949"
                            palette.highlight: "#1E88E5"
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            from: 10
                            to: 10000
                            value: configuration && configuration.event_buffer_duration ? configuration.event_buffer_duration : 200
                            stepSize: 10
                            editable: true
                            enabled: configuration?.event_recording_name == null
                            font: monospace_font

                            onValueModified: {
                                configuration.event_buffer_duration = value;
                            }
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: "Event Rate"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: configuration && configuration.event_measured_eventrate ? configuration.event_measured_eventrate.toFixed(1) : "-"
                            color: "#FFFFFF"
                            font: monospace_font
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: "Buffer Usage"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: configuration && configuration.event_buffered_events !== undefined && configuration.event_maximum_buffer_size !== undefined ? 
                                `${configuration.event_buffered_events} / ${configuration.event_maximum_buffer_size}` : "0 / 0"
                            color: "#FFFFFF"
                            font: monospace_font
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        spacing: 20
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: "Buffer %"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: {
                                if (configuration && configuration.event_buffered_events !== undefined && configuration.event_maximum_buffer_size !== undefined && configuration.event_maximum_buffer_size > 0) {
                                    var percentage = (configuration.event_buffered_events / configuration.event_maximum_buffer_size * 100).toFixed(1)
                                    return percentage + "%"
                                }
                                return "0.0%"
                            }
                            color: "#FFFFFF"
                            font: monospace_font
                        }
                    }

                    RowLayout {
                        Layout.topMargin: 5
                        Layout.alignment: configuration?.basler_recording_name == null ? Qt.AlignVCenter | Qt.AlignLeft : Qt.AlignVCenter | Qt.AlignRight
                        spacing: 20

                        Button {
                            property var click_index: 0
                            text: "Start recording"
                            visible: configuration?.basler_recording_name == null
                            onClicked: {
                                ++click_index
                                configuration.start_recording = click_index
                            }
                        }

                        Button {
                            property var click_index: 0
                            text: "Stop recording"
                            visible: configuration?.basler_recording_name != null && configuration?.basler_mode == 0
                            onClicked: {
                                ++click_index
                                configuration.stop_recording = click_index
                            }
                        }
                    }

                    ColumnLayout {
                        visible: configuration?.basler_recording_name != null
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        spacing: 5

                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: "Recording to"
                            color: "#CCCCCC"
                            font: monospace_font
                        }
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: configuration && configuration.basler_recording_name ? configuration.basler_recording_name : "-"
                            color: "#FFFFFF"
                            font: monospace_font
                        }
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: configuration ? configuration.basler_recording_duration : "-"
                            color: "#FFFFFF"
                            font: monospace_font
                        }
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: configuration ? `${configuration.basler_recording_frames} frames` : "-"
                            color: "#FFFFFF"
                            font: monospace_font
                        }
                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: configuration ? configuration.basler_recording_bytes : "-"
                            color: "#FFFFFF"
                            font: monospace_font
                        }
                    }
                }
            }
        }
    }
}
