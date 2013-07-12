$(function(){
  $("#uart-panel").hide();
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

      // hide uart panel
      $("#uart-panel").hide();
    }
  });

  $("#uart-baud-2k4").on("change", function(){
    k.uartMode(k.KONASHI_UART_DISABLE);
    k.uartBaudrate(k.KONASHI_UART_RATE_2K4);
    k.uartMode(k.KONASHI_UART_ENABLE);
  });

  $("#uart-baud-9k6").on("change", function(){
    k.uartMode(k.KONASHI_UART_DISABLE);
    k.uartBaudrate(k.KONASHI_UART_RATE_9K6);
    k.uartMode(k.KONASHI_UART_ENABLE);
  });

  $("#btn-tx-char").on("tap", function(){
    if($("#uart-tx-char").val()!=""){
      k.uartPutChar($("#uart-tx-char").val());
    }
  });

  $("#btn-tx-str").on("tap", function(){
    if($("#uart-tx-str").val()!=""){
      var str=$("#uart-tx-str").val();
      k.uartWriteString(str);
    }
  });

  $("#btn-tx-hex").on("tap", function(){
    if($("#uart-tx-hex").val()!=""){
      k.uartWrite(parseInt($("#uart-tx-hex").val(),16));
    }
  });

  $("#btn-clear-rx").on("tap", function(){
    $("#uart-rx-text").html("");
    $("#uart-rx-hex").html("");
  });

  k.ready(function(){
    // change find button
    $("#btn-find")
      .removeClass("find")
      .html("Disconnect konashi")
    ;

    // show pio list
    $("#uart-panel").show();

    // configure UART
    k.uartBaudrate(k.KONASHI_UART_RATE_9K6);
    k.uartMode(k.KONASHI_UART_ENABLE);
  });

  k.completeUartRx(function(value){
    $("#uart-rx-text").html($("#uart-rx-text").html()+String.fromCharCode(value));
    $("#uart-rx-hex").html($("#uart-rx-hex").html()+parseInt(value).toString(16)+" ");
  });

  //k.showDebugLog();
});
