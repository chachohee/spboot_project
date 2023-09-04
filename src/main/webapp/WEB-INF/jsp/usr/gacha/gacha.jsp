<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="가챠 뽑기" />
<%@ include file="../common/head.jsp"%>

<script>
function loading() {
	if (${rq.getLoginedMemberId() == 0}) {
		alert('로그인 후 이용해주세요.');
		return;
	}
	if (${rq.loginedMember.authLevel == 3}) {
		alert('회원만 이용 가능한 기능입니다.');
		return;
	}
    LoadingWithMask();
    setTimeout("closeLoadingWithMask()", 3000);
}
 
function LoadingWithMask() {
    //화면의 높이와 너비를 구합니다.
    var maskHeight = $(document).height();
    var maskWidth  = window.document.body.clientWidth;
     
    //화면에 출력할 마스크를 설정해줍니다.
    var mask       = `<div id="mask"></div>`;
    var loadingImg = '';
    
    loadingImg += `<div id="loadingImg" class="flex justify-center">`;
    loadingImg += `<img src="/resource/images/spinner2.gif" style="width: 200px; height: 200px;"/>`;
    loadingImg += `</div>`;
    
    //화면에 레이어 추가
    $('body')
        .append(mask)
        .append(loadingImg);
 
    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채웁니다.
    $('#mask').css({
            'width' : maskWidth,
            'height': maskHeight,
            'opacity' : '0.3'
    }); 
  
    //마스크 표시
    $('#mask').show();
    //로딩중 이미지 표시
    $('#loadingImg').show();
}
 
function closeLoadingWithMask() {
    $('#mask, #loadingImg').hide();
    $('#mask, #loadingImg').empty();
    
    location.href="/usr/gacha/getGacha";
}
</script>

<div class="flex justify-center">
	<!-- <a href="/usr/gacha/getGacha"><img src="/resource/images/gacha.png"
		style="width: 400px; height: 400px;" />
	</a> -->
	<button onclick="loading();">
		<img src="/resource/images/gacha.png" style="width: 400px; height: 400px;" />
	</button>
</div>
<div class="flex justify-center">
	<span class="kbd kbd-lg">Click The Egg ☝🏻🤩✨</span>
</div>

<%@ include file="../common/foot.jsp"%>