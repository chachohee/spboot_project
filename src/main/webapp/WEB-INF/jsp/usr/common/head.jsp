<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html data-theme="halloween">
<head>
<meta charset="UTF-8">
<!-- 파비콘 -->
<link rel="shortcut icon" href="/resource/images/favicon.ico" />
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
<script>
	function Theme_toggle() {
		
		const theme = localStorage.getItem("theme") ?? "halloween";
		
		if (theme == 'halloween') {
			localStorage.setItem("theme", "light");
		} else {
			localStorage.setItem("theme", "halloween");
		}
		
		location.reload();
	}
	
	function Theme_applyTo(themeName) {
		$('html').attr('data-theme', themeName);
	}
	
	function Theme_init() {
		const theme = localStorage.getItem("theme") ?? "halloween";
		Theme_applyTo(theme);
	}
	
	Theme_init();
</script>
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
				<div class="dropdown dropdown-end">
					<label tabindex="0" class="btn btn-ghost rounded-btn">Gacha</label>
					<ul tabindex="0"
						class="menu dropdown-content z-[1] p-2 shadow bg-base-100 rounded-box w-52 mt-4">
						<li><a href="/usr/gacha/gacha">가챠 뽑기</a></li>
						<li><a href="/usr/gacha/gallery">가챠 갤러리</a></li>
					</ul>
				</div>
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
								<c:if test="${rq.loginedMember.authLevel == 3 }">
									<li><a href="/adm/member/list">회원관리</a></li>
									<li><a href="/adm/gacha/list">가챠관리</a></li>
								</c:if>
								<li><a href="/usr/member/myPage">마이페이지</a></li>
								<c:if test="${rq.loginedMember.authLevel == 1 }">
									<li><a href="/usr/gacha/myCollection">마이컬렉션</a></li>
								</c:if>
								<li><a
									href="/usr/member/doLogout?id=${rq.getLoginedMemberId() }">로그아웃</a></li>
							</c:when>
						</c:choose>
					</ul>
				</div>
				<!-- 테마 -->
				<div class="mt-3">
					<input id="tg" type="checkbox" class="toggle" checked onclick="Theme_toggle();" />
				</div>
			</div>
		</div>
	</div>
	<!-- 본문 -->
	<div id="wrap">