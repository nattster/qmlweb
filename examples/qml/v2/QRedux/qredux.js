.pragma library
Qt.include("QRedux/signalproxymiddleware.js");
Qt.include("QRedux/syncmiddleware.js");

/* redux.min.js (3.6.0) */
Qt.include("QRedux/redux.min.js");
var createStore = Redux.createStore;
var combineReducers = Redux.combineReducers;
var bindActionCreators = Redux.bindActionCreators;
var applyMiddleware = Redux.applyMiddleware;
var compose = Redux.compose;

/* Immutability helper (2.0.0) */
Qt.include("QRedux/immutabilityhelper.min.js");
var update = ImmutabilityHelper.newContext();

/* Custom API */
Qt.include("QRedux/custom.js");
