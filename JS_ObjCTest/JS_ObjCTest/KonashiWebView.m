//
//  KonashiWebView.m
//  JS_ObjCTest
//
//  Created by Yuichi Tadokoro on 12/12/29.
//  Copyright (c) 2012年 YUKAI Engineering. All rights reserved.
//

#import "KonashiWebView.h"

@implementation KonashiWebView

bool readWaitFlag=false;

-(id)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        self.delegate=self;
    }
    [NSURLProtocol registerClass:[KonashiProtocol class]];
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(invokeJSKonashiMethod:) name:@"invokeJSKonashiMethod" object:nil];
    
    [Konashi initialize];
    [Konashi addObserver:self selector:@selector(jsKonashiConnected) name:KONASHI_EVENT_CONNECTED];
    [Konashi addObserver:self selector:@selector(jsKonashiReady) name:KONASHI_EVENT_READY];
    [Konashi addObserver:self selector:@selector(jsKonashiUpdatePioInput) name:KONASHI_EVENT_UPDATE_PIO_INPUT];
    [Konashi addObserver:self selector:@selector(jsKonashiReadAio) name:KONASHI_EVENT_UPDATE_ANALOG_VALUE];
    [Konashi addObserver:self selector:@selector(jsKonashiReadAio0) name:KONASHI_EVENT_UPDATE_ANALOG_VALUE_AIO0];
    [Konashi addObserver:self selector:@selector(jsKonashiReadAio1) name:KONASHI_EVENT_UPDATE_ANALOG_VALUE_AIO1];
    [Konashi addObserver:self selector:@selector(jsKonashiReadAio2) name:KONASHI_EVENT_UPDATE_ANALOG_VALUE_AIO2];
    [Konashi addObserver:self selector:@selector(jsKonashiReadI2c) name:KONASHI_EVENT_I2C_READ_COMPLETE];
    [Konashi addObserver:self selector:@selector(jsKonashiUartRx) name:KONASHI_EVENT_UART_RX_COMPLETE];
    [Konashi addObserver:self selector:@selector(jsKonashiReadBattery) name:KONASHI_EVENT_UPDATE_BATTERY_LEVEL];
    [Konashi addObserver:self selector:@selector(jsKonashiReadSignal) name:KONASHI_EVENT_UPDATE_SIGNAL_STRENGTH];
    
    return self;
}

-(void)dealloc{
    [NSURLProtocol unregisterClass:[KonashiProtocol class]];
}

