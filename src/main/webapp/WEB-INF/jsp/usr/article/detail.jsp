<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="글 상세보기" />

<%@ include file="../common/head.jsp"%>

<script>	
	function getReactionPoint(){
		
		$.get('../reactionPoint/getReactionPoint', {
			relTypeCode : 'article',
			relId : ${article.id }
		}, function(data){
		
		console.log(data);
		console.log(data.data1.sumReactionPoint);
			
			if (data.data1.sumReactionPoint > 0){
				let goodBtn = $('#goodBtn');
				goodBtn.removeClass('btn-outline');
				goodBtn.attr('href', '../reactionPoint/doDeleteReactionPoint?relTypeCode=article&relId=${article.id }&point=1');
			} else if (data.data1.sumReactionPoint < 0){
				let badBtn = $('#badBtn');
				badBtn.removeClass('btn-outline');
				badBtn.prop('href', '../reactionPoint/doDeleteReactionPoint?relTypeCode=article&relId=${article.id }&point=-1')
			}
		}, 'json')
	}
	getReactionPoint();
</script>

<div class="container mx-auto my-4">
	<div class="overflow-x-auto">
		<table class="table">
			<tr>
				<th>글 번호</th>
				<td>${article.id }</td>
			</tr>
			<tr>
				<th>추천</th>
				<td><c:if test="${rq.getLoginedMemberId() != 0 }">
						<a id="goodBtn" class="btn btn-outline btn-error"
							href="../reactionPoint/doInsertReactionPoint?relTypeCode=article&relId=${article.id }&point=1">👍</a>
					</c:if> <span class="ml-3">좋아요: ${article.goodReactionPoint }</span></td>
				<td><c:if test="${rq.getLoginedMemberId() != 0 }">
						<a id="badBtn" class="btn btn-outline btn-error"
							href="../reactionPoint/doInsertReactionPoint?relTypeCode=article&relId=${article.id }&point=-1">👎</a>
					</c:if> <span class="ml-3">싫어요: ${article.badReactionPoint }</span></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${article.writerName }</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${article.title }</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${article.getForPrintBody() }</td>
			</tr>
		</table>
	</div>
	<div class="mt-4">
		<a class="btn btn-sm" href="list?boardId=${article.boardId }">목록</a>
		<c:if test="${loginedMemberId == article.memberId }">
			<a class="btn btn-sm" href="modify?id=${article.id }">수정</a>
			<a class="btn btn-sm" href="doDelete?id=${article.id }&boardId=${article.boardId }"
				onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a>
		</c:if>
	</div>
	
	<!-- 댓글 -->
	<script>
	originalId = null;
	originalForm = null;

	function replyModify_getForm(replyId, i){
		
		if(originalForm != null){
			replyModify_cancel(originalId);
		}
		
		$.get('../reply/getReplyContent', {
			id : replyId
		}, function(data){
			
			let replyContent = $('#' + i);
			
			originalId = i;
			originalForm = replyContent.html();
			
			let addHtml = `
				<form action="../reply/doModify" method="post">
					<input type="hidden" name="id" value="\${data.data1.id}" />
					<div class="mt-4 border border-white-400 rounded-lg p-4">
						<div class="mb-2">
							<span>${rq.loginedMember.nickname }</span>
						</div>
						<textarea class="textarea textarea-primary w-full" name="body">\${data.data1.body}</textarea>
						<div class="mt-2 flex justify-end">
							<a class="btn btn-outline btn-sm mr-2" onclick="replyModify_cancel(\${i});">취소</a>
							<button class="btn btn-outline btn-sm">수정</button>
						</div>
					</div>
				</form>
			`;
			
			replyContent.empty().html('');
			replyContent.append(addHtml);
		}, 'json')
	}
	
	function replyModify_cancel(i){
		let replyContent = $('#' + i);
		replyContent.html(originalForm);
		
		originalId = null;
		originalForm = null;
	}
