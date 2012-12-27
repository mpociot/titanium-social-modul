var window = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel();
window.add(label);
window.open();

var module	= require('de.marcelpociot.social');
var tweetButton	= Ti.UI.createButton({
	title: 'twitter',
	top: 10,
	left: 10,
	height: 50
});
window.add(tweetButton);
tweetButton.addEventListener('click',function(e){
	module.showSheet({
		service:	'twitter',
		message: 	'Hey, this is some cool tweet!',
		urls: 		['http://www.marcelpociot.de'],
		images:		['http://www.marcelpociot.de/badges/titan_logo_256.png'],
		success:	function(){
			alert("Tweet successfully sent");
		},
		cancel:		function(){
			alert("User canceled tweet");
		},
		error:		function(){
			alert("Unable to send tweet");
		}
	});
});

var facebookButton	= Ti.UI.createButton({
	title: 'facebook',
	top: 70,
	left: 10,
	height: 50
});
window.add(facebookButton);
facebookButton.addEventListener('click',function(e){
	module.showSheet({
		service:	'facebook',
		message: 	'Hey, this is some cool facebook message!',
		urls: 		['http://www.marcelpociot.de'],
		images:		['http://www.marcelpociot.de/badges/titan_logo_256.png'],
		success:	function(){
			alert("Tweet successfully sent");
		},
		cancel:		function(){
			alert("User canceled tweet");
		},
		error:		function(){
			alert("Unable to send tweet");
		}
	});
});

var sinaweiboButton	= Ti.UI.createButton({
	title: 'sinaweibo',
	top: 130,
	left: 10,
	height: 50
});
window.add(sinaweiboButton);
sinaweiboButton.addEventListener('click',function(e){
	module.showSheet({
		service:	'sinaweibo',
		message: 	'Hey, this is some cool sinaweibo message!',
		urls: 		['http://www.marcelpociot.de'],
		images:		['http://www.marcelpociot.de/badges/titan_logo_256.png'],
		success:	function(){
			alert("Tweet successfully sent");
		},
		cancel:		function(){
			alert("User canceled tweet");
		},
		error:		function(){
			alert("Unable to send tweet");
		}
	});
});

/**
 * Shows the ActivityView
 * Currently it only supports messages!
 */
var activityButton	= Ti.UI.createButton({
	title: 'activity',
	top: 190,
	left: 10,
	height: 50
});
window.add(activityButton);
activityButton.addEventListener('click',function(e){
	module.showSheet({
		message: 	'Hey, this is some cool message!',
		images:		[Ti.Filesystem.getFile('KS_nav_ui.png').nativePath]
	});
});