- (void)invokeJSKonashiMethod:(NSNotification *)notification{
    KonashiProtocol *protocol=notification.object;
    NSURLRequest *request=protocol.request;
    
    NSString *funcName=request.URL.host;
    NSDictionary *vars=[self parseQuery:request.URL];
    
    if([funcName isEqualToString:@"find"]){
        [protocol sendResponse:[self jsFind]];
    } else if([funcName isEqualToString:@"findWithName"]){
        [protocol sendResponse:[self jsFindWithName:vars]];
    } else if([funcName isEqualToString:@"disconnect"]){
        [protocol sendResponse:[self jsDisconnect]];
    } else if([funcName isEqualToString:@"isConnected"]){
        [protocol sendResponse:[self jsIsConnected]];
    } else if([funcName isEqualToString:@"isReady"]){
        [protocol sendResponse:[self jsIsReady]];
    } else if([funcName isEqualToString:@"pinMode"]){
        [protocol sendResponse:[self jsPinMode:vars]];
    } else if([funcName isEqualToString:@"pinModeAll"]){
        [protocol sendResponse:[self jsPinModeAll:vars]];
    } else if([funcName isEqualToString:@"pinPullup"]){
        [protocol sendResponse:[self jsPinPullup:vars]];
    } else if([funcName isEqualToString:@"pinPullupAll"]){
        [protocol sendResponse:[self jsPinPullupAll:vars]];
    } else if([funcName isEqualToString:@"digitalRead"]){
        [protocol sendResponse:[self jsDigitalRead:vars]];
    } else if([funcName isEqualToString:@"digitalReadAll"]){
        [protocol sendResponse:[self jsDigitalReadAll:vars]];
    } else if([funcName isEqualToString:@"digitalWrite"]){
        [protocol sendResponse:[self jsDigitalWrite:vars]];
    } else if([funcName isEqualToString:@"digitalWriteAll"]){
        [protocol sendResponse:[self jsDigitalWriteAll:vars]];
    } else if([funcName isEqualToString:@"pwmMode"]){
        [protocol sendResponse:[self jsPwmMode:vars]];
    } else if([funcName isEqualToString:@"pwmPeriod"]){
        [protocol sendResponse:[self jsPwmPeriod:vars]];
    } else if([funcName isEqualToString:@"pwmDuty"]){
        [protocol sendResponse:[self jsPwmDuty:vars]];
    } else if([funcName isEqualToString:@"pwmLedDrive"]){
        [protocol sendResponse:[self jsPwmLedDrive:vars]];
    } else if([funcName isEqualToString:@"analogReference"]){
        [protocol sendResponse:[self jsAnalogReference]];
    } else if([funcName isEqualToString:@"analogReadRequest"]){
        [protocol sendResponse:[self jsAnalogReadRequest:vars]];
    } else if([funcName isEqualToString:@"analogRead"]){
        [protocol sendResponse:[self jsAnalogRead:vars]];
    } else if([funcName isEqualToString:@"analogGet"]){
        [protocol sendResponse:[self jsAnalogGet:vars]];
    } else if([funcName isEqualToString:@"analogWrite"]){
        [protocol sendResponse:[self jsAnalogWrite:vars]];
    } else if([funcName isEqualToString:@"i2cMode"]){
        [protocol sendResponse:[self jsI2cMode:vars]];
    } else if([funcName isEqualToString:@"i2cStartCondition"]){
        [protocol sendResponse:[self jsI2cStartCondition]];
    } else if([funcName isEqualToString:@"i2cRestartCondition"]){
        [protocol sendResponse:[self jsI2cRestartCondition]];
    } else if([funcName isEqualToString:@"i2cStopCondition"]){
        [protocol sendResponse:[self jsI2cStopCondition]];
    } else if([funcName isEqualToString:@"i2cWrite"]){
        [protocol sendResponse:[self jsI2cWrite:vars]];
    } else if([funcName isEqualToString:@"i2cReadRequest"]){
        [protocol sendResponse:[self jsI2cReadRequest:vars]];
    } else if([funcName isEqualToString:@"i2cRead"]){
        [protocol sendResponse:[self jsI2cRead:vars]];
    } else if([funcName isEqualToString:@"i2cGet"]){
        [protocol sendResponse:[self jsI2cGet:vars]];
    } else if([funcName isEqualToString:@"uartMode"]){
        [protocol sendResponse:[self jsUartMode:vars]];
    } else if([funcName isEqualToString:@"uartBaudrate"]){
        [protocol sendResponse:[self jsUartBaudrate:vars]];
    } else if([funcName isEqualToString:@"uartWrite"]){
        [protocol sendResponse:[self jsUartWrite:vars]];
    } else if([funcName isEqualToString:@"uartRead"]){
        [protocol sendResponse:[self jsUartRead]];
    } else if([funcName isEqualToString:@"reset"]){
        [protocol sendResponse:[self jsReset]];
    } else if([funcName isEqualToString:@"batteryLevelReadRequest"]){
        [protocol sendResponse:[self jsBatteryLevelReadRequest]];
    } else if([funcName isEqualToString:@"batteryLevelRead"]) {
        [protocol sendResponse:[self jsBatteryLevelRead]];
    } else if([funcName isEqualToString:@"batteryLevelGet"]){
        [protocol sendResponse:[self jsBatteryLevelGet]];
    } else if([funcName isEqualToString:@"signalStrengthReadRequest"]){
        [protocol sendResponse:[self jsSignalStrengthReadRequest]];
    } else if([funcName isEqualToString:@"signalStrengthRead"]){
        [protocol sendResponse:[self jsSignalStrengthRead]];
    } else if([funcName isEqualToString:@"signalStrengthGet"]){
        [protocol sendResponse:[self jsSignalStrengthGet]];
    }
}

