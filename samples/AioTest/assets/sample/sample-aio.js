$(function(){
  $("#aio-setting").hide();
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
      $("#aio-setting").hide();
    }
  });

  $("#btn-read-aio0").on("tap", function(){
    k.analogReadRequest(0);
  });

  $("#btn-read-aio1").on("tap", function(){
    k.analogReadRequest(1);
  });

  $("#btn-read-aio2").on("tap", function(){
    k.analogReadRequest(2);
  });

  $("#btn-write-aio0").on("tap", function(){
    k.analogWrite(0,$("#aio0-write-value").val());
  });

  $("#btn-write-aio1").on("tap", function(){
    k.analogWrite(1,$("#aio1-write-value").val());
  });

  $("#btn-write-aio2").on("tap", function(){
    k.analogWrite(2,$("#aio2-write-value").val());
  });

  k.ready(function(){
    // change find button
    $("#btn-find")
      .removeClass("find")
      .html("Disconnect konashi")
    ;

    // show aio list
    $("#aio-setting").show();
  });

  k.updateAnalogValueAio0(function(value){
    $("#aio0-read-value").html(value);
  });

  k.updateAnalogValueAio1(function(value){
    $("#aio1-read-value").html(value);
  });

  k.updateAnalogValueAio2(function(value){
    $("#aio2-read-value").html(value);
  });

  //k.showDebugLog();
});
