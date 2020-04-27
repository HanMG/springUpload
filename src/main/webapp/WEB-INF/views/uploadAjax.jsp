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
					alert(data);
				}
			});			
		});		
	</script>
</body>
</html>