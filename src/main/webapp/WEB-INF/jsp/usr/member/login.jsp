<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="로그인" />

<%@ include file="../common/head.jsp"%>

<section class=" my-4">
	<div class="container mx-auto">
		<div
			class="card flex-shrink-0 w-full max-w-sm shadow-2xl bg-base-100 mx-auto">
			<div class="card-body">
				<form action="doLogin" method="post">
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
							<span class="label-text">Password</span>
						</label> 
						<input type="password" name="loginPw" placeholder="password"
							class="input input-bordered" /> 
						<label class="label"> 
							<a href="findLoginPw" class="label-text-alt link link-hover">Forgot password?</a>
						</label>
					</div>
					<div class="form-control mt-6">
						<button class="btn btn-primary">Login</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jsp"%>