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
						<form role="form" method="post">
							<div class="box-body">								
								<div class="form-group">
									<label for="exampleInputTitle1">Title</label>
									<input type="text" name="title" class="form-control" placeholder="Enter Title">
								</div>
								<div class="form-group">
									<label for="exampleInputContent1">Content</label>
									<textarea rows="3" class="form-control" name="content" placeholder="Enter ..."></textarea>
								</div>
								<div class="form-group">
									<label for="exampleInputWriter">Writer</label>
									<input type="text" class="form-control" name="writer" placeholder="Enter Writer">
								</div>
							</div>
							<div class="box-footer">
								<button type="submit" class="btn btn-primary">Submit</button>
							</div>
						</form>												
					</div>
				</div>
			</div>
		</div>
	</section>
<%@ include file="../include/footer.jsp" %>
