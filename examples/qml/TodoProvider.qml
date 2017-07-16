import QtQuick 1.0

Provider {
    id: root
    property string name: "Natt"
    property ListModel todos: ListModel {}
    property bool hideCompleted: false

    middleware: [
        function(state) {
        
        }
    ]

    // actions
    function addTodo(text) {
        dispatch(function() {
            todos.append({todo: text, done: false})
        })
    }

    function toggleTodo(index) {
        dispatch(function() {
            var todo = todos.get(index)
            todos.setProperty(index, 'done', !todo.done)
        })
    }

    function toggleHideCompleted() {
        dispatch(function() {
            hideCompleted = !hideCompleted
        })
    }

    function newListModel() {
        var val = {
            $children: [],
            $class: "ListModel",
            $on: undefined,
        }
        return QmlWeb.construct({
          object: val,              // meta on how to create object
          parent: root,             // parent QtQobject object
          context: root.$context    // root context object
        });
    }
}