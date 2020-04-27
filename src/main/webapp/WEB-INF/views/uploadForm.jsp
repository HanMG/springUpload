<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>UploadForm</title>
	<style type="text/css">
		iframe{
			width: 0px;
			height: 0px;
			border: 0px;
		}
	</style>
</head>
<body>
	<form action="uploadForm" id="form1" method="post" enctype="multipart/form-data" target="zeroFrame">
		<input type="file" name="file"> <input type="submit">
	</form>
	
	<iframe name="zeroFrame"></iframe>
	
	<script type="text/javascript">
		function addFilePath(msg){
			alert(msg);
			document.getElementById("form1").reset();
		}
	</script>
</body>
</html>