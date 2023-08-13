<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	let msg = '${msg}'.trim();
	
	//자바스크립트 falsy 문법으로 msg만 넣어줘도 코드 문제 없음.
	if(msg){
		alert(msg);
	}
	
	history.back();
</script>