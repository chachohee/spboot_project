<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="마이페이지" />

<%@ include file="../common/head.jsp"%>

<section class="my-4">
	<div class="container mx-auto">
		<div class="overflow-x-auto">
			<form action="doModify" method="post">
				<input type="hidden" name="id" value=${rq.loginedMember.id } />
				<table class="table">
					<colgroup>
						<col width="200" />
					</colgroup>
					<tr>
						<th>가입일</th>
						<td>${rq.loginedMember.regDate }</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>${rq.loginedMember.loginId }</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${rq.loginedMember.name }</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td><input class="input input-bordered w-full max-w-xs"
							type="text" name="nickname" value="${rq.loginedMember.nickname }"
							placeholder="nickname" /></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input class="input input-bordered w-full max-w-xs"
							type="text" name="cellphoneNum"
							value="${rq.loginedMember.cellphoneNum }"
							placeholder="phone number" /></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input class="input input-bordered w-full max-w-xs"
							type="text" name="email" value="${rq.loginedMember.email }"
							placeholder="email" /></td>
					</tr>
					<tr>
						<th>&nbsp;</th>
						<td><a class="btn btn-sm" href="passwordModify">비밀번호 변경</a>
							<button class="btn btn-sm">회원정보수정</button></td>
					</tr>
				</table>
			</form>
		</div>
		<div class="mt-4">
			<button class="btn btn-sm" onclick="history.back();">Go Back</button>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jsp"%>