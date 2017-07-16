import QtQuick 2.0
import QtQuick.Controls 2.0

Row {
    property var dispatcher
    TextInput {
        id: newItem
        width: 200
        onAccepted: dispatcher.addTodo(newItem.text)
    }
    Button {
        text: "Add"
        onClicked: {
            dispatcher.addTodo(newItem.text)
            newItem.text = ''
        }
    }
}