function loadJQuery() {
    var oScript = document.createElement("script");
    oScript.type = "text/javascript";
    oScript.charset = "utf-8";		  
    oScript.src = "/resources/js/jquery-3.6.0.js";	
    document.getElementsByTagName("head")[0].appendChild(oScript);
};


$(function(){
		
		
	var images = ['/resources/images/movie_01.jpg',
				  '/resources/images/movie_02.jpg',
	              '/resources/images/movie_03.jpg',
	              '/resources/images/movie_04.jpg',
	              '/resources/images/movie_05.jpg',
	              '/resources/images/movie_06.jpg',
	              '/resources/images/movie_07.jpg',
	              '/resources/images/movie_08.jpg',
	              '/resources/images/movie_09.jpg',
	     	     ];
  
    var i = 0;

    function changeBackground() {
        $('#picture').css('background-image', function() {
            if (i >= images.length) {
                i=0;
            }
            return 'url(' + images[i++] + ')';      
        });
    }
    
    // Call it on the first time
    changeBackground();
    // Set an interval to continue
    setInterval(changeBackground, 5000);

});



function doLogin() {
	
	const user_id = document.getElementById("user_id").value;
	const user_pwd = document.getElementById("user_pwd").value;
	const loginForm = document.getElementById("loginForm");
	
	
	if(user_id.trim().length < 5 || user_id.trim().length > 12) {
		alert("ID는 5글자 이상, 12글자 이하로 입력해주세요!");
		return;
	}
	
	if(user_pwd.trim().length < 5 || user_pwd.trim().length > 12) {
		alert("Password는 5글자 이상, 12글자 이하로 입력해주세요!");
		return;
	}
	
	
	loginForm.submit();

	
}
