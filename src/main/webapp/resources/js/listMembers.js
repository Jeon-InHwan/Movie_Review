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


	const clock = document.querySelector("#clock");

	function getClock() {
	    const date = new Date();
	    const hours = String(date.getHours()).padStart(2, "0");
	    const minutes = String(date.getMinutes()).padStart(2, "0");
	    const seconds = String(date.getSeconds()).padStart(2, "0");
	
	    clock.innerHTML = `${hours}:${minutes}:${seconds}`;
	}

	
	getClock();
	setInterval(getClock, 1000);
	
	
	const btns = document.querySelectorAll(".btn");
	
	for(const btn of btns) {
		btn.addEventListener("click", updateStatus);
	}
	
});




function search(willBeNextPage) {
	
	var searchForm = document.getElementById("searchForm");
	var page = document.getElementById("page");
	
	page.value = willBeNextPage;
	
	searchForm.submit();
	
}

function updateStatus(event) {
	
	const whatToDo = event.target.value;
	
	console.dir(event);
	
	if(whatToDo === "활성화 하기") {
		const thisUserId = event.target.parentElement.parentElement.lastElementChild.lastElementChild.value;
		console.log(thisUserId);
		location.href = "/manager/activateUser?user_id=" + thisUserId;
	} else if (whatToDo === "비활성화 하기") {
		const thisUserId = event.target.parentElement.parentElement.lastElementChild.lastElementChild.value;
		console.log(thisUserId);
		location.href = "/manager/deactivateUser?user_id=" + thisUserId;
	}

}





