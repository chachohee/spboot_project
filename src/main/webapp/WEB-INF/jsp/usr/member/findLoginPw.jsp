<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 찾기" />

<%@ include file="../common/head.jsp"%>

<section class=" my-4">
	<div class="container mx-auto">
		<div
			class="card flex-shrink-0 w-full max-w-sm shadow-2xl bg-base-100 mx-auto">
			<div class="card-body">
				<form action="doFindLoginPw" method="POST">
					<div class="form-control">
						<label class="label"> 
							<span class="label-text">Id</span>
						</label> 
						<input type="text" name="loginId" placeholder="id" class="input input-bordered" />
						<label class="label"> 
							<a href="findLoginId" class="label-text-alt link link-hover">Forgot id?</a>
						</label>
					</div>
					<div class="form-control">
						<label class="label"> 
							<span class="label-text">Name</span>
						</label> 
						<input type="text" name="name" placeholder="name" class="input input-bordered" />
					</div>
					<div class="form-control">
						<label class="label"> 
							<span class="label-text">Email</span>
						</label> 
						<input type="text" name="email" placeholder="email"
							class="input input-bordered" /> 
					</div>
					<div class="form-control mt-4">
						<button class="btn btn-primary">비밀번호 찾기</button>
					</div>
				</form>
			</div>
			<div class="mx-auto mb-8">
				<a class="btn btn-sm" href="login">로그인</a>
			</div>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jsp"%>