- (NSString *)makeJSArray:(int)length data:(unsigned char *)data{
    NSString *str=@"[";
    for(int i=0;i<length-1;i++){
        str=[str stringByAppendingFormat:@"%d,",data[i]];
    }
    return [str stringByAppendingFormat:@"%d]",data[length-1]];
}

- (NSData *)parseJSArray:(int)length str:(NSString *)str{
    Byte bytes[length];
    NSArray *array=[str componentsSeparatedByString:@"%2C"];
    for(int i=0;i<length;i++){
        bytes[i]=[[array objectAtIndex:i] integerValue];
    }
    return [NSData dataWithBytes:bytes length:length];
}

- (NSMutableDictionary *)parseQuery:(NSURL *)url{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *param in [url.query componentsSeparatedByString:@"&"]) {
        NSLog(@"JSParam: %@",param);
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts objectAtIndex:1] forKey:[elts objectAtIndex:0]];
    }
    return params;
}

/* JSKonashi Functions */

- (NSString *)jsFind{
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi find]];
}

- (NSString *)jsFindWithName:(NSDictionary *)vars{
    NSString *name=[[vars valueForKey:@"name"] stringValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi findWithName:name]];
}

- (NSString *)jsDisconnect{
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi disconnect]];
}

- (NSString *)jsIsConnected{
    return [NSString stringWithFormat:@"{\"data\":%d}",[Konashi isConnected]];
}

- (NSString *)jsIsReady{
    return [NSString stringWithFormat:@"{\"data\":%d}",[Konashi isReady]];
}

- (NSString *)jsPinMode:(NSDictionary *)vars{
    int pin=[[vars valueForKey:@"pin"] integerValue];
    int mode=[[vars valueForKey:@"mode"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi pinMode:pin mode:mode]];
}

- (NSString *)jsPinModeAll:(NSDictionary *)vars{
    int mode=[[vars valueForKey:@"mode"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi pinModeAll:mode]];
}

- (NSString *)jsPinPullup:(NSDictionary *)vars{
    int pin=[[vars valueForKey:@"pin"] integerValue];
    int mode=[[vars valueForKey:@"mode"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi pinPullup:pin mode:mode]];
}

- (NSString *)jsPinPullupAll:(NSDictionary *)vars{
    int mode=[[vars valueForKey:@"mode"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi pinPullupAll:mode]];
}

- (NSString *)jsDigitalRead:(NSDictionary *)vars{
    int pin=[[vars valueForKey:@"pin"] integerValue];
    return [NSString stringWithFormat:@"{\"data\":%d}",[Konashi digitalRead:pin]];
}

- (NSString *)jsDigitalReadAll:(NSDictionary *)vars{
    return [NSString stringWithFormat:@"{\"data\":%d}",[Konashi digitalReadAll]];
}

- (NSString *)jsDigitalWrite:(NSDictionary *)vars{
    int pin=[[vars valueForKey:@"pin"] integerValue];
    int value=[[vars valueForKey:@"value"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi digitalWrite:pin value:value]];
}

- (NSString *)jsDigitalWriteAll:(NSDictionary *)vars{
    int value=[[vars valueForKey:@"value"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi digitalWriteAll:value]];
}

- (NSString *)jsPwmMode:(NSDictionary *)vars{
    int pin=[[vars valueForKey:@"pin"] integerValue];
    int mode=[[vars valueForKey:@"mode"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi pwmMode:pin mode:mode]];
}

- (NSString *)jsPwmPeriod:(NSDictionary *)vars{
    int pin=[[vars valueForKey:@"pin"] integerValue];
    unsigned int period=[[vars valueForKey:@"period"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi pwmPeriod:pin period:period]];
}

- (NSString *)jsPwmDuty:(NSDictionary *)vars{
    int pin=[[vars valueForKey:@"pin"] integerValue];
    unsigned int duty=[[vars valueForKey:@"duty"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi pwmDuty:pin duty:duty]];
}

