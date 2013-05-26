$(function(){
  // Toggle switch
  $(".toggle").on("toggle", function(e){
    var pin = $(e.currentTarget).data("pin");
    var value = $(e.currentTarget).hasClass("active") ? k.HIGH : k.LOW;
    k.digitalWrite(pin, value);
  });

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
      $(".toggle").removeClass("active").attr({"style": ""});
      $(".toggle-handle").attr({"style": ""});
      $("#pio-setting").hide();
      $("#s1-status").html("OFF");
    }
  });

  k.ready(function(){
    // change find button
    $("#btn-find")
      .removeClass("find")
      .html("Disconnect konashi")
    ;

    // show pio list
    $("#pio-setting").show();

    // PIO7-1:OUTPUT(1), PIO0(S1):INPUT(0)
    k.pinModeAll(254);
  });

  k.updatePioInput(function(data){
    if(data.value % 2){
      $("#s1-status").html("ON");
    } else {
      $("#s1-status").html("OFF");
    }
  });

  //k.showDebugLog();
});
