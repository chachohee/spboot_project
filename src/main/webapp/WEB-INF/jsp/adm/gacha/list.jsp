<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="가챠관리" />

<%@ include file="../../usr/common/head.jsp"%>

<script>
	function originalImgShow(id) {
		
		const orgImg = $('#original-img').html();
		console.log(orgImg);
		let fileId = id;
		console.log(fileId);
		
		let tag = `
					<div id="original-img-div" onclick="backToInitImg();">
						<img src="/adm/gacha/file/\${fileId}"/>
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
		console.log(orgImgDiv);
	}
</script>

<div class="container mx-auto my-4">
	<div>
		<form action="upload" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="memberId"
				value="${rq.getLoginedMemberId() }" /> <input type="file" multiple
				class="file-input file-input-bordered file-input-xs max-w-sm"
				name="files" />
			<button class="btn btn-xs">이미지 업로드</button>
		</form>
	</div>
	<div class="mt-4 mb-4 flex justify-between items-end">
		<div class="join">
			<b class="w-24">Total : ${gachaTotalCnt }</b>
			<b class="w-32">In Stock : ${gachaStockCnt }</b> 
			<b>Sold Out : ${gachaSoldOutCnt }</b>
		</div>
		<form>
			<div class="join">
				<select class="select select-bordered join-item"
					data-value="${stock }" class="select select-accent select-sm"
					name="stock">
					<option value="0">Total</option>
					<option value="1">In Stock</option>
					<option value="2">Sold Out</option>
				</select> <select class="select select-bordered join-item"
					data-value="${searchKeywordType }"
					class="select select-accent select-sm" name="searchKeywordType">
					<option value="memberId,id,orgName">전체</option>
					<option value="memberId">회원아이디</option>
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
	<c:set var="files" value="${files }"></c:set>

	<div class="overflow-x-auto">
		<table class="table">
			<thead>
				<tr>
					<th>No</th>
					<th>Img</th>
					<th>ImgName</th>
					<th>RegDate</th>
					<th>MemberID</th>
					<th>GrantDate</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="file" items="${files }">
					<tr>
						<td>${file.id }</td>
						<td>
							<div>
								<button onclick="originalImgShow(${file.id});">
									<img src="/adm/gacha/file/${file.id}"
										style="width: 100px; height: 100px;" />
								</button>
							</div>
						</td>
						<td>${file.orgName }</td>
						<td>${file.regDate }</td>
						<td>${file.memberId }</td>
						<td>${file.grantDate }</td>
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
				value="?stock=${stock }&searchKeywordType=${searchKeywordType }&searchKeyword=${searchKeyword }" />

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