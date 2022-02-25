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
	
	const backwardDiv = document.querySelector("#backwardDiv");
	backwardDiv.addEventListener("mouseover", mouseover);
	backwardDiv.addEventListener("click", goingBack);
	
});


function toDeleteReview(review_num) {
	
	const willCheck = confirm("정말로 Review를 삭제하시겠습니까?");
	
	if(willCheck) {
		location.href = "/review/deleteReview?review_num=" + review_num;
	};
	
};


function toUpdateReviewForm(review_num) {
	
	location.href = "/review/updateReviewForm?review_num=" + review_num;
	
}

function goingBack() {
	history.back();
}

function mouseover() {
	const backwardDiv = document.querySelector("#backwardDiv");
	backwardDiv.classList.add("forMouseover");
}