</script>

	<h1 class="mt-8">댓글</h1>
	<!-- 댓글 폼, 댓글 리스트 주석
	<c:if test="${rq.loginedMemberId != 0 }">
		<form action="../reply/doWrite" method="post">
			<input type="hidden" name="relTypeCode" value="article" /> <input
				type="hidden" name="relId" value="${article.id }" />
			<div class="mt-4 border border-gray-400 p-4">
				<div class="mb-2">
					<span>댓글 작성자 : ${rq.loginedMember.nickname }</span>
				</div>
				<textarea class="textarea textarea-bordered w-full" name="body"
					placeholder="댓글을 남겨보세요."></textarea>
				<div class="mt-2 flex justify-end">
					<button class="btn btn-xs">등록</button>
				</div>
			</div>
		</form>
	</c:if>
	
	
	<c:forEach var="reply" items="${replies }" varStatus="status">
		<div id="${status.count }" class="py-2 pl-16 border-bottom-line">
			<div class="flex justify-between items-end text-sm">
				<div class="font-semibold">
					<span>${reply.writerName }</span>
				</div>
				<c:if test="${rq.getLoginedMemberId() == reply.memberId }">
					<div class="dropdown">
						<button class="btn btn-square btn-ghost btn-sm mr-10">
							<svg xmlns="http://www.w3.org/2000/svg" fill="none"
								viewBox="0 0 24 24" class="inline-block w-5 h-5 stroke-current">
								<path stroke-linecap="round" stroke-linejoin="round"
									stroke-width="2"
									d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path></svg>
						</button>
						<ul tabindex="0"
							class="menu menu-sm dropdown-content mt-3 z-[1] p-2 shadow bg-base-100 rounded-box w-18">
							<li><a
								onclick="replyModify_getForm(${reply.id}, ${status.count});">수정</a></li>
							<li><a href="../reply/doDelete?id=${reply.id }"
								onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a></li>
						</ul>
					</div>
				</c:if>
			</div>
			<div class="pl-4">
				<span>${reply.getForPrintBody() }</span>
			</div>
			<div class="text-xs text-gray-400">
				<span>${reply.regDate }</span>
			</div>
		</div>
	</c:forEach>
	-->
	<!-- end 댓글 -->
	
	<!-- ajax 댓글 추가 -->
	<div id="reply-write">
		<input type="text" id="reply" placeholder="댓글을 입력해주세요." />
		<button id="replyWriteBtn" onclick="doWriteReply(${article.id })">댓글 등록</button>
	</div>
	
	<!-- 처음 상세보기 들어갈 때 댓글 리스트 보이게 -->
	<div>
		<table id="reply-list" class="table">
			<tr>
				<th>댓글 번호</th>
				<th>작성자</th>
				<th>댓글 내용</th>
				<th>등록일</th>
			</tr>
		<c:forEach var="reply" items="${replies }" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>${reply.writerName }</td>
				<td>${reply.forPrintBody }</a></td>
				<td>${reply.regDate }</td>
			</tr>
		</c:forEach>
		</table>
	</div>

	<script>
	function doWriteReply(relId){
		let reply = $('#reply').val();
		// console.log(reply);
		// console.log(relId);
		
		// 댓글 입력 안 하면 알럿하고 입력창에 포커즈
		if ($('#reply').val().length == 0){
			alert('댓글을 입력해주세요.');
			$('#reply').focus();
			return;
		}
		
		$.ajax({
			type: 'POST',
			url: '../reply/doWrite',
			data: {
				"relTypeCode" : 'article',
				"relId" : relId, 
				"body" : reply,
			},
			success: function(res){
				// console.log("success", res);
				
				let replyArray = res.data1;
				console.log(replyArray);
				
				let output = `<tr>
								<th>댓글 번호</th>
								<th>작성자</th>
								<th>댓글 내용</th>
								<th>등록일</th>
							</tr>`;
				for (let i in replyArray) {
					output += "<tr>";
					output += "<td>" + replyArray[i].id + "</td>";
					output += "<td>" + replyArray[i].writerName + "</td>";
					output += "<td>" + replyArray[i].forPrintBody + "</td>";
					output += "<td>" + replyArray[i].regDate + "</td>";
					output += "</tr>";
				}
				
				// $('#reply-list').innerHTML = output;
				document.getElementById("reply-list").innerHTML = output;
				$('#reply').val("");
			},
			error: function(err){
				console.log("error", err);
			}
		});
	}
	</script>
	
</div>

<%@ include file="../common/foot.jsp"%>