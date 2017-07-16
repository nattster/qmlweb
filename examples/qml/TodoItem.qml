import QtQuick 1.0
import QtQuick.Controls 2.0

Row {
    property string todo
    property bool done
    signal toggled

    CheckBox {
        id: checkbox
        checked: done
    }
    Text {
        text: todo
    }
    MouseArea {
        anchors.fill: parent
        onClicked: toggled()
    }
}