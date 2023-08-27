<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원관리" />

<%@ include file="../../usr/common/head.jsp"%>

<div class="container mx-auto my-4">
	<div class="mb-2 flex justify-between items-end">
		<div>
			<span>회원수 : ${membersCnt }명</span>
		</div>
		<form>
			<div class="join">
				<select class="select select-bordered join-item"
					data-value="${authLevel }" class="select select-accent select-sm"
					name="authLevel">
					<option value="0">전체</option>
					<option value="1">일반</option>
					<option value="3">관리자</option>
				</select> <select class="select select-bordered join-item"
					data-value="${searchKeywordType }"
					class="select select-accent select-sm" name="searchKeywordType">
					<option value="loginId,name,nickname">전체</option>
					<option value="loginId">아이디</option>
					<option value="name">이름</option>
					<option value="nickname">닉네임</option>
				</select>
				<div>
					<input class="input input-bordered join-item" type="text"
						name="searchKeyword" placeholder="Search" />
				</div>
				<button class="btn join-item">Search</button>
			</div>
		</form>
	</div>
	<c:choose>
		<c:when test="${membersCnt == 0 }">
			<div class="text-center py-2">조건에 일치하는 검색결과가 없습니다.</div>
		</c:when>
		<c:otherwise>
			<div class="overflow-x-auto mt-4">
				<table class="table">
					<thead>
						<tr>
							<th><input type="checkbox" class="checkbox-all-member-id" /></th>
							<th>번호</th>
							<th>가입일</th>
							<th>수정일</th>
							<th>아이디</th>
							<th>이름</th>
							<th>닉네임</th>
							<th>삭제여부</th>
							<th>삭제날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="member" items="${members }">
							<tr class="hover">
								<%-- <c:if test="${member.authLevel != 3 }"> --%>
									<c:choose>
										<c:when test="${member.delStatus != 1 }">
											<td><input type="checkbox" class="checkbox-member-id"
												value="${member.id }" /></td>
										</c:when>
										<c:otherwise>
											<td><input type="checkbox" class="checkbox-member-id"
												value="${member.id }" disabled /></td>
										</c:otherwise>
									</c:choose>
									<td>${member.id }</td>
									<td>${member.regDate.substring(2, 16) }</td>
									<td>${member.updateDate.substring(2, 16) }</td>
									<td>${member.loginId }</td>
									<td>${member.name }</td>
									<td>${member.nickname }</td>
									<td>${member.delStatusStr() }</td>
									<td>${member.delDateStr() }</td>
								<%-- </c:if> --%>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:otherwise>
	</c:choose>

	<script>
				$('.checkbox-all-member-id').change(function() {
					const allCheck = $(this);
					const allChecked = allCheck.prop('checked'); //allChecked == true, false
					$('.checkbox-member-id').prop('checked', allChecked);
					$('.checkbox-member-id:is(:disabled)').prop('checked', false); //선택할 수 없는 요소면 무조건 체크 못하도록.
				})
				
				$('.checkbox-member-id').change(function() {
					const checkboxMemberIdCount = $('.checkbox-member-id').length;
					const checkboxMemberIdCheckedCount = $('.checkbox-member-id:checked').length;
					const checkboxDisabledCount = $('.checkbox-member-id:is(:disabled)').length;
					const allChecked = (checkboxMemberIdCount - checkboxDisabledCount) == checkboxMemberIdCheckedCount;
					$('.checkbox-all-member-id').prop('checked', allChecked);
				})
			</script>

	<div class="mt-4 flex justify-end">
		<button class="btn btn-sm btn-error btn-delete-selected-members">회원
			삭제</button>
	</div>

	<form action="doDeleteMembers" method="POST"
		name="do-delete-members-form">
		<input type="hidden" name="ids" value="" />
	</form>

	<script>
				$('.btn-delete-selected-members').click(function() {
					const values = $('.checkbox-member-id:checked').map((index, el) => el.value).toArray();
					
					if (values.length == 0) {
						alert('선택된 회원이 없습니다.');
						return;
					}
					if (confirm('선택한 회원을 삭제하시겠습니까?') == false) {						
						return;
					}
					$('input[name=ids]').val(values.join(',')); //input태그인데 name이 ids인 애를 찾는다.
					$('form[name=do-delete-members-form]').submit();
				})
	</script>

	<div class="mt-4 flex justify-center">
		<div class="join">
			<c:set var="pageMenuLen" value="5" />
			<c:set var="startPage"
				value="${page - pageMenuLen >= 1 ? page - pageMenuLen : 1 }" />
			<c:set var="endPage"
				value="${page + pageMenuLen <= pagesCnt ? page + pageMenuLen : pagesCnt }" />

			<c:set var="pageBaseUri"
				value="?searchKeywordType=${searchKeywordType }&searchKeyword=${searchKeyword }" />

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
</div>

<%@ include file="../../usr/common/foot.jsp"%>