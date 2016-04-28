$.ajax({
  url: "notifications",
  type: "GET",
  success: function (data) {
  	console.log(data);
  	console.log(data.notifications.length);
  	var html = '';
  	for (var i = 0; i < data.notifications.length; ++i) {
  		html += '<li>';
  		html += data.notifications[i].message;
  		html += '</li>';
  	}
  	$('.notifications-menu .count').html(data.count);
  	$('.notifications-menu .menu').append(html);
  }
});