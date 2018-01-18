function submit() {
        var article = ue.getContent();
        document.getElementById('article').value=article;
        var titleS = document.getElementById('title').value;
        if(document.getElementById('title').value.length>30){
        	alert('标题不得超过30个字符！');
        }
        else if(document.getElementById('writer').value.length==0){
        	alert('未填写作者名！');
        }
        else{
        	alert(article);
        	$.ajax({
                cache: true,
                type: "POST",
                url:'login/validate',
                data:$('#form1').serialize(),
                async: false,
                error: function(request) {
                    alert("Connection error");
                },
                success: function(data) {
                    if(data.result=="true"){
                    	alert('成功发布！');
                    	if(data.user.role=="editor") window.navigate("mainPageForEditor.jsp"); 
                    	if(data.user.role=="user") window.navigate("mainPageForUser.jsp"); 
                    }else if(data.error=="writer"){
                    	document.getElementById('writer_message').innerHTML="作者不存在";
                    }
                }
            });
        }
    }
function quit(){
	document.getElementById('title').value="";
	document.getElementById('writer').value="";
    ue.setContent('输入正文...');
}