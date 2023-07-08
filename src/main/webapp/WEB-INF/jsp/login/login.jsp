<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="css/login/style.css">
    <title>Login</title>
</head>
<body>
<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : (param.lang != null ? param.lang : 'en_US')}"/>
<fmt:setBundle basename="translations"/>

<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
<div class="container">

    <div class="frame">
        <div class="en-ru">
            <form action="${pageContext.request.contextPath}/locale" method="post">
                <button class="btn-en-ru" type="submit" name="lang" value="en_US">EN</button>
                <button class="btn-en-ru" type="submit" name="lang" value="ru_RU">RU</button>
            </form>
        </div>
        <div class="nav">
            <ul>
                <li class="signin-active"><a class="btn"><fmt:message key="page.login.signin"/></a></li>
                <li class="signup-inactive"><a class="btn"><fmt:message key="page.login.signup"/></a></li>
            </ul>
        </div>
        <form class="form-signin" action="login" method="post" enctype="application/x-www-form-urlencoded">
            <label for="email"><fmt:message key="page.login.email"/></label>
            <input class="form-styling" type="text" name="email" required/>
            <label for="password"><fmt:message key="page.login.password"/></label>
            <input class="form-styling" type="text" name="password" required/>
            <input class="btn-in-up" type="submit" value="<fmt:message key="page.login.signin"/>"/>
            <c:if test="${param.errorLog != null}">
                <div class="loginError">
                    <span class="inner"><fmt:message key="page.login.error.notcorrect"/></span>
                </div>
            </c:if>
            <c:if test="${param.errorReg != null}">
                <div class="loginError">
                    <span class="inner"><fmt:message key="page.login.error.exist"/></span>
                </div>
            </c:if>
            <c:if test="${param.success != null}">
                <div class="loginSuccess">
                    <span class="inner"><fmt:message key="page.login.success"/></span>
                </div>
            </c:if>
        </form>

        <form class="form-signup" action="registration" method="post" enctype="application/x-www-form-urlencoded">
            <label for="name"><fmt:message key="page.login.name"/></label>
            <input class="form-styling" type="text" name="name" required/>
            <label for="email"><fmt:message key="page.login.email"/></label>
            <input class="form-styling" type="text" name="email" required/>
            <label for="password"><fmt:message key="page.login.password"/></label>
            <input class="form-styling" type="text" name="password" required/>
            <input class="btn-in-up" type="submit" value="<fmt:message key="page.login.signup"/>"/>
        </form>
    </div>
</div>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="css/login/index.js"></script>
</body>
</html>

