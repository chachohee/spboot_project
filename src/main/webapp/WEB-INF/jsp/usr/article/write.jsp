<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="글쓰기" />

<%@ include file="../common/head.jsp"%>
<%@ include file="../common/toastUIEditorLib.jsp"%>

<section class="my-4">
	<div class="container mx-auto">
		<form action="doWrite" onsubmit="submitForm(this); return false;" method="post">
			<input type="hidden" name="body" />
			<div>
				<table>
					<colgroup>
						<col width="200" />
					</colgroup>
					<tr>
						<th>게시판</th>
						<td>
							<c:if test="${rq.loginedMember.authLevel == 3 }">
								<label>
									<input type="radio" name="boardId" value="1" checked />
									&nbsp;공지사항
								</label>
								<label>
									<input type="radio" name="boardId" value="2"/>
									&nbsp;자유
								</label>
							</c:if>
							&nbsp;&nbsp;&nbsp;
							<c:if test="${rq.loginedMember.authLevel != 3 }">
								<label>
									<input type="radio" name="boardId" value="2" checked/>
									&nbsp;자유
								</label>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${member.nickname }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input class="input input-bordered input-primary w-full" type="text" name="title" placeholder="제목을 입력해주세요."/></td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<div class="toast-ui-editor">
      							<script type="text/x-template"></script>
    						</div>
						</td>
					</tr>
					<tr>
						<th>&nbsp;</th>
						<td>
							<button class="btn btn-sm">작성</button>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
</section>

<%@ include file="../common/foot.jsp"%>