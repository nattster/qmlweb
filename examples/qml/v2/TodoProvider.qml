import QtQuick 1.0
import "QRedux/qredux.js" as QRedux

QtObject {
    id: root
    property var store
    property var dispatch

    property var taskId: 0
    property string name: "Natt"
    property var todos: new Array;
    property bool hideCompleted: false

    function reducer(state, action) {
        if(state == undefined) {
            return {
                taskId: 0,
                name: "Natt",
                todos: [],
                hideCompleted: false
            }
        }
        if(action.type == 'addTodo') {
            var newTodos = state.todos.slice(0);
            newTodos.push({
                todo: action.text,
                done: false,
                taskId: state.taskId
            })
            return Object.assign({}, state, {
                todos: newTodos,
                taskId: state.taskId + 1
            })
        }
        else if(action.type == 'toggleTodo') {
            return Object.assign({}, state, {
                todos: state.todos.map(function(todo) {
                    if(todo.taskId == action.taskId) {
                        return Object.assign({}, todo, {
                            done: !todo.done
                        })
                    }
                    return todo
                })
            })
        }
        else if(action.type == 'toggleHideCompleted') {
            return Object.assign({}, state, {
                hideCompleted: !state.hideCompleted
            })
        }
    }

    // actions
    function addTodo(text) {
        dispatch({type: "addTodo", text: text, done: false})
    }

    function toggleTodo(taskId) {
        dispatch({type: "toggleTodo", taskId: taskId})
    }

    function toggleHideCompleted() {
        dispatch({type: "toggleHideCompleted"})
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

    Component.onCompleted: {
        function logger(store) {
            return function (next) {
                return function(action) {
                    next(action);
                    console.log("Performed action: " + action.type + " resulting state:");
                    console.log(store.getState())
                }
            }
        }
        var middlewares = QRedux.applyMiddleware(
            logger,
            QRedux.signalProxyMiddleware(provider),
            QRedux.syncMiddleware(provider)
        )
        root.store = Redux.createStore(reducer, middlewares)
        root.dispatch = store.dispatch
        STORE = root.store
    }
}