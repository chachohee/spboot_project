<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="가챠 갤러리" />

<%@ include file="../common/head.jsp"%>

<div class="container mx-auto my-4">
	<div>
		<form action="upload" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="memberId"
				value="${rq.getLoginedMemberId() }" /> <input type="file"
				class="file-input file-input-bordered file-input-xs max-w-sm"
				name="file" />
			<button class="btn btn-xs">이미지 업로드</button>
		</form>
	</div>
	<!-- 이미지 리스트 -->
	<div class="overflow-x-auto">
		<table class="table">
			<thead>
				<tr>
					<th>No.</th>
					<th>Img</th>
					<th>WriterName</th>
					<th>RegDate</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="file" items="${files }">
					<tr>
						<td>${file.id }</td>
						<td>
							<div>
								<a href="#"> <img src="/usr/gacha/file/${file.id}"
									style="width: 100px; height: 100px;" /></a>
							</div>
						</td>
						<td>${file.writerName }</td>
						<td>${file.regDate }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<%@ include file="../common/foot.jsp"%>