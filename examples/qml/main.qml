import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    color: "lightgray"
    width: 400
    height: 400

    TodoProvider {
        id: provider
    }

    Column {    
        Repeater {
            model: provider.todos
            TodoItem {
                visible: provider.hideCompleted ? !done : true
                onToggled: provider.toggleTodo(index)
            }
        }
        AddTodo {
            dispatcher: provider
        }
        CheckBox {
            checked: provider.hideCompleted
            text: "Hide completed"
            onCheckedChanged: provider.toggleHideCompleted()
        }
    }
    

    Component.onCompleted: {
        PROVIDER = provider
    }
}
