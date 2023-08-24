<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="가챠 갤러리" />

<%@ include file="../common/head.jsp"%>

<script>
	function originalImgShow(id) {
		
		const orgImg = $('#original-img').html();
		console.log(orgImg);
		let fileId = id;
		console.log(fileId);
		
		let tag = `
					<div id="original-img-div" onclick="backToInitImg();">
						<img src="/usr/gacha/file/\${fileId}"/>
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
				value="${rq.getLoginedMemberId() }" /> <input type="file"
				class="file-input file-input-bordered file-input-xs max-w-sm"
				name="file" />
			<button class="btn btn-xs">이미지 업로드</button>
		</form>
	</div>
	<!-- 이미지 리스트 -->
	<c:set var="files" value="${files }"></c:set>

	<div class="overflow-x-auto">

		<table class="table">
			<thead>
				<tr>
					<th>No.</th>
					<th>Img</th>
					<th>WriterName</th>
					<th>RegDate</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="file" items="${files }">
					<tr>
						<td>${file.id }</td>
						<td>
							<div>
								<button onclick="originalImgShow(${file.id});">
									<img src="/usr/gacha/file/${file.id}"
										style="width: 100px; height: 100px;" />
								</button>
							</div>
						</td>
						<td>${file.writerName }</td>
						<td>${file.regDate }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<%@ include file="../common/foot.jsp"%>