<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html data-theme="halloween">
<head>
<meta charset="UTF-8">
<!-- 테일윈드 불러오기 -->
<!-- 노말라이즈, 라이브러리 -->
<link href="https://cdn.jsdelivr.net/npm/daisyui@3.1.7/dist/full.css"
	rel="stylesheet" type="text/css" />
<script src="https://cdn.tailwindcss.com"></script>
<!-- 제이쿼리 불러오기 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<!-- 폰트어썸 불러오기 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" href="/resource/common.css" />
<title>${pageTitle }</title>
</head>
<body>

	<div class="navbar bg-base-300">
		<div class="flex-1 px-2 lg:flex-none">
			<label tabindex="0" class="btn btn-ghost rounded-btn">
				<a class="text-lg font-bold" href="/">GACHAPONG</a>
			</label>
		</div>
		<div class="flex justify-end flex-1 px-2">
			<div class="flex items-stretch">
				<a class="btn btn-ghost rounded-btn">Gacha</a>
				<div class="dropdown dropdown-end">
					<label tabindex="0" class="btn btn-ghost rounded-btn">Board</label>
					<ul tabindex="0"
						class="menu dropdown-content z-[1] p-2 shadow bg-base-100 rounded-box w-52 mt-4">
						<li><a href="/usr/article/list?boardId=1">공지사항</a></li>
						<li><a href="/usr/article/list?boardId=2">자유게시판</a></li>
					</ul>
				</div>
				<div class="dropdown dropdown-end">
					<label tabindex="0" class="btn btn-ghost rounded-btn">User</label>
					<ul tabindex="0"
						class="menu dropdown-content z-[1] p-2 shadow bg-base-100 rounded-box w-52 mt-4">
						<c:choose>
							<c:when test="${rq.getLoginedMemberId() == 0}">
								<li><a href="/usr/member/login">로그인</a></li>
								<li><a href="/usr/member/join">회원가입</a></li>
							</c:when>
							<c:when test="${rq.getLoginedMemberId() != 0 }">
								<li><a href="/usr/member/myPage">마이페이지</a></li>
								<li><a
									href="/usr/member/doLogout?id=${rq.getLoginedMemberId() }">로그아웃</a></li>
							</c:when>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- 본문 -->
	<div id="wrap">