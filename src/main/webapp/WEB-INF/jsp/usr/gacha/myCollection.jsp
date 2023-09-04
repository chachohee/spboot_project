<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="마이컬렉션" />

<%@ include file="../common/head.jsp"%>

<script>
	function originalImgShow(id) {
		
		const orgImg = $('#original-img').html();
		let gachaId = id;
		
		let tag = `
					<div id="original-img-div" onclick="backToInitImg();">
						<img src="/adm/gacha/file/\${gachaId}"/>
					</div>
				`;
				
		$('#original-img').append(tag);
		
		$('#original-img').show();
		$('.original-img-bg').show();

	}
	
	function backToInitImg() {
		const orgImgDiv = document.getElementById("original-img-div");
		
		$('#original-img').hide();
		$('.original-img-bg').hide();
		
		orgImgDiv.remove();
	}
</script>

<div class="container mx-auto my-4">
	<div class="mb-4 flex justify-end">
		<form>
			<div class="join">
				<select class="select select-bordered join-item"
					data-value="${searchKeywordType }"
					class="select select-accent select-sm" name="searchKeywordType">
					<option value="grantDate,id,orgName">전체</option>
					<option value="grantDate">획득일</option>
					<option value="id">이미지 번호</option>
					<option value="orgName">이미지 이름</option>
				</select>
				<div>
					<input class="input input-bordered join-item" type="text"
						name="searchKeyword" placeholder="Search" />
				</div>
				<button class="btn join-item">Search</button>
			</div>
		</form>
	</div>
	<!-- 이미지 리스트 -->
	<div class="overflow-x-auto">
		<table class="table">
			<thead>
				<tr>
					<th>No</th>
					<th>Img</th>
					<th>ImgName</th>
					<th>RegDate</th>
					<th>GrantDate</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="myGacha" items="${myGachas }">
					<tr>
						<td>${myGacha.id }</td>
						<td>
							<div>
								<button onclick="originalImgShow(${myGacha.id});">
									<img src="/adm/gacha/file/${myGacha.id}"
										style="width: 100px; height: 100px;" />
								</button>
							</div>
						</td>
						<td>${myGacha.orgName }</td>
						<td>${myGacha.regDate }</td>
						<td>${myGacha.grantDate }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

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

<%@ include file="../common/foot.jsp"%>