(function(){
  var konashi = {
    /******************************************
     * constants
     ******************************************/
    // url scheme
    KONASHI_URL_SCHEME: "konashijs",

    // konashi common
    HIGH: 1,
    LOW: 0,
    OUTPUT: 1,
    INPUT: 0,
    PULLUP: 1,
    NO_PULLS: 0,
    ENABLE: 1,
    DISABLE: 0,
    TRUE: 1,
    FALSE: 0,
    KONASHI_SUCCESS: 0,
    KONASHI_FAILURE: -1,

    // Konashi I/0 pin
    PIO0: 0,
    PIO1: 1,
    PIO2: 2,
    PIO3: 3,
    PIO4: 4,
    PIO5: 5,
    PIO6: 6,
    PIO7: 7,
    S1: 0,
    LED2: 1,
    LED3: 2,
    LED4: 3,
    LED5: 4,
    AIO0: 0,
    AIO1: 1,
    AIO2: 2,
    I2C_SDA: 6,
    I2C_SCL: 7,

    // Konashi PWM
    KONASHI_PWM_DISABLE: 0,
    KONASHI_PWM_ENABLE: 1,
    KONASHI_PWM_ENABLE_LED_MODE: 2,
    KONASHI_PWM_LED_PERIOD: 10000,  // 10ms

    // Konashi analog I/O
    KONASHI_ANALOG_REFERENCE: 1300, // 1300mV

    // Konashi UART baudrate
    KONASHI_UART_RATE_2K4: 0x000a,
    KONASHI_UART_RATE_9K6: 0x0028,

    // Konashi I2C
    KONASHI_I2C_DATA_MAX_LENGTH: 18,
    KONASHI_I2C_DISABLE: 0,
    KONASHI_I2C_ENABLE: 1,
    KONASHI_I2C_ENABLE_100K: 1,
    KONASHI_I2C_ENABLE_400K: 2,
    KONASHI_I2C_STOP_CONDITION: 0,
    KONASHI_I2C_START_CONDITION: 1,
    KONASHI_I2C_RESTART_CONDITION: 2,

    // Konashi UART
    KONASHI_UART_DATA_MAX_LENGTH: 19,
    KONASHI_UART_DISABLE: 0,
    KONASHI_UART_ENABLE: 1,


    /***************************************************
     * properties
     ***************************************************/
    handlers: {},
    callbacks: {},
    messages: [],
    messageCount: 0,


    /***************************************************
     * public functions
     ***************************************************/
    on: function(eventName, handler){
      if (!this.handlers[eventName]){
        this.handlers[eventName] = [];
      }

      this.handlers[eventName].push(handler);
    },

    off: function(eventName, handlerOpt){
      if(!this.handlers[eventName]){
        return;
      }

      if(handlerOpt && typeof handlerOpt == "function" && this.handlers[eventName][handlerOpt]){
        delete this.handlers[eventName][handlerOpt];
      } else {
        delete this.handlers[eventName];
      }
    },

    trigger: function(eventName, dataOpt, callbackOpt){
      var messageId = this.messageCount++;
      var data = dataOpt || {};
      var callback = callbackOpt || function(){};

      // set callback
      this.callbacks[messageId] = function(data){
        callback(data);
        delete this.callbacks[messageId];
      };

      this.messages.push({
        eventName: eventName,
        messageId: messageId,
        data: data
      });

      if(this.messages.length==1){
        this.triggerToNative();
      }
    },

    triggerToNative: function(){
      var eventName = this.messages[0].eventName,
          messageId = this.messages[0].messageId,
          data = this.messages[0].data
      ;

      // send message
      var bridge = document.createElement("iframe");
      bridge.setAttribute("style", "display:none");
      bridge.setAttribute("height", "0px");
      bridge.setAttribute("width", "0px");
      bridge.setAttribute("frameborder", "0");
      document.documentElement.appendChild(bridge);
      bridge.src = this.KONASHI_URL_SCHEME + "://" + eventName + "/" + messageId + "?" + encodeURIComponent(JSON.stringify(data));

      this.messages.shift();
    },


    /***************************************************
     * Public wrap functions (Event handler)
     ***************************************************/
    centralManagerPoweredOn: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "centralManagerPoweredOn", function(){
          callback();
        });
      }
    },

    peripheralNotFound: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "peripheralNotFound", function(){
          callback();
        });
      }
    },

    connected: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "connected", function(){
          callback();
        });
      }
    },

    disconnected: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "disconnected", function(){
          callback();
        });
      }
    },

    ready: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "ready", function(){
          callback();
        });
      }
    },

    updatePioInput: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "updatePioInput", function(data){
          callback(data);
        });
      }
    },

    updateAnalogValue: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "updateAnalogValue", function(){
          callback();
        });
      }
    },

    updateAnalogValueAio0: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "updateAnalogValueAio0", function(data){
          callback(data);
        });
      }
    },

    updateAnalogValueAio1: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "updateAnalogValueAio1", function(data){
          callback(data);
        });
      }
    },

    updateAnalogValueAio2: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "updateAnalogValueAio2", function(data){
          callback(data);
        });
      }
    },

    completeReadI2c: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "completeReadI2c", function(){
          callback();
        });
      }
    },

    completeUartRx: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "completeUartRx", function(data){
          callback(data);
        });
      }
    },

    updateBatteryLevel: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "updateBatteryLevel", function(data){
          callback(data);
        });
      }
    },

    updateSignalStrength: function(callback){
      if(callback && typeof callback == "function"){
        this.on( "updateSignalStrength", function(data){
          callback(data);
        });
      }
    },

    /***************************************************
     * Public wrap functions (Control functinos)
     ***************************************************/
    // Base
    find: function(){
      k.trigger("find");
    },

    findWithName: function(name){
      k.trigger("findWithName", {name: name});
    },

    disconnect: function(){
      k.trigger("disconnect");
    },

    isConnected: function(callback){
      if(callback && typeof callback == "function"){
        k.trigger("isConnected", {}, function(isConnected){
          callback(isConnected);
        });
      }
    },

    peripheralName: function(callback){
      if(callback && typeof callback == "function"){
        k.trigger("peripheralName", {}, function(name){
          callback(name);
        });
      }
    },

    // Digital I/O
    pinMode: function(pin, mode){
      k.trigger("pinMode", {pin: pin, mode:mode});
    },

    pinModeAll: function(mode){
      k.trigger("pinModeAll", {mode:mode});
    },

    pinPullup: function(pin, mode){
      k.trigger("pinPullup", {pin: pin, mode:mode});
    },

    pinPullupAll: function(mode){
      k.trigger("pinPullupAll", {mode:mode});
    },

    digitalRead: function(pin, callback){
      if(callback && typeof callback == "function"){
        k.trigger("digitalRead", {pin: pin}, function(value){
          callback(value.input);
        });
      }
    },

    digitalReadAll: function(callback){
      if(callback && typeof callback == "function"){
        k.trigger("digitalReadAll", {}, function(value){
          callback(value.input);
        });
      }
    },

    digitalWrite: function(pin, value){
      k.trigger("digitalRead", {pin: pin, value: value});
    },

    digitalWriteAll: function(){
      k.trigger("digitalReadAll", {value: value});
    },


    /***************************************************
     * Public util functions
     ***************************************************/
    noConflict: function(){
      window.k = kBefore;
      return this;
    },


    /***************************************************
     * log functions
     ***************************************************/
    log: function(str){
      var debugConsole = document.getElementById("konashi-debug-console");
      if(debugConsole){
        var logStr = document.createElement("p");
        logStr.innerHTML = str;
        if(debugConsole.firstChild){
          debugConsole.insertBefore(logStr, debugConsole.firstChild);
        } else {
          debugConsole.appendChild(logStr);
        }
      }
    },

    showDebugLog: function(){
      var debugConsole = document.createElement("div");
      debugConsole.setAttribute("style",
        "position:fixed;left:0px;top:0px;z-index:100000;width:200px;height:100px;" +
        "background-color:rgba(0,0,0,0.6);color:#FFF;font-size:11px;overflow:hidden;"
      );
      debugConsole.setAttribute("id", "konashi-debug-console");
      document.documentElement.appendChild(debugConsole);
    },

    hideDebugLog: function(){
      var debugConsole = document.getElementById("konashi-debug-console");
      debugConsole.parentNode.removeChild(debugConsole);
    },


    /***************************************************
     * call from native functions
     ***************************************************/
    triggerFromNative: function(eventName, data){
      this.log("triggerFromNative eventname: " + eventName + ", data: " + JSON.stringify(data));

      var handlerList = this.handlers[eventName] || [];

      for (var i=0; i < handlerList.length; i++){
        var handler = handlerList[i];
        if(handler && typeof handler == "function"){
          setTimeout(function(){
            handler(data);
          }, 0);
        }
      }
    },

    triggerCallback: function(id, data) {
      var that = this;

      this.log("triggerCallback id: " + id + ", data: " + JSON.stringify(data));

      setTimeout(function() {
        try{
          that.callbacks[Number(id)](data);
        } catch(e){}

        if(this.messages.length>0){
          this.triggerToNative();
        }
      }, 0);
    }
  };

  var kBefore = window.k;
  window.k = konashi;
})();

