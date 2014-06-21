(function(){
  var adc = {
    /************************************
     * constants
     ************************************/
    // channel
    CH0:0,
    CH1:1,
    CH2:2,
    CH3:3,
    CH4:4,
    CH5:5,
    CH6:6,
    CH7:7,
    CH0_CH1:0, // +CH0 -CH1
    CH2_CH3:1, // +CH2 -CH3
    CH4_CH5:2, // +CH4 -CH5
    CH6_CH7:3, // +CH6 -CH7
    CH1_CH0:4, // +CH1 -CH0
    CH3_CH2:5, // +CH3 -CH2
    CH5_CH4:6, // +CH5 -CH4
    CH7_CH6:7, // +CH7 -CH6
    
    // I2C address
    ADDR_00:0x48,
    ADDR_01:0x49,
    ADDR_10:0x4a,
    ADDR_11:0x4b,

    // power mode
    REFOFF_ADCOFF:0,
    REFOFF_ADCON:1,
    REFON_ADCOFF:2,
    REFON_ADCON:3,

    /************************************
     * properties
     ************************************/
    adcAddress:0x00,
    powerMode:0x00,

    /************************************
     * public functions
     ************************************/
    init:function(address,callback){
      if(address<k.adc.ADDR_00 || address>k.adc.ADDR_11){
        return k.KONASHI_FAILURE;
      }
      if(callback && typeof callback == "function"){
        k.completeReadI2c(function(){
          k.i2cStopCondition();
          k.i2cRead(2,function(value){
            var amp=value[0]*256+value[1];
            callback(amp);
          });
        });
      }
      k.adc.adcAddress=address;
      return k.i2cMode(k.KONASHI_I2C_ENABLE_400K);
    },

    read:function(channel){
      if(channel<k.adc.CH0 || channel>k.adc.CH7 || k.adc.adcAddress<k.adc.ADDR_00 || k.adc.adcAddress>k.adc.ADDR_11){
        return k.KONASHI_FAILURE;
      }
      var c=(channel>>1)|((channel&1)<<2);
      var data=0x80|(c<<4)|(k.adc.powerMode<<2);
      k.i2cStartCondition();
      k.i2cWrite(1,data,k.adc.adcAddress);
      k.i2cRestartCondition();
      k.i2cReadRequest(2,k.adc.adcAddress);
    },
    
    readDiff:function(channels){
      if(channels<k.adc.CH0_CH1 || channels>k.adc.CH7_CH6 || k.adc.adcAddress<k.adc.ADDR_00 || k.adc.adcAddress<k.adc.ADDR_11){
        return k.KONASHI_FAILURE;
      }
      var data=(channels<<4)|(k.adc.powerMode<<2);
      k.i2cStartCondition();
      k.i2cWrite(1,data,k.adc.adcAddress);
      k.i2cRestartCondition();
      k.i2cReadRequest(2,k.adc.adcAddress);
    },
    
    selectPowerMode:function(mode){
      if(mode<k.adc.REFOFF_ADCOFF || mode>k.adc.REFON_ADCON || k.adc.adcAddress<k.adc.ADDR_00 || k.adc.adcAddress<k.adc.ADDR_11){
        return k.KONASHI_FAILURE;
      }
      k.adc.powerMode=mode;
      k.i2cStartCondition();
      k.i2cWrite(1,data,k.adc.adcAddress);
      k.i2cStopCondition();
    }
  };

  var adcBefore=window.k.adc;
  window.k.adc=adc;
})();
