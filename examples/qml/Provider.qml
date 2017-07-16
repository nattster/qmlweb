import QtQml 2.0
import QtQuick 1.0

QtObject {
    id: root
    property var middleware: []

    function dumpListModel(listModel) {
        var state = []
        for(var i = 0; i < listModel.$items.length; i++) {
            state.push(listModel.$items[i])
        }
        return state
    }

    function getState() {
        var state = {}
        for(var attname in $properties) {
            if(attname == 'middleware') continue
            state[attname] = $context[attname]
            if(state[attname].$class == 'ListModel') {
                state[attname] = dumpListModel(state[attname])
            }
        }
        return state
    }

    function dispatch(action) {
        // before middleware
        action()
        var state = getState()
        console.log(state)
        for(var i = 0; i < middleware.length; i++) {
            middleware[i](state)
        }
        // after middleware
    }

}