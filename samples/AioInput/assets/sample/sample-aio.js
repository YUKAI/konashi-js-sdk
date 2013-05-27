$(function(){
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

  $("#btn-aio1").on("tap", function(){
	  k.trigger("analogReadRequest",{pin:0},function(){});
  });
  $("#btn-aio2").on("tap", function(){
	  k.trigger("analogReadRequest",{pin:1},function(){});
  });
  $("#btn-aio3").on("tap", function(){
	  k.trigger("analogReadRequest",{pin:2},function(){});
  });

  k.ready(function(){
    // change find button
    $("#btn-find")
      .removeClass("find")
      .html("Disconnect konashi")
    ;

    // show pio list
    $("#aio-setting").show();
  });

  k.updateAnalogValueAio0(function(data){
	  $("#aio1-value").html(data.value);
  });
  k.updateAnalogValueAio1(function(data){
	  $("#aio2-value").html(data.value);
  });
  k.updateAnalogValueAio2(function(data){
	  $("#aio3-value").html(data.value);
  });

  //k.showDebugLog();
});
