<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name } 게시판" />

<%@ include file="../common/head.jsp"%>

<div class="container mx-auto my-4">
	<!-- 검색 -->
	<div class="form-control mx-auto">
		<div class="input-group flex justify-end">
			<form>
				<input type="hidden" name="boardId" value="${board.id }" />
				<div class="join">
					<select class="select select-bordered join-item"
						data-value="${searchKeywordType }" name="searchKeywordType">
						<option disabled selected>Filter</option>
						<option value="title">제목</option>
						<option value="body">내용</option>
						<option value="title,body">제목 + 내용</option>
					</select>
					<div>
						<input class="input input-bordered join-item" type="text"
							name="searchKeyword" placeholder="Search" />
					</div>
					<button class="btn join-item">Search</button>
				</div>
			</form>
		</div>
	</div>
	<!-- end 검색 -->
	<!-- 게시글 목록 -->
	<div class="overflow-x-auto mt-4">
		<table class="table">
			<thead>
				<tr>
					<th>번호</th>
					<th>추천수</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="article" items="${articles }">
					<tr class="hover">
						<td>${article.id }</td>
						<td>${article.sumReactionPoint }</td>
						<td><a href="detail?id=${article.id }">${article.title }</a></td>
						<td>${article.writerName }</td>
						<td>${article.regDate.substring(2, 16) }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<!-- end 게시글 목록 -->
	<!-- 글쓰기 버튼 -->
	<c:if test="${rq.getLoginedMemberId() != 0 }">
		<c:choose>
			<c:when test="${board.id == 1 }">
				<c:if test="${rq.loginedMember.authLevel == 3 }">
					<div class="flex justify-end mt-4">
						<a class="btn btn-sm" href="write">글쓰기</a>
					</div>
				</c:if>
			</c:when>
			<c:otherwise>
				<div class="flex justify-end mt-4">
					<a class="btn btn-sm" href="write">글쓰기</a>
				</div>
			</c:otherwise>
		</c:choose>
	</c:if>
	<!-- end 글쓰기 버튼 -->
	<!-- 페이징 -->
	<div class="flex justify-center mt-4">
		<div class="join">
			<c:set var="pageMenuLen" value="5" />
			<c:set var="startPage"
				value="${page - pageMenuLen >= 1 ? page - pageMenuLen : 1 }" />
			<c:set var="endPage"
				value="${page + pageMenuLen <= pagesCnt ? page + pageMenuLen : pagesCnt }" />

			<c:set var="pageBaseUri"
				value="?boardId=${board.id }&searchKeywordType=${searchKeywordType }&searchKeyword=${searchKeyword }" />

			<c:if test="${page == 1 }">
				<a class="join-item btn btn-disabled">«</a>
				<a class="join-item btn btn-disabled">&lt;</a>
			</c:if>

			<c:if test="${page > 1 }">
				<a class="join-item btn" href="${pageBaseUri }&page=1">«</a>
				<a class="join-item btn" href="${pageBaseUri }&page=${page - 1 }">&lt;</a>
			</c:if>

			<c:forEach begin="${startPage }" end="${endPage }" var="i">
				<a class="join-item btn ${page == i ? 'btn-active' : '' }"
					href="${pageBaseUri }&page=${i }">${i }</a>
			</c:forEach>

			<c:if test="${page < pagesCnt }">
				<a class="join-item btn" href="${pageBaseUri }&page=${page + 1 }">&gt;</a>
				<a class="join-item btn" href="${pageBaseUri }&page=${pagesCnt }">»</a>
			</c:if>

			<c:if test="${page == pagesCnt }">
				<a class="join-item btn btn-disabled">&gt;</a>
				<a class="join-item btn btn-disabled">»</a>
			</c:if>
		</div>
	</div>
	<!-- end 페이징 -->
</div>

<%@ include file="../common/foot.jsp"%>