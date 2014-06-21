(function(){
  var grove = {
    /************************************
     * constants
     ************************************/
    // port
    D0:k.PIO0,
    D1:k.PIO1,
    D2:k.PIO2,
    D3:k.PIO3,
    D4:k.PIO4,
    D5:k.PIO5,
    D6:k.PIO6,
    D7:k.PIO7,
    A0:k.AIO0,
    A1:k.AIO1,
    A2:k.AIO2,

    /************************************
     * properties
     ************************************/

    /************************************
     * public functions
     ************************************/
    digitalRead:function(port){
      return k.digitalRead(port);
    },
    digitalWrite:function(port,value){
      return k.digitalWrite(port,value);
    },
    analogReadRequest:function(port){
      return k.analogReadRequest(port);
    }
  };

  var groveBefore=window.k.grove;
  window.k.grove=grove;
})();
