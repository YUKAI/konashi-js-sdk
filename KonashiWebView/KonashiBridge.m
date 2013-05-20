//
//  KonashiBridge.m
//  PioDrive
//

#import "KonashiBridge.h"
#import "Konashi.h"

@implementation KonashiBridge

- (id)initWithWebView:(KonashiWebView*)webview
{
    konashiWebView = webview;
    
    return self;
}

- (void)initializeKonashi
{
    KB_LOG(@"bridge: initializeKonashi");
    
    [self initialize];
}

- (void)disconnectKonashi
{
    [Konashi disconnect];
}


#pragma mark -
#pragma mark Konashi bridge methods

- (void)initialize
{
    [Konashi initialize];

    // konashi event handler
    [Konashi addObserver:self selector:@selector(jsKonashiConnected) name:KONASHI_EVENT_CONNECTED];
    [Konashi addObserver:self selector:@selector(jsKonashiDisconnected) name:KONASHI_EVENT_DISCONNECTED];
    [Konashi addObserver:self selector:@selector(jsKonashiReady) name:KONASHI_EVENT_READY];
    [Konashi addObserver:self selector:@selector(jsKonashiUpdatePioInput) name:KONASHI_EVENT_UPDATE_PIO_INPUT];
    [Konashi addObserver:self selector:@selector(jsKonashiUpdateAnalogValue) name:KONASHI_EVENT_UPDATE_ANALOG_VALUE];
    [Konashi addObserver:self selector:@selector(jsKonashiUpdateAnalogValueAio0) name:KONASHI_EVENT_UPDATE_ANALOG_VALUE_AIO0];
    [Konashi addObserver:self selector:@selector(jsKonashiUpdateAnalogValueAio1) name:KONASHI_EVENT_UPDATE_ANALOG_VALUE_AIO1];
    [Konashi addObserver:self selector:@selector(jsKonashiUpdateAnalogValueAio2) name:KONASHI_EVENT_UPDATE_ANALOG_VALUE_AIO2];
    [Konashi addObserver:self selector:@selector(jsKonashiCompleteReadI2c) name:KONASHI_EVENT_I2C_READ_COMPLETE];
    [Konashi addObserver:self selector:@selector(jsKonashiCompleteUartRx) name:KONASHI_EVENT_UART_RX_COMPLETE];
    [Konashi addObserver:self selector:@selector(jsKonashiUpdateBatteryLevel) name:KONASHI_EVENT_UPDATE_BATTERY_LEVEL];
    [Konashi addObserver:self selector:@selector(jsKonashiUpdateSignalStrength) name:KONASHI_EVENT_UPDATE_SIGNAL_STRENGTH];
    
    
    /****************************
     * Base
     ****************************/
    [konashiWebView on:@"find" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: find");
        
        int status = [Konashi find];
        NSDictionary *data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"findWithName" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: findWithName, %@", params);
        
        NSDictionary *data;
        
        // validation
        if(![params.allKeys containsObject:@"name"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        int status = [Konashi findWithName:[params objectForKey:@"name"]];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"disconnect" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: disconnect");
        
        int status = [Konashi disconnect];
        NSDictionary *data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"isConnected" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: isConnected");
        
        BOOL isConnected = [Konashi isConnected];
        NSDictionary *data = @{@"isConnected":[NSNumber numberWithBool:isConnected]};
        
        callback(data);
    }];
    
    
    /***************************
     * Digital I/O
     ***************************/
    [konashiWebView on:@"pinMode" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: pinMode, %@", params);
        
        NSDictionary *data;
        int pin, mode;
        
        // validation
        if(![params.allKeys containsObject:@"pin"] || ![params.allKeys containsObject:@"mode"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        pin = [[params objectForKey:@"pin"] intValue];
        mode = [[params objectForKey:@"mode"] intValue];
                
        int status = [Konashi pinMode:pin mode:mode];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"pinModeAll" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: pinModeAll, %@", params);
        
        NSDictionary *data;
        int mode;
        
        // validation
        if(![params.allKeys containsObject:@"mode"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        mode = [[params objectForKey:@"mode"] intValue];
        
        int status = [Konashi pinModeAll:mode];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"pinPullup" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: pinPullup, %@", params);
        
        NSDictionary *data;
        int pin, mode;
        
        // validation
        if(![params.allKeys containsObject:@"pin"] || ![params.allKeys containsObject:@"mode"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        pin = [[params objectForKey:@"pin"] intValue];
        mode = [[params objectForKey:@"mode"] intValue];
        
        int status = [Konashi pinPullup:pin mode:mode];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"pinPullupAll" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: pinPullupAll, %@", params);
        
        NSDictionary *data;
        int mode;
        
        // validation
        if(![params.allKeys containsObject:@"mode"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        mode = [[params objectForKey:@"mode"] intValue];
        
        int status = [Konashi pinPullupAll:mode];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"digitalRead" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: digitalRead, %@", params);
        
        NSDictionary *data;
        int pin;
        
        // validation
        if(![params.allKeys containsObject:@"pin"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        pin = [[params objectForKey:@"pin"] intValue];
        
        int input = [Konashi digitalRead:pin];
        data = @{@"pin":[NSNumber numberWithInteger:pin], @"input":[NSNumber numberWithInteger:input]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"digitalReadAll" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: digitalReadAll, %@", params);
        
        NSDictionary *data;
                
        int input = [Konashi digitalReadAll];
        data = @{@"input":[NSNumber numberWithInteger:input]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"digitalWrite" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: digitalWrite, %@", params);
        
        NSDictionary *data;
        int pin, value;
        
        // validation
        if(![params.allKeys containsObject:@"pin"] || ![params.allKeys containsObject:@"value"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        pin = [[params objectForKey:@"pin"] intValue];
        value = [[params objectForKey:@"value"] intValue];
        
        int status = [Konashi digitalWrite:pin value:value];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"digitalWriteAll" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: digitalWriteAll, %@", params);
        
        NSDictionary *data;
        int value;
        
        // validation
        if(![params.allKeys containsObject:@"value"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        value = [[params objectForKey:@"value"] intValue];
        
        int status = [Konashi digitalWriteAll:value];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    
    /***************************
     * Analog I/O
     ***************************/
    [konashiWebView on:@"analogReference" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: analogReference, %@", params);
        
        NSDictionary *data;
                
        int millivolt = [Konashi analogReference];
        data = @{@"value":[NSNumber numberWithInteger:millivolt]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"analogReadRequest" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: analogReadRequest, %@", params);
        
        NSDictionary *data;
        int pin;
        
        // validation
        if(![params.allKeys containsObject:@"pin"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        pin = [[params objectForKey:@"pin"] intValue];
        
        int status = [Konashi analogReadRequest:pin];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"analogRead" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: analogRead, %@", params);
        
        NSDictionary *data;
        int pin;
        
        // validation
        if(![params.allKeys containsObject:@"pin"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        pin = [[params objectForKey:@"pin"] intValue];
        
        int millivolt = [Konashi analogRead:pin];
        data = @{@"value":[NSNumber numberWithInteger:millivolt]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"analogWrite" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: analogWrite, %@", params);
        
        NSDictionary *data;
        int pin, millivolt;
        
        // validation
        if(![params.allKeys containsObject:@"pin"] || ![params.allKeys containsObject:@"millivolt"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        pin = [[params objectForKey:@"pin"] intValue];
        millivolt = [[params objectForKey:@"millivolt"] intValue];
        
        int status = [Konashi analogWrite:pin milliVolt:millivolt];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    
    /***************************
     * PWM
     ***************************/
    [konashiWebView on:@"pwmMode" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: pwmMode, %@", params);
        
        NSDictionary *data;
        int pin, mode;
        
        // validation
        if(![params.allKeys containsObject:@"pin"] || ![params.allKeys containsObject:@"mode"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        pin = [[params objectForKey:@"pin"] intValue];
        mode = [[params objectForKey:@"mode"] intValue];
        
        int status = [Konashi pwmMode:pin mode:mode];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"pwmPeriod" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: pwmPeriod, %@", params);
        
        NSDictionary *data;
        int pin;
        unsigned int period;
        
        // validation
        if(![params.allKeys containsObject:@"pin"] || ![params.allKeys containsObject:@"period"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        pin = [[params objectForKey:@"pin"] intValue];
        period = [[params objectForKey:@"period"] unsignedIntValue];
        
        int status = [Konashi pwmPeriod:pin period:period];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"pwmDuty" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: pwmDuty, %@", params);
        
        NSDictionary *data;
        int pin;
        unsigned int duty;
        
        // validation
        if(![params.allKeys containsObject:@"pin"] || ![params.allKeys containsObject:@"duty"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        pin = [[params objectForKey:@"pin"] intValue];
        duty = [[params objectForKey:@"duty"] unsignedIntValue];
        
        int status = [Konashi pwmDuty:pin duty:duty];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"pwmLedDrive" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: pwmLedDrive, %@", params);
        
        NSDictionary *data;
        int pin, dutyRatio;
        
        // validation
        if(![params.allKeys containsObject:@"pin"] || ![params.allKeys containsObject:@"dutyRatio"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
                
        pin = [[params objectForKey:@"pin"] intValue];
        dutyRatio = [[params objectForKey:@"dutyRatio"] intValue];
        
        int status = [Konashi pwmLedDrive:pin dutyRatio:dutyRatio];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    
    /***************************
     * UART
     ***************************/
    [konashiWebView on:@"uartMode" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: uartMode, %@", params);
        
        NSDictionary *data;
        int mode;
        
        // validation
        if(![params.allKeys containsObject:@"mode"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        mode = [[params objectForKey:@"mode"] intValue];
        
        int status = [Konashi uartMode:mode];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"uartBaudrate" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: uartBaudrate, %@", params);
        
        NSDictionary *data;
        int baudrate;
        
        // validation
        if(![params.allKeys containsObject:@"baudrate"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        baudrate = [[params objectForKey:@"baudrate"] intValue];
        
        int status = [Konashi uartBaudrate:baudrate];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"uartWrite" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: uartWrite, %@", params);
        
        NSDictionary *data;
        unsigned char value;
        
        // validation
        if(![params.allKeys containsObject:@"data"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        value = [[params objectForKey:@"data"] unsignedCharValue];
        
        int status = [Konashi uartWrite:value];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    
    /***************************
     * I2C
     ***************************/
    [konashiWebView on:@"i2cMode" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: i2cMode, %@", params);
        
        NSDictionary *data;
        int mode;
        
        // validation
        if(![params.allKeys containsObject:@"mode"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        mode = [[params objectForKey:@"mode"] intValue];
        
        int status = [Konashi i2cMode:mode];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"i2cStartCondition" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: i2cStartCondition, %@", params);
        
        NSDictionary *data;
        
        int status = [Konashi i2cStartCondition];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"i2cRestartCondition" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: i2cRestartCondition, %@", params);
        
        NSDictionary *data;
        
        int status = [Konashi i2cRestartCondition];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"i2cStopCondition" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: i2cStopCondition, %@", params);
        
        NSDictionary *data;
        
        int status = [Konashi i2cStopCondition];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"i2cWrite" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: i2cWrite, %@", params);
        
        NSDictionary *d;
        int length;
        unsigned char data;
        unsigned char address;
        
        // validation
        if(![params.allKeys containsObject:@"length"] || ![params.allKeys containsObject:@"data"] || ![params.allKeys containsObject:@"address"]){
            d = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(d);
            return;
        }
        
        length = [[params objectForKey:@"length"] intValue];
        data = [[params objectForKey:@"data"] unsignedCharValue];
        address = [[params objectForKey:@"address"] unsignedCharValue];
        
        int status = [Konashi i2cWrite:length data:&data address:address];
        d = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(d);
    }];
    
    [konashiWebView on:@"i2cReadRequest" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: i2cReadRequest, %@", params);
        
        NSDictionary *data;
        int length;
        unsigned char address;
        
        // validation
        if(![params.allKeys containsObject:@"length"] || ![params.allKeys containsObject:@"address"]){
            data = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(data);
            return;
        }
        
        length = [[params objectForKey:@"length"] intValue];
        address = [[params objectForKey:@"address"] unsignedCharValue];
        
        int status = [Konashi i2cReadRequest:length address:address];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"i2cRead" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: i2cRead, %@", params);
        
        NSDictionary *d;
        NSMutableArray *jsonData;
        int length;
        unsigned char data[20];
        int status;
        
        // validation
        if(![params.allKeys containsObject:@"length"]){
            d = @{@"status":[NSNumber numberWithInteger:KONASHI_FAILURE]};
            callback(d);
            return;
        }
        
        length = [[params objectForKey:@"length"] intValue];
        
        status = [Konashi i2cRead:length data:data];
        
        for(int i=0; i<length;i++){
            [jsonData addObject:[NSNumber numberWithInt:data[i]]];
        }
        d = @{@"status": [NSNumber numberWithInt:status], @"value":jsonData};
        
        callback(d);
    }];
    
    
    /***************************
     * Hardware control
     ***************************/
    [konashiWebView on:@"reset" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: reset, %@", params);
        
        NSDictionary *data;
        
        int status = [Konashi reset];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"batteryLevelReadRequest" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: batteryLevelReadRequest, %@", params);
        
        NSDictionary *data;
        
        int status = [Konashi batteryLevelReadRequest];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"batteryLevelRead" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: batteryLevelRead, %@", params);
        
        NSDictionary *d;
        int batteryLevel;
                
        batteryLevel = [Konashi batteryLevelRead];

        d = @{@"value":[NSNumber numberWithInteger:batteryLevel]};
        
        callback(d);
    }];
    
    [konashiWebView on:@"signalStrengthReadRequest" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: signalStrengthReadRequest, %@", params);
        
        NSDictionary *data;
        
        int status = [Konashi signalStrengthReadRequest];
        data = @{@"status":[NSNumber numberWithInteger:status]};
        
        callback(data);
    }];
    
    [konashiWebView on:@"signalStrengthRead" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        KB_LOG(@"bridge: signalStrengthRead, %@", params);
        
        NSDictionary *d;
        int value;
        
        value = [Konashi signalStrengthRead];
        
        d = @{@"value":[NSNumber numberWithInteger:value]};
        
        callback(d);
    }];
}


#pragma mark -
#pragma mark Konashi event handler methods

- (void)jsKonashiConnected
{
    KB_LOG(@"bridge: jsKonashiConnected");
    [konashiWebView send:@"connected" withParams:nil];
}

- (void)jsKonashiDisconnected
{
    KB_LOG(@"bridge: jsKonashiDisconnected");
    [konashiWebView send:@"disconnected" withParams:nil];
}

- (void)jsKonashiReady
{
    KB_LOG(@"bridge: jsKonashiReady");
    
    [NSTimer
        scheduledTimerWithTimeInterval:0.3f
        target:self
        selector:@selector(konashiReady:)
        userInfo:nil
        repeats:NO
    ];
}

-(void)konashiReady:(NSTimer*)timer
{
    [konashiWebView send:@"ready" withParams:nil];
}

- (void)jsKonashiUpdatePioInput
{
    KB_LOG(@"bridge: jsKonashiUpdatePioInput");
    
    NSDictionary *data = @{@"value":[NSNumber numberWithInteger:[Konashi digitalReadAll]]};;

    [konashiWebView send:@"updatePioInput" withParams:data];
}

- (void)jsKonashiUpdateAnalogValue
{
    KB_LOG(@"bridge: jsKonashiUpdateAnalogValue");
    
    [konashiWebView send:@"updateAnalogValue" withParams:nil];
}

- (void)jsKonashiUpdateAnalogValueAio0
{
    KB_LOG(@"bridge: jsKonashiUpdateAnalogValueAio0");
    
    NSDictionary *data = @{@"pin": [NSNumber numberWithInt:0], @"value":[NSNumber numberWithInteger:[Konashi analogRead:0]]};;

    [konashiWebView send:@"updateAnalogValueAio0" withParams:data];

}

- (void)jsKonashiUpdateAnalogValueAio1
{
    KB_LOG(@"bridge: jsKonashiUpdateAnalogValueAio1");
    
    NSDictionary *data = @{@"pin": [NSNumber numberWithInt:1], @"value":[NSNumber numberWithInteger:[Konashi analogRead:1]]};;
    
    [konashiWebView send:@"updateAnalogValueAio1" withParams:data];

}

- (void)jsKonashiUpdateAnalogValueAio2
{
    KB_LOG(@"bridge: jsKonashiUpdateAnalogValueAio2");

    NSDictionary *data = @{@"pin": [NSNumber numberWithInt:2], @"value":[NSNumber numberWithInteger:[Konashi analogRead:2]]};;

    [konashiWebView send:@"updateAnalogValueAio2" withParams:data];
}

- (void)jsKonashiCompleteReadI2c
{
    KB_LOG(@"bridge: jsKonashiCompleteReadI2c");

    [konashiWebView send:@"completeReadI2c" withParams:nil];
}

- (void)jsKonashiCompleteUartRx
{
    KB_LOG(@"bridge: jsKonashiCompleteUartRx");
    
    NSDictionary *data = @{@"value":[NSNumber numberWithInteger:[Konashi uartRead]]};;
    
    [konashiWebView send:@"completeUartRx" withParams:data];

}

- (void)jsKonashiUpdateBatteryLevel
{
    KB_LOG(@"bridge: jsKonashiUpdateBatteryLevel");

    NSDictionary *data = @{@"value":[NSNumber numberWithInteger:[Konashi batteryLevelRead]]};;
    
    [konashiWebView send:@"updateBatteryLevel" withParams:data];
}

- (void)jsKonashiUpdateSignalStrength
{
    KB_LOG(@"bridge: jsKonashiUpdateSignalStrength");

    NSDictionary *data = @{@"value":[NSNumber numberWithInteger:[Konashi signalStrengthRead]]};;
    
    [konashiWebView send:@"updateSignalStrength" withParams:data];
}


@end
