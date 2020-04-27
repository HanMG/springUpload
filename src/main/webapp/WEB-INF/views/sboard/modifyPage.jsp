<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../include/header.jsp" %>

	<!-- main content -->
	<section class="content">
		<div class="row">
			<!-- left column -->
			<div class="col-md-12">
				<!-- general form elements -->
				<div class="box">
					<div class="box-header with-border">
						<div class="box-title">REGISTER BOARD</div>
						<form role="form" action="modifyPage" method="post">
							<input type="hidden" name="page" value="${cri.page }">
							<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
							<input type="hidden" name="searchType" value="${cri.searchType }">
							<input type="hidden" name="keyword" value="${cri.keyword }">
							<div class="box-body">			
								<div class="from-group">
									<label for="exampleInputBno">Bno</label>
									<input type="text" name="bno" class="form-control" value="${boardVO.bno}" readonly="readonly">
								</div>					
								<div class="form-group">
									<label for="exampleInputTitle1">Title</label>
									<input type="text" name="title" class="form-control" value="${boardVO.title}">
								</div>
								<div class="form-group">
									<label for="exampleInputContent1">Content</label>
									<textarea rows="3" class="form-control" name="content" >${boardVO.content}</textarea>
								</div>
								<div class="form-group">
									<label for="exampleInputWriter">Writer</label>
									<input type="text" class="form-control" name="writer" value="${boardVO.writer}" readonly="readonly">
								</div>
							</div>
							<div class="box-footer">
								<button type="button" class="btn btn-primary">SAVE</button>
								<button type="button" class="btn btn-warning">CANCEL</button>
							</div>
						</form>												
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 버튼처리 -->
	<script>
		$(document).ready(function(){
			var formObj = $("form[role='form']");

			console.log(formObj);

			$(".btn-warning").on("click",function(){
				self.location = "/sboard/listPage?page=${cri.page}&perPamgeNum=${cri.perPageNum}"
					+"&searchType=${cri.searchType}&keyword=${cri.keyword}";
			});

			$(".btn-primary").on("click",function(){
				formObj.submit();
			});
		});
	</script>
<%@ include file="../include/footer.jsp" %>
