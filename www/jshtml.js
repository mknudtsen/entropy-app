
$(document).ready(function() {
    
    Shiny.addCustomMessageHandler("buildTable",
      function(len) {
        var table = document.createElement("table"), tr, td, i;
        for (i = 0; i < len; i++) {
          if (i % 20 === 0) { 
            tr = table.appendChild(document.createElement("tr")); 
          }
          td = tr.appendChild(document.createElement("td"));
          letter = td.appendChild(document.createElement("h4"));
          c = td.appendChild(document.createElement("p"));
          letter.innerHTML = "-";
          letter.id = i;
          c.innerHTML = "-";
          c.id = i + "Cnt";
        }
        document.getElementById("container").innerHTML = table.innerHTML;
      });
  
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
        console.log("edit counts are :" + message.cnts);
        p = document.getElementById((idx) + "Cnt");
        p.innerHTML = cnt;
      });
      
    Shiny.addCustomMessageHandler("fixCount",
      function(message) {
        var idx = message.idx - 2;
        p = document.getElementById(idx + "Cnt");
        p.innerHTML = Number(p.innerHTML) + 1;
      });
  
});