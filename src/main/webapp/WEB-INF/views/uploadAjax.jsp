<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Ajax File Upload</title>
	<style type="text/css">
		.fileDrop{
			width: 100%;
			height: 200px;
			border: 1px dotted blue;			
		}
		
		small{
			margin-left: 3px;
			font-weight: bold;
			color: gray;
		}
	</style>
</head>
<body>
	<h3>Ajax File Upload</h3>
	<div class="fileDrop"></div>
	
	<div class="uploadedList"></div>
	
	<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<script type="text/javascript">
		$(".fileDrop").on("dragenter dragover", function(event){
			event.preventDefault();
		});
		$(".fileDrop").on("drop",function(event){
			event.preventDefault();
			var files = event.originalEvent.dataTransfer.files;
			var file = files[0];
			//console.log(file);
			var formData = new FormData();

			formData.append("file",file);

			$.ajax({
				url: "/uploadAjax",
				data: formData,
				dataType: "text",
				processData: false,
				contentType: false,
				type: "POST",
				success: function(data){
					var str = "";

					if(checkImageType(data)){
						str ="<div><a href='displayFile?fileName="+getImageLink(data)+"'>"
						  +"<img src='displayFile?fileName="+data+"'/>"
						  +"</a><small data-src="+data+">(X)</small></div>";
					} else{
						str = "<div><a href='displayFile?fileName="+data+"'>"
						+getOriginalName(data)+"</a>"
						+"<small data-src="+data+">(X)</small></div>";
					}

					$(".uploadedList").append(str);
				}
			});			
		});		
		/* 전송받은 문자열이 이미지 파일인지를 확인 */
		function checkImageType(fileName){
			var pattern = /jpg|gif|png|jpeg/i;
			return fileName.match(pattern);
		}
		/* 실제파일명 */
		function getOriginalName(fileName){
			if(checkImageType(fileName)){
				return;
			}
			var idx = fileName.indexOf("_")+1;
			return fileName.substr(idx);
		}
		/* 생성된 파일명 */
		function getImageLink(fileName){
			if(!checkImageType(fileName)){
				return;
			}
			var front = fileName.substr(0,12);
			var end = fileName.substr(14);

			return front + end;
		}

		// data-src의 값을 deleteFile로 보냄
		$(".uploadedList").on("click","small",function(event){
			var that = $(this);

			$.ajax({
				url:"deleteFile",
				type:"post",
				data:{fileName:$(this).attr("data-src")},
				dataType:"text",
				success:function(result){
					if(result == 'deleted'){
						alert("deleted");
						that.parent("div").remove();
					}
				}
			});				
		});
	</script>
</body>
</html>