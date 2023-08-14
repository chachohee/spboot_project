<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 확인" />
<%@ include file="../common/head.jsp"%>

<section class="my-4">
	<div class="container mx-auto">
		<div
			class="card flex-shrink-0 w-full max-w-sm shadow-2xl bg-base-100 mx-auto">
			<div class="card-body">
				<form action="doPasswordChk" method="post">
					<div class="form-control">
						<label class="label"> <span class="label-text">Id</span>
						</label><span class="text-primary text-lg">${rq.loginedMember.loginId }</span>
					</div>
					<div class="form-control">
						<label class="label"> <span class="label-text">Password</span>
						</label> <input type="password" name="loginPw" placeholder="password"
							class="input input-bordered" />
					</div>
					<div class="form-control mt-6">
						<button class="btn btn-primary">비밀번호 확인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jsp"%>