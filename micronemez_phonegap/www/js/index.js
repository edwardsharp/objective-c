var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
        // The watch id references the current `watchAcceleration`
        //this.watchID = null;
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },

    onDeviceReady: function() {
        app.receivedEvent('deviceready');
        //app.initAccel();
        
    },
    receivedEvent: function(id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');
        
        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');
        
        console.log('Received Event: ' + id);
    },

    initAccel: function() {

        var options = { frequency: 3000 };
        
        app.watchID = navigator.accelerometer.watchAcceleration(app.onAccelSuccess, app.onAccelError, options);
    },
    
    onAccelSuccess: function(acceleration) {
        var element = document.getElementById('accelerometer');
        element.innerHTML = 'Acceleration X: ' + acceleration.x + '<br />' +
        'Acceleration Y: ' + acceleration.y + '<br />' +
        'Acceleration Z: ' + acceleration.z + '<br />' +
        'Timestamp: '      + acceleration.timestamp + '<br />';
    },
    
    onAccelError: function() {
        console.log('ohnoz, accel errorz!');
    }

};



// The watch id references the current `watchAcceleration`
var watchID = null;

// Wait for PhoneGap to load
//
document.addEventListener("deviceready", onDeviceReady, false);

// PhoneGap is ready
//
function onDeviceReady() {
    startWatch();
}

// Start watching the acceleration
//
function startWatch() {
    
    // Update acceleration every 3 seconds
    var options = { frequency: 3000 };
    
    watchID = navigator.accelerometer.watchAcceleration(onSuccess, onError, options);
}

// Stop watching the acceleration
//
function stopWatch() {
    if (watchID) {
        navigator.accelerometer.clearWatch(watchID);
        watchID = null;
    }
}