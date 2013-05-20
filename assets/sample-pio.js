$(function(){
  $(".toggle").on("toggle", function(e){
    var pin = $(e.currentTarget).data("pin");
    var value = $(e.currentTarget).hasClass("active") ? k.HIGH : k.LOW;
    k.trigger("digitalWrite", {pin:pin, value:value});
  });

  $("#btn-find").on("tap", function(){
    if($("#btn-find").hasClass("find")){
      k.trigger("find");
    } else {
      k.trigger("disconnect");

      // change find button
      $("#btn-find")
        .addClass("find")
        .html("Find konashi")
      ;

      // hide pio list
      $(".toggle").removeClass("active");
      $("#pio-setting").hide();
      $("#s1-status").html("OFF");
    }
  });

  k.on("ready", function(){
    // change find button
    $("#btn-find")
      .removeClass("find")
      .html("Disconnect konashi")
    ;

    // show pio list
    $("#pio-setting").show();

    k.trigger("pinModeAll", {mode: 254});
  });

  k.on("updatePioInput", function(data){
    if(data.value % 2){
      $("#s1-status").html("ON");
    } else {
      $("#s1-status").html("OFF");
    }
  });

  //k.showDebugLog();
});
