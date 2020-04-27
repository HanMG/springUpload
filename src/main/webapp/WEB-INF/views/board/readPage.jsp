<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp"%>

<!-- main content -->
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box">
				<div class="box-header with-border">
					<div class="box-title">REGISTER BOARD</div>
					<form role="form" method="post">
						<input type="hidden" name="bno" value="${boardVO.bno}"> <input
							type='hidden' name='page' value="${cri.page}"> <input
							type='hidden' name='perPageNum' value="${cri.perPageNum}">
					</form>
					<div class="box-body">
						<div class="form-group">
							<label for="exampleInputTitle1">Title</label> <input type="text"
								name="title" class="form-control" value="${boardVO.title}"
								readonly="readonly">
						</div>
						<div class="form-group">
							<label for="exampleInputContent1">Content</label>
							<textarea rows="3" class="form-control" name="content"
								readonly="readonly">${boardVO.content }</textarea>
						</div>
						<div class="form-group">
							<label for="exampleInputWriter">Writer</label> <input type="text"
								class="form-control" name="writer" value="${boardVO.writer }"
								readonly="readonly">
						</div>
					</div>
					<div class="box-footer">
						<button type="button" class="btn btn-warning">Modify</button>
						<button type="button" class="btn btn-danger">Remove</button>
						<button type="button" class="btn btn-primary">Go List</button>
					</div>

				</div>
			</div>
		</div>
	</div>
</section>
<!-- 버튼처리 -->
<script>
	$(document).ready(function() {
		var formObj = $("form[role='form']");

		console.log(formObj);

		$(".btn-warning").on("click", function() {
			formObj.attr("action", "/board/modifyPage");
			formObj.attr("method", "get");
			formObj.submit();
		});

		$(".btn-danger").on("click", function() {
			formObj.attr("action","/board/removePage");			
			formObj.submit();
		});

		$(".btn-primary").on("click", function() {
			formObj.attr("method","get");
			formObj.attr("action","/board/listPage");
			formObj.submit();
		});
	});
</script>
<%@ include file="../include/footer.jsp"%>
