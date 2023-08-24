<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인페이지" />
<%@ include file="../common/head.jsp"%>

<div class="hero min-h-screen bg-base-200">
	<div class="hero-content text-center">
		<div class="max-w-md">
			<h1 class="text-5xl font-bold">Hello there</h1>
			<p class="py-6">Provident cupiditate voluptatem et in. Quaerat
				fugiat ut assumenda excepturi exercitationem quasi. In deleniti
				eaque aut repudiandae et a id nisi.</p>
			<a href="../gacha/gacha" class="btn btn-primary">Get Started</a>
		</div>
	</div>
</div>

<footer class="footer p-10 bg-base-200 text-base-content">
	<div>
		<span class="footer-title">Services</span> <a class="link link-hover">Branding</a>
		<a class="link link-hover">Design</a> <a class="link link-hover">Marketing</a>
		<a class="link link-hover">Advertisement</a>
	</div>
	<div>
		<span class="footer-title">Company</span> <a class="link link-hover">About
			us</a> <a class="link link-hover">Contact</a> <a class="link link-hover">Jobs</a>
		<a class="link link-hover">Press kit</a>
	</div>
	<div>
		<span class="footer-title">Legal</span> <a class="link link-hover">Terms
			of use</a> <a class="link link-hover">Privacy policy</a> <a
			class="link link-hover">Cookie policy</a>
	</div>
	<div>
		<span class="footer-title">Newsletter</span>
		<div class="form-control w-80">
			<label class="label"> <span class="label-text">Enter
					your email address</span>
			</label>
			<div class="relative">
				<input type="text" placeholder="username@site.com"
					class="input input-bordered w-full pr-16" />
				<button
					class="btn btn-primary absolute top-0 right-0 rounded-l-none">Subscribe</button>
			</div>
		</div>
	</div>
</footer>

</body>
</html>