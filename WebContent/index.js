var rq;
function postComment() {
	
	var email_id = document.commentForm.email_id.value;
	var comment = document.commentForm.comment_text.value;

	if(email_id == ''){
		alert("Email id required");
		document.getElementById("email_check").focus();
		return false;
	}
	
	if(comment == ''){
		alert("Enter Comment below");
		document.getElementById("comment_check").focus();
		return false;
	}
	
	if (window.XMLHttpRequest) {
		rq = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		rq = new ActiveXObject();
	}

	try {

		rq.onreadystatechange = function() {
			if (rq.readyState == 4) {
				document.getElementById("comment_output").innerHTML = rq.responseText;
			}
		};

		rq.open("POST", "index.jsp", true);
		rq.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		rq.send("comment=" + comment + "&email=" + email_id);

	} catch (e) {
		alert("Unable to connect to the server");
	}

}