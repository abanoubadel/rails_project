$(document).ready(function(){

var interval = 5000;  // 1000 = 1 second, 3000 = 3 seconds
function doAjax() {
  $.ajax({
    url: "/notifications/json",
    type: "GET",
    success: function (data) {
      //load notifications
    	var html = '';
    	for (var i = 0; i < data.notifications.length; ++i) {
        if(data.notifications[i].message){
          html += '<li>';
          html += data.notifications[i].message;
          html += '</li>';
        }
    	}
      $('.notifications-menu .menu').html(html);
      //counter display
      if(data.count == 0){
        $('.notifications-menu .count').hide();
      }else{
        if(getCookie("notify") != data.count){
          $('.notification-audio').trigger("play");
        }
        $('.notifications-menu .count').show();
        $('.notifications-menu .count').html(data.count);
      }
      setCookie("notify", data.count, 10);
      setTimeout(doAjax, interval);
    },
    complete: function (data) {
    }
  });
}
doAjax();

//set notifications as read
$('.notifications-menu').click(function(e){
    if( $(this).hasClass("open") ){
      $(this).removeClass("open")
    }else{
      $.ajax({
        url: "/notifications",
        type: "POST",
        success: function (data) {
        }
      });
      $(this).addClass("open")
    }
    e.stopPropagation();
});

function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function checkCookie() {
    var user = getCookie("username");
    if (user != "") {
        alert("Welcome again " + user);
    } else {
        user = prompt("Please enter your name:", "");
        if (user != "" && user != null) {
            setCookie("username", user, 365);
        }
    }
}

});