- (NSString *)jsPwmLedDrive:(NSDictionary *)vars{
    int pin=[[vars valueForKey:@"pin"] integerValue];
    int ratio=[[vars valueForKey:@"ratio"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi pwmLedDrive:pin dutyRatio:ratio]];
}

- (NSString *)jsAnalogReference{
    return [NSString stringWithFormat:@"{\"data\":%d}",[Konashi analogReference]];
}

- (NSString *)jsAnalogReadRequest:(NSDictionary *)vars{
    int pin=[[vars valueForKey:@"pin"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi analogReadRequest:pin]];
}

- (NSString *)jsAnalogRead:(NSDictionary *)vars{
    int pin=[[vars valueForKey:@"pin"] integerValue];
    int value=[Konashi analogRead:pin];
    return [NSString stringWithFormat:@"{\"data\":%d,\"status\":%d}",
            value,(value==KONASHI_FAILURE)?KONASHI_FAILURE:KONASHI_SUCCESS];
}

- (NSString *)jsAnalogGet:(NSDictionary *)vars{
    int pin=[[vars valueForKey:@"pin"] integerValue];
    [Konashi analogReadRequest:pin];
    readWaitFlag=true;
    while(readWaitFlag);
    return [NSString stringWithFormat:@"{\"data\":%d}",[Konashi analogRead:pin]];
}

- (NSString *)jsAnalogWrite:(NSDictionary *)vars{
    int pin=[[vars valueForKey:@"pin"] integerValue];
    int milliVolt=[[vars valueForKey:@"milliVolt"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi analogWrite:pin milliVolt:milliVolt]];
}

- (NSString *)jsI2cMode:(NSDictionary *)vars{
    int mode=[[vars valueForKey:@"mode"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi i2cMode:mode]];
}

- (NSString *)jsI2cStartCondition{
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi i2cStartCondition]];
}

- (NSString *)jsI2cRestartCondition{
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi i2cRestartCondition]];
}

- (NSString *)jsI2cStopCondition{
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi i2cStopCondition]];
}

- (NSString *)jsI2cWrite:(NSDictionary *)vars{
    int length=[[vars valueForKey:@"length"] integerValue];
    unsigned char address=[[vars valueForKey:@"address"] integerValue];
    NSData *data=[self parseJSArray:length str:[vars valueForKey:@"data"]];
    NSLog(@"Data: %@",data);
    if(!data) return @"{\"status\":-1}";
    return [NSString stringWithFormat:@"{\"status\":%d}",
            [Konashi i2cWrite:length data:(unsigned char*)[data bytes] address:address]];
}

- (NSString *)jsI2cReadRequest:(NSDictionary *)vars{
    int length=[[vars valueForKey:@"length"] integerValue];
    unsigned char address=[[vars valueForKey:@"address"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi i2cReadRequest:length address:address]];
}

- (NSString*)jsI2cRead:(NSDictionary *)vars{
    int length=[[vars valueForKey:@"length"] integerValue];
    unsigned char data[length];
    if([Konashi i2cRead:length data:data]==KONASHI_FAILURE) return @"{\"status\":-1}";
    NSString *response=[NSString stringWithFormat:@"{\"data\":%@}",[self makeJSArray:length data:data]];
    return response;
}

- (NSString*)jsI2cGet:(NSDictionary *)vars{
    if([self jsI2cReadRequest:vars]) return @"{\"status\":-1}";
    readWaitFlag=true;
    while(readWaitFlag);
    return [self jsI2cRead:vars];
}

- (NSString *)jsUartMode:(NSDictionary *)vars{
    int mode=[[vars valueForKey:@"mode"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi uartMode:mode]];
}

- (NSString *)jsUartBaudrate:(NSDictionary *)vars{
    int baudrate=[[vars valueForKey:@"baudrate"] integerValue];
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi uartBaudrate:baudrate]];
}

