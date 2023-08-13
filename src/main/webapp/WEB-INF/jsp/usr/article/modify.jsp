<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="글 수정페이지" />

<%@ include file="../common/head.jsp"%>
<%@ include file="../common/toastUIEditorLib.jsp"%>

<section class="my-4">
	<div class="container mx-auto">
		<form action="doModify" onsubmit="submitForm(this); return false;"
			method="post">
			<input type="hidden" name="id" value=${article.id } /> <input
				type="hidden" name="body" />
			<div>
				<table>
					<colgroup>
						<col width="200" />
					</colgroup>
					<tr>
						<th>글 번호</th>
						<td>${article.id }</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${article.writerName }</td>
					</tr>
					<tr>
						<th>작성일</th>
						<td>${article.regDate }</td>
					</tr>
					<tr>
						<th>수정일</th>
						<td>${article.updateDate }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input class="input input-bordered input-primary w-full"
							type="text" name="title" value="${article.title }" /></td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<div class="toast-ui-editor">
								<script type="text/x-template">${article.body }</script>
							</div>
						</td>
					</tr>
					<tr>
						<th>&nbsp;</th>
						<td>
							<button class="btn btn-sm">수정</button>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<div>
			<button class="btn btn-sm" onclick="history.back();">Go Back</button>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jsp"%>