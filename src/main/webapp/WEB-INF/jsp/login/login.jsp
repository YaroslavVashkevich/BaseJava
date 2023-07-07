<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="css/login/style.css">
    <title>Login</title>
</head>
<body>
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
<div class="container">
    <div class="frame">
        <div class="nav">
            <ul>
                <li class="signin-active"><a class="btn">Sign in</a></li>
                <li class="signup-inactive"><a class="btn">Sign up </a></li>
            </ul>
        </div>
        <form class="form-signin" action="login" method="post" enctype="application/x-www-form-urlencoded">
            <label for="email">Email</label>
            <input class="form-styling" type="text" name="email" value="${param.email}" required/>
            <label for="password">Password</label>
            <input class="form-styling" type="text" name="password" required/>
            <input class="btn-in-up" type="submit" value="Sign in"/>
            <c:if test="${param.errorLog != null}">
                <div class="loginError">
                    <span class="inner">Email or password is not correct!</span>
                </div>
            </c:if>
            <c:if test="${param.errorReg != null}">
                <div class="loginError">
                    <span class="inner">Email already exists! Try registering again.</span>
                </div>
            </c:if>
            <c:if test="${param.success != null}">
                <div class="loginSuccess">
                    <span class="inner">You have successfully registered. Enter your email and password.</span>
                </div>
            </c:if>
        </form>
        <form class="form-signup" action="registration" method="post" enctype="application/x-www-form-urlencoded">
            <label for="name">Full name</label>
            <input class="form-styling" type="text" name="name" required/>
            <label for="email">Email</label>
            <input class="form-styling" type="text" name="email" required/>
            <label for="password">Password</label>
            <input class="form-styling" type="text" name="password" required/>
            <input class="btn-in-up" type="submit" value="Sign Up"/>
        </form>
    </div>
</div>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="css/login/index.js"></script>
</body>
</html>

