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
      $(".toggle").removeClass("active").attr({"style": ""});
      $(".toggle-handle").attr({"style": ""});
      $("#pio-setting").hide();
      $("#s1-status").html("OFF");
    }
  });
  $("#btn-send11").on("tap", function() {
    k.digitalWrite(2, k.LOW);
    k.spiWrite("ABCDEFGHIJ");
    k.digitalWrite(2, k.HIGH);
  });
  $("#btn-send25").on("tap", function() {
    k.digitalWrite(2, k.LOW);
    k.spiWrite("ABCDEFGHIJABCDEFGHIJABCDE");
    k.digitalWrite(2, k.HIGH);
  });
  k.completeWriteSPI(function() {
    k.spiReadRequest();
  });
  k.completeReadSPI(function() {
    k.spiReadData(function(data) {
      alert(data);
    });
  });
  k.ready(function(){
    // change find button
    $("#btn-find")
      .removeClass("find")
      .html("Disconnect konashi")
    ;

    k.pinMode(2, k.OUTPUT);
    k.digitalWrite(2, k.HIGH);
    k.spiMode(k.KOSHIAN_SPI_MODE_CPOL0_CPHA0, k.KOSHIAN_SPI_SPEED_200K, k.KOSHIAN_SPI_BIT_ORDER_LSB_FIRST);
  });

  //k.showDebugLog();
});
