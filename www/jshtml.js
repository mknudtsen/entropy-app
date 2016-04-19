
$(document).ready(function() {

    Shiny.addCustomMessageHandler("buildTable",
      function(len) {
        var table = document.createElement("table"), tr, td, i;
        for (i = 0; i < len; i++) {
          if (i % 20 === 0) { 
            tr = table.appendChild(document.createElement("tr")); 
          }
          td = tr.appendChild(document.createElement("td"));
          letter = td.appendChild(document.createElement("h5"));
          c = td.appendChild(document.createElement("p"));
          letter.innerHTML = "-";
          letter.id = i;
          c.innerHTML = "-";
          c.id = i + "Cnt";
        }
        document.getElementById("container").innerHTML = table.innerHTML;
      });
  
  $(window).on("load", function() {
    
    Shiny.addCustomMessageHandler("editTable",
      function(message) {
        td = document.getElementById(message.idx - 2);
        if (message.letter == " ") {
          td.innerHTML = "&nbsp";
        } else {
          td.innerHTML = ("<b>" + message.letter + "</b>");
        }
      });
      
    Shiny.addCustomMessageHandler("editCount",
      function(message) {
        var idx = message.idx - 1;
        var cnt = message.cnt;
        var len = message.len;
        console.log("idx is :" + idx);
        console.log(len);
        if (idx < len) {
          p = document.getElementById((idx) + "Cnt");
          console.log(p);
          p.innerHTML = cnt;
        }
      });
      
    Shiny.addCustomMessageHandler("fixCount",
      function(message) {
        var idx = message.idx - 2;
        p = document.getElementById(idx + "Cnt");
        p.innerHTML = Number(p.innerHTML) + 1;
      });
      
    Shiny.addCustomMessageHandler("showEntropy",
      function(message) {
        var entropy = message.ent;
        window.alert("The entropy is: " + entropy);
      });
      
    var flash = function(element, colour) {
      var opacity = 50;
      var color = colour;
      var interval = setInterval(function() {
        opacity -=3;
        if (opacity <= 0) clearInterval(interval);
        $(element).css({background: "rgba("+color+", "+opacity/100+")"});
      }, 5);
    };
    
    Shiny.addCustomMessageHandler("flash",
      function(message) {
        var el = document.getElementById("flash");
        var color = message.color;
        flash($(el), color);
      });
      
  });
  
});