- (NSString *)jsUartWrite:(NSDictionary *)vars{
    NSString *data=[vars valueForKey:@"data"];
    unsigned char *datainchr=(unsigned char*)[data UTF8String];
    if(!data) return @"{\"status\":-1}";
    for(int i=0;i<strlen((const char*)datainchr);i++){
        if([Konashi uartWrite:datainchr[i]]==KONASHI_FAILURE)
            return @"{\"status\":-1}";
    }
    return @"{\"status\":0}";
}

- (NSString *)jsUartRead{
    return [NSString stringWithFormat:@"{\"data\":%d}",[Konashi uartRead]];
}

- (NSString *)jsReset{
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi reset]];
}

- (NSString *)jsBatteryLevelReadRequest{
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi batteryLevelReadRequest]];
}

- (NSString *)jsBatteryLevelRead{
    return [NSString stringWithFormat:@"{\"data\":%d}",[Konashi batteryLevelRead]];
}

- (NSString *)jsBatteryLevelGet{
    [Konashi batteryLevelReadRequest];
    readWaitFlag=true;
    while(readWaitFlag);
    return [NSString stringWithFormat:@"{\"data\":%d}",[Konashi batteryLevelRead]];
}

- (NSString *)jsSignalStrengthReadRequest{
    return [NSString stringWithFormat:@"{\"status\":%d}",[Konashi signalStrengthReadRequest]];
}

- (NSString *)jsSignalStrengthRead{
    return [NSString stringWithFormat:@"{\"data\":%d}",[Konashi signalStrengthRead]];
}

- (NSString *)jsSignalStrengthGet{
    [Konashi signalStrengthReadRequest];
    readWaitFlag=true;
    while(readWaitFlag);
    return [NSString stringWithFormat:@"{\"data\":%d}",[Konashi signalStrengthRead]];
}

// Event Observers

- (void)evaluateJavaScript:(NSString*)script{
    [self performSelectorOnMainThread:@selector(stringByEvaluatingJavaScriptFromString:) withObject:script waitUntilDone:NO];
}

- (void)jsKonashiConnected
{
    [self evaluateJavaScript:@"konashi.onConnected();"];
    NSLog(@"Konashi CONNECTED");
}

- (void)jsKonashiReady
{
    [self evaluateJavaScript:@"konashi.onReady();"];
    NSLog(@"Konashi READY");
}

- (void)jsKonashiUpdatePioInput{
    [self evaluateJavaScript:[NSString stringWithFormat:@"konashi.onPioChanged(%d)",[Konashi digitalReadAll]]];
    NSLog(@"%d",[Konashi digitalReadAll]);
}

- (void)jsKonashiReadAio{
    [self evaluateJavaScript:@"konashi.onAioReady(-1);"];
    NSLog(@"Konashi READAIO");
    readWaitFlag=false;
}

- (void)jsKonashiReadAio0{
    [self evaluateJavaScript:@"konashi.onAioReady(0);"];
    NSLog(@"Konashi READAIO0");
}

- (void)jsKonashiReadAio1{
    [self evaluateJavaScript:@"konashi.onAioReady(1);"];
    NSLog(@"Konashi READAIO1");
}

- (void)jsKonashiReadAio2{
    [self evaluateJavaScript:@"konashi.onAioReady(2);"];
    NSLog(@"Konashi READAIO2");
}

- (void)jsKonashiReadI2c{
    [self evaluateJavaScript:@"konashi.onI2cReady();"];
    NSLog(@"Konashi READI2C");
    readWaitFlag=false;
}

- (void)jsKonashiUartRx{
    [self evaluateJavaScript:@"konashi.onUartRx();"];
    NSLog(@"Konashi UARTRX");
    readWaitFlag=false;
}

- (void)jsKonashiReadBattery{
    [self evaluateJavaScript:@"konashi.onBatteryReady();"];
    NSLog(@"Konashi READBATT");
    readWaitFlag=false;
}

- (void)jsKonashiReadSignal{
    [self evaluateJavaScript:@"konashi.onSignalReady();"];
    NSLog(@"Konashi READSIG");
    readWaitFlag=false;
}

@end
