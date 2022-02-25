function loadJQuery() {
    var oScript = document.createElement("script");
    oScript.type = "text/javascript";
    oScript.charset = "utf-8";		  
    oScript.src = "/resources/js/jquery-3.6.0.js";	
    document.getElementsByTagName("head")[0].appendChild(oScript);
}


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


function formCheck() {
	
	const user_id = document.getElementById("user_id").value;
	const user_pwd = document.getElementById("user_pwd").value;
	const user_nm = document.getElementById("user_nm").value;
	const tempVal = document.getElementsByName("photo");
	const joinForm = document.getElementById("joinForm");
	let photo = null;
	let count = 0;
	
	
	if(user_id.trim().length < 5 || user_id.trim().length > 12) {
		alert("ID는 5글자 이상, 12글자 이하로 입력해주세요!");
		return;
	}
	
	if(user_pwd.trim().length < 5 || user_pwd.trim().length > 12) {
		alert("Password는 5글자 이상, 12글자 이하로 입력해주세요!");
		return;
	}
	
	if(user_nm.trim().length < 1) {
		alert("이름은 필수 입력값입니다!");
		return;
	}
	
	if(!(isNaN(user_nm))) {
		alert("문자열로 구성된 이름만 입력하실 수 있습니다!");
		return;
	}
	
	for(var i=0; i < tempVal.length; i++) {
		if(tempVal[i].checked == true){
			count += 1;
		}
	}
	
	if(count < 1) {
		alert("프로필 사진은 필수 입력값입니다!");
		return;
	} else {
		photo = document.querySelector('input[name="photo"]:checked').value;
	}
	
	joinForm.submit();
	
}






