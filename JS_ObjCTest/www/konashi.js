var konashi={
	find:		function(option,callback){
				return callNativeMethod("find",option,callback);
			},
	findWithName:	function(option,callback){
				return callNativeMethod("findWithName",option,callback);
			},
	disconnect:     function(option){
				callNativeMethod("disconnect",option);
			},
	isConnected:	function(option,callback){
				return callNativeMethod("isConnected",option,callback);
			},
	isReady:	function(option,callback){
				return callNativeMethod("isReady",option,callback);
			},
	pinMode:       function(option,callback){
			       return callNativeMethod("pinMode",option,callback);
		       },
	pinModeAll:    function(option,callback){
			       return callNativeMethod("pinMode",option,callback);
		       },
	pinPullup:     function(option,callback){
			       return callNativeMethod("pinPullup",option,callback);
		       },
	pinPullupAll:  function(option,callback){
			       return callNativeMethod("pinPullupAll",option,callback);
		       },
	digitalRead:   function(option,callback){
			       return callNativeMethod("digitalRead",option,callback);
		       },
	digitalReadAll:function(option,callback){
			       return callNativeMethod("digitalReadAll",option,callback);
		       },
	digitalWrite:  function(option,callback){
			       return callNativeMethod("digitalWrite",option,callback);
		       },
	digitalWriteAll:function(option,callback){
				return callNativeMethod("digitalWriteAll",option,callback);
			},
	pwmMode:       function(option,callback){
			       return callNativeMethod("pwmMode",option,callback);
		       },
	pwmPeriod:     function(option,callback){
			       return callNativeMethod("pwmPeriod",option,callback);
		       },
	pwmDuty:       function(option,callback){
			       return callNativeMethod("pwmDuty",option,callback);
		       },
	pwmLedDrive:   function(option,callback){
			       return callNativeMethod("pwmLedDrive",option,callback);
		       },
	analogReference:function(option,callback){
				return callNativeMethod("analogReference",option,callback);
			},
	analogReadRequest:function(option,callback){
				  return callNativeMethod("analogReadRequest",option,callback);
			  },
	analogRead:    function(option,callback){
			       return callNativeMethod("analogRead",option,callback);
		       },
	analogGet:     function(option,callback){
			       return callNativeMethod("analogGet",option,callback);
		       },
	analogWrite:   function(option,callback){
			       return callNativeMethod("analogWrite",option,callback);
		       },
	i2cMode:       function(option,callback){
			       return callNativeMethod("i2cMode",option,callback);
		       },
	i2cStartCondition:function(option,callback){
				  return callNativeMethod("i2cStartCondition",option,callback);
			  },
	i2cRestartCondition:function(option,callback){
				    return callNativeMethod("i2cRestartCondition",option,callback);
			    },
	i2cStopCondition:function(option,callback){
				 return callNativeMethod("i2cStopCondition",option,callback);
			 },
	i2cWrite:      function(option,callback){
			       return callNativeMethod("i2cWrite",option,callback);
		       },
	i2cReadRequest:function(option,callback){
			       return callNativeMethod("i2cReadRequest",option,callback);
		       },
	i2cRead:       function(option,callback){
			       return callNativeMethod("i2cRead",option,callback);
		       },
	i2cGet:        function(option,callback){
			       return callNativeMethod("i2cGet",option,callback);
		       },
	uartMode:      function(option,callback){
			       return callNativeMethod("uartMode",option,callback);
		       },
	uartBaudrate:  function(option,callback){
			       return callNativeMethod("uartBaudrate",option,callback);
		       },
	uartWrite:     function(option,callback){
			       return callNativeMethod("uartWrite",option,callback);
		       },
	uartRead:	function(option,callback){
				return callNativeMethod("uartRead",option,callback);
			},
	reset:          function(option){
				callNativeMethod("reset",option);
			},
	batteryLevelReadRequest:function(option,callback){
					return callNativeMethod("batteryLevelReadRequest",option,callback);
				},
	batteryLevelRead:function(option,callback){
				 return callNativeMethod("batteryLevelRead",option,callback);
			 },
	batteryLevelGet:function(option,callback){
				return callNativeMethod("batteryLevelGet",option,callback);
			},
	signalStrengthReadRequest:function(option,callback){
					  callNativeMethod("signalStrengthReadRequest",option,callback);
				  },
	signalStrengthRead:function(option,callback){
				   return callNativeMethod("signalStrengthRead",option,callback);
			   },
	signalStrengthGet:function(option,callback){
				  return callNativeMethod("signalStrengthGet",option,callback);
			  },
	findW:          function(){
				return this.find();
			},
	findWithNameW:	function(name){
				return this.findWithName({"name":name});
			},
	isConnectedW:	function(){
				return this.isConnected();
			},
	isReadyW:	function(){
				return this.isReady();
			},
	pinModeW:       function(pin,mode){
				return this.pinMode({"pin":pin,"mode":mode});
			},
	pinModeAllW:    function(mode){
				return this.pinModeAll({"mode":mode});
			},
	pinPullupW:     function(pin,mode){
				return this.pinPullup({"pin":pin,"mode":mode});
			},
	pinPullupAllW:  function(mode){
				return this.pinPullupAll({"mode":mode});
			},
	digitalReadW:   function(pin){
				return this.digitalRead({"pin":pin});
			},
	digitalReadAllW:function(){
				return this.digitalReadAll({});
			},
	digitalWriteW:  function(pin,value){
				return this.digitalWrite({"pin":pin,"value":value});
			},
	digitalWriteAllW:function(value){
				 return this.digitalWriteAll({"value":value});
			 },
	pwmModeW:       function(pin,mode){
				return this.pwmMode({"pin":pin,"mode":mode});
			},
	pwmPeriodW:     function(pin,period){
				return this.pwmPeriod({"pin":pin,"period":period});
			},
	pwmDutyW:       function(pin,duty){
				return this.pwmDuty({"pin":pin,"duty":duty});
			},
	pwmLedDriveW:   function(pin,ratio){
				return this.pwmLedDrive({"pin":pin,"ratio":ratio});
			},
	analogReferenceW:function(){
				 return this.analogReference({});
			 },
	analogReadRequestW:function(pin){
				   return this.analogReadRequest({"pin":pin});
			   },
	analogReadW:    function(pin){
				return this.analogRead({"pin":pin});
			},
	analogGetW:     function(pin){
				return this.analogGet({"pin":pin});
			},
	analogWriteW:   function(pin,milliVolt){
				return this.analogWrite({"pin":pin,"milliVolt":milliVolt});
			},
	i2cModeW:       function(mode){
				return this.i2cMode({"mode":mode});
			},
	i2cStartConditionW:function(){
				   return this.i2cStartCondition({});
			   },
	i2cRestartConditionW:function(){
				     return this.i2cRestartCondition({});
			     },
	i2cStopConditionW:function(){
				  return this.i2cStopCondition({});
			  },
	i2cWriteW:      function(length,data,address){
				return this.i2cWrite({"length":length,"data":data,"address":address});
			},
	i2cReadRequestW:function(length,address){
				return this.i2cReadRequest({"length":length,"address":address});
			},
	i2cReadW:       function(length){
				return this.i2cRead({"length":length});
			},
	i2cGetW:        function(length,address){
				return this.i2cGet({"length":length,"address":address});
			},
	uartModeW:      function(mode){
				return this.uartMode({"mode":mode});
			},
	uartBaudrateW:  function(baudrate){
				return this.uartBaudrate({"baudrate":baudrate});
			},
	uartWriteW:     function(data){
				return this.uartWrite({"data":data});
			},
	uartReadW:	function(){
				return this.uartRead();
			},
	batteryLevelReadRequestW:function(){
					 return this.batteryLevelReadRequest({});
				 },
	batteryLevelReadW:function(){
				  return this.batteryLevelRead({});
			  },
	batteryLevelGetW:function(){
				 return this.batteryLevelGet({});
			 },
	signalStrengthReadRequestW:function(){
					   this.signalStrengthReadRequest({});
				   },
	signalStrengthReadW:function(){
				    return this.signalStrengthRead({});
			    },
	signalStrengthGetW:function(){
				   return this.signalStrengthGet({});
			   },
	onConnected:undefined,
	onReady:undefined,
	onPioChanged:undefined,
	onAioReady:undefined,
	onI2cReady:undefined,
	onUartRx:function(){
		konashi.uartRead({},function(response){
			konashi.uartRxBuf+=response;
		});
	},
	onBatteryReady:undefined,
	onSignalReady:undefined,
	bind:		function(type,fn){
		return this.on(type,fn);
	},
	on:		function(type,fn){
				if(typeof fn !='function'){
					fn=undefined;
				}
				this[type]=fn;
				return fn;
			},
	unbind:		function(type){
				this.off(type);
			},
	off:		function(type){
				this[type]=undefined;
			},
	uartRxBuf:"",
	HIGH:1,
	LOW:0,
	OUTPUT:1,
	INPUT:0,
	PULLUP:1,
	NO_PULLS:0,
	ENABLE:1,
	DISABLE:0,
	SUCCESS:0,
	FAILURE:-1,
	PIO0:0,
	PIO1:1,
	PIO2:2,
	PIO3:3,
	PIO4:4,
	PIO5:5,
	PIO6:6,
	PIO7:7,
	S1:0,
	LED2:1,
	LED3:2,
	LED4:3,
	LED5:4,
	AIO0:0,
	AIO1:1,
	AIO2:2,
	I2C_SDA:6,
	I2C_SCL:7,
	PWM_DISABLE:0,
	PWM_ENABLE:1,
	PWM_ENABLE_LED_MODE:2,
	BAUD_2K4:0x000a,
	BAUD_9K6:0x0028,
    /*
	BAUD_19K2:0x004e,
	BAUD_38K4:0x009e,
	BAUD_57K6:0x00eb,
	BAUD_115K2:0x01d9,
	BAUD_230K4:0x03af,
	BAUD_460K8:0x0760,
	BAUD_921K6:0x0ebf,
	BAUD_1382K4:0x161f,
	BAUD_1843K2:0x1d7e,
	BAUD_2764K8:0x2c3d,
	BAUD_3686K4:0x3afc,
     */
	I2C_DISABLE:0,
	I2C_ENABLE:1,
	I2C_ENABLE_100K:1,
	I2C_ENABLE_400K:2,
	UART_DISABLE:0,
	UART_ENABLE:1,
}

function callNativeMethod(name,option,callback){
    for(var key in option){
        option[key]=String(option[key]);
    }
	if(callback===undefined){
		console.log("sync mode");
		if(option===undefined) option={};
		return $.ajax({
			url:"konashi://" + name,
			data:$.param(option),
			type:"GET",
			processData:false,
			async:false,
			cache:false
		}).responseText;
	} else {
		console.log("async mode");
		$.ajax({
			url:"konashi://" + name,
			data:$.param(option),
			type:"GET",
			processData:false,
			async:true,
			cache:false,
			success:callback
		});
		return null;
	}
}

jQuery(function($){
	konashi.on("onConnected",function(){console.log("Connected");});
	konashi.on("onReady",function(){console.log("Ready");});
	konashi.on("onPioChanged",function(io){console.log("PioChanged:"+io);});
});
