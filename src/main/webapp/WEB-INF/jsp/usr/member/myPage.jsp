<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="마이페이지" />

<%@ include file="../common/head.jsp"%>

<section class="my-4">
	<div class="container mx-auto">
		<div class="overflow-x-auto">
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
					<td>${rq.loginedMember.nickname }</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>${rq.loginedMember.cellphoneNum }</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${rq.loginedMember.email }</td>
				</tr>
				<tr>
					<th>&nbsp;</th>
					<td><a class="btn btn-sm" href="passwordChk">회원정보수정</a></td>
				</tr>
			</table>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jsp"%>