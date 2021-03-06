<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="msapplication-tap-highlight" content="no">
  <title>用户登录</title>

  <!-- Favicons-->
  <link rel="icon" href="assets/images/favicon/favicon-32x32.png" sizes="32x32">
  <!-- Favicons-->
  <link rel="apple-touch-icon-precomposed" href="assets/images/favicon/apple-touch-icon-152x152.png">
  <!-- For iPhone -->
  <meta name="msapplication-TileColor" content="#00bcd4">
  <meta name="msapplication-TileImage" content="assets/images/favicon/mstile-144x144.png">
  <!-- For Windows Phone -->

  <!-- CORE CSS-->
  <link href="assets/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="assets/css/style.min.css" type="text/css" rel="stylesheet" media="screen,projection">
  <!-- Custome CSS-->    
  <link href="assets/css/custom/custom.min.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="assets/css/layouts/page-center.css" type="text/css" rel="stylesheet" media="screen,projection">

  <!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
  <link href="assets/js/plugins/prism/prism.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="assets/js/plugins/perfect-scrollbar/perfect-scrollbar.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="assets/css/my.css" type="text/css" rel="stylesheet" media="screen,projection">
  
</head>

<body class="cyan">
  <!-- Start Page Loading -->
  <div id="loader-wrapper">
      <div id="loader"></div>        
      <div class="loader-section section-left"></div>
      <div class="loader-section section-right"></div>
  </div>
  <!-- End Page Loading -->

  <div id="login-page" class="row">
    <div class="col s12 z-depth-4 card-panel">
      <form id="form" class="login-form right-alert" action="doLogin">
        <div class="row">
          <div class="input-field col s12 center">
            <img src="assets/images/login-logo.png" alt="" class="circle responsive-img valign profile-image-login">
            <p class="center login-form-text">用户登录</p>
          </div>
        </div>
        <div class="row margin">
          <div class="input-field col s12">
            <i class="mdi-social-person-outline prefix"></i>
            <input id="username" class="validate" name="username" type="text">
            <label for="username" data-error="请输入用户名.">用户名</label>
          </div>
        </div>
        <div class="row margin">
          <div class="input-field col s12">
            <i class="mdi-action-lock-outline prefix"></i>
            <input id="password" name="password" type="password" class="validate">
            <label for="password" data-error="Please enter valid url.">密码</label>
          </div>
        </div>
        <div class="row">          
          <div class="input-field col s12 m12 l12  login-text">
              <input type="checkbox" id="remember-me" />
              <label for="remember-me">记住我</label>
          </div>
        </div>
        <div class="row">
          <div class="input-field col s12">
            <input id="userType" name="userType" class="hide" type="text" value="3">
            <button id="submit" type="button" class="btn waves-effect waves-light col s12">登录</button>
          </div>
        </div>
        <div class="row">
          <div class="input-field col s6 m6 l6">
            <p class="margin medium-small"><a href="page-register.html">注册</a></p>
          </div>
          <div class="input-field col s6 m6 l6">
              <p class="margin right-align medium-small"><a href="page-forgot-password.html">忘记密码</a></p>
          </div>          
        </div>
      </form>
    </div>
  </div>

  <!-- jQuery Library -->
  <script type="text/javascript" src="assets/js/plugins/jquery-1.11.2.min.js"></script>
  <script type="text/javascript" src="assets/js/plugins/angular.min.js"></script>
  <script type="text/javascript" src="assets/js/plugins/jquery-validation/jquery.validate.js"></script>
  <script type="text/javascript" src="assets/js/plugins/jquery-validation/additional-methods.js"></script>
  <!--angularjs-->
  <!--materialize js-->
  <script type="text/javascript" src="assets/js/materialize.js"></script>
  <!--prism-->
  <script type="text/javascript" src="assets/js/plugins/prism/prism.js"></script>
  <!--scrollbar-->
  <script type="text/javascript" src="assets/js/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
  <!--plugins.js - Some Specific JS codes for Plugin Settings-->
  <script type="text/javascript" src="assets/js/plugins.min.js"></script>
  <script type="text/javascript" src="assets/scripts/path.js"></script>
  
  <script type="text/javascript">
	$(document).ready(function() {
		$("#form").validate({
	        rules: {
	        	username: {
	                required: true
	            },
	            password: {
					required: true,
					minlength:6
				}
	        },
	        //For custom messages
	        messages: {
	            password:{
	                required: "请输入密码",
	                minlength: "密码至少6位"
	            },
	            username : {
	                required: "请输入用户名"
	            }
	        }
	     });
		
		$("#submit").click(function(){
			 $.ajax({
				cache: false,
				url:getProjectName()+'/doLogin',
				dataType:'json',
				data:$("#form").serialize(),
				type: "POST",
				async: true,
				success:function(result){
					if(result.status==1){
						window.location.href='main';
					}else{
						$("#password").closest(".input-field").children("label").attr("data-error",result.info);
						$("#password").addClass("invalid");
					}
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					$("#password").closest(".input-field").children("label").attr("data-error","登录失败");
					$("#password").addClass("invalid");
				}
			});
		});
		
  	});
	
		
  </script>
</body>

</html>