$(function(){
  var ADXL345_ADDR=0x1D;
  $("#i2c-setting").hide();
  // Find button
  $("#btn-find").on("tap", function(){
    if($("#btn-find").hasClass("find")){
      k.find();
    } else {
      k.disconnect();

      // change find button
      $("#btn-find")
        .addClass("find")
        .html("Find konashi")
      ;

      // hide pio list
      $("#i2c-setting").hide();
    }
  });

  $("#i2c-rate-100k").on("change", function(){
    k.i2cMode(k.KONASHI_I2C_DISABLE);
    k.i2cMode(k.KONASHI_I2C_ENABLE_100K);
  });

  $("#i2c-rate-400k").on("change", function(){
    k.i2cMode(k.KONASHI_I2C_DISABLE);
    k.i2cMode(k.KONASHI_I2C_ENABLE_400K);
  });

  $("#btn-chk").on("tap", function(){
    k.off("completeReadI2c");
    k.completeReadI2c(function(){
      k.i2cStopCondition();
      k.i2cRead(1, function(value){
        $("#i2c-chk-status").html(value.toString());
      });
    });
    k.i2cStartCondition();
    k.i2cWrite(1, 0x00, ADXL345_ADDR);
    k.i2cRestartCondition();
    k.i2cReadRequest(1, ADXL345_ADDR);
  });

  $("#btn-val-ax").on("tap", function(){
    k.off("completeReadI2c");
    k.completeReadI2c(function(){
      k.i2cStopCondition();
      k.i2cRead(2, function(value){
        var val=value[1]*256+value[0];
	if(val>32767) val=val-65536;
        $("#i2c-val-ax").html(val.toString());
      });
    });
    k.i2cStartCondition();
    k.i2cWrite(1, 0x32, ADXL345_ADDR);
    k.i2cRestartCondition();
    k.i2cReadRequest(2, ADXL345_ADDR);
  });

  $("#btn-val-ay").on("tap", function(){
    k.off("completeReadI2c");
    k.completeReadI2c(function(){
      k.i2cStopCondition();
      k.i2cRead(2, function(value){
        var val=value[1]*256+value[0];
	if(val>32767) val=val-65536;
        $("#i2c-val-ay").html(val.toString());
      });
    });
    k.i2cStartCondition();
    k.i2cWrite(1, 0x34, ADXL345_ADDR);
    k.i2cRestartCondition();
    k.i2cReadRequest(2, ADXL345_ADDR);
  });

  $("#btn-val-az").on("tap", function(){
    k.off("completeReadI2c");
    k.completeReadI2c(function(){
      k.i2cStopCondition();
      k.i2cRead(2, function(value){
        var val=value[1]*256+value[0];
	if(val>32767) val=val-65536;
        $("#i2c-val-az").html(val.toString());
      });
    });
    k.i2cStartCondition();
    k.i2cWrite(1, 0x36, ADXL345_ADDR);
    k.i2cRestartCondition();
    k.i2cReadRequest(2, ADXL345_ADDR);
  });

  k.ready(function(){
    // change find button
    $("#btn-find")
      .removeClass("find")
      .html("Disconnect konashi")
    ;

    // show aio list
    $("#i2c-setting").show();

    k.i2cMode(k.KONASHI_I2C_ENABLE_400K);
    k.i2cStartCondition();
    k.i2cWrite(2,[0x31,0x0b],ADXL345_ADDR);
    k.i2cRestartCondition();
    k.i2cWrite(2,[0x2D,0x08],ADXL345_ADDR);
    k.i2cStopCondition();
  });

  //k.showDebugLog();
});
