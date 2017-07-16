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
            model: (provider.hideCompleted ?
                    provider.todos.filter(function(todo) { return !todo.done}) :
                    provider.todos
                    )
            TodoItem {
                onToggled: provider.toggleTodo(modelData.taskId)
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
