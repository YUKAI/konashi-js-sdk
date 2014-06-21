(function(){
  var acdrive = {
    /************************************
     * constants
     ************************************/
    // pin
    PIN_CTRL:k.PIO0,
    PIN_FREQ:k.PIO1,

    // pwm
    PWM_PERIOD:10000,
    
    // mode
    MODE_ONOFF:0,
    MODE_PWM:1,
    
    // AC frequency
    FREQ_50HZ:50,
    FREQ_60HZ:60,

    /************************************
     * properties
     ************************************/
    mode:0,

    /************************************
     * public functions
     ************************************/
    init:function(mode,freq){
      k.acdrive.mode=mode;
      if(mode==k.acdrive.MODE_ONOFF){
        k.pinMode(k.acdrive.PIN_CTRL,k.OUTPUT);
        k.pinMode(k.acdrive.PIN_FREQ,k.OUTPUT);
        k.acdrive.selectFreq(freq);
      } else if(mode==k.acdrive.MODE_PWM){
        k.pwmMode(k.acdrive.PIN_CTRL,k.KONASHI_PWM_ENABLE);
        k.pinMode(k.acdrive.PIN_FREQ,k.OUTPUT);
        k.pwmPeriod(k.acdrive.PIN_CTRL,k.acdrive.PWM_PERIOD);
        k.acdrive.selectFreq(freq);
      } else {
        return k.KONASHI_FAILURE;
      }
    },

    on:function(){
        if(k.acdrive.mode==0){
          return k.digitalWrite(k.acdrive.PIN_CTRL,k.HIGH);
        } else {
          return k.KONASHI_FAILURE;
        }
    },
    off:function(){
        if(k.acdrive.mode==0){
          return k.digitalWrite(k.acdrive.PIN_CTRL,k.LOW);
        } else {
          return k.KONASHI_FAILURE;
        }
    },
    updateDuty:function(ratio){
        if(k.acdrive.mode==1){
	  var duty;
	  if(ratio<0.0) ratio=0.0;
	  if(ratio>100.0) ratio=100.0;
	  duty=Math.round(k.acdrive.PWM_PERIOD*ratio/100);
	  return k.pwmDuty(k.acdrive.PIN_CTRL,duty);
	} else {
	  return k.KONASHI_FAILURE;
	}
    },

    selectFreq:function(freq){
      if(freq==k.acdrive.FREQ_50HZ){
        return k.digitalWrite(k.acdrive.PIN_FREQ,k.LOW);
      } else if(freq==k.acdrive.FREQ_60HZ){
        return k.digitalWrite(k.acdrive.PIN_FREQ,k.HIGH);
      } else {
        return k.KONASHI_FAILURE;
      }
    }
  };

  var acdriveBefore=window.k.acdrive;
  window.k.acdrive=acdrive;
})();
