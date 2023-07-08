<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html class="no-js" lang="en">
<head>
    <meta charset="utf-8">
    <title>Start</title>
    <link rel="stylesheet" href="css/start/style.css">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
</head>
<body class="ss-preload">

<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : (param.lang != null ? param.lang : 'en_US')}"/>
<fmt:setBundle basename="translations"/>

<div id="preloader">
    <div id="loader">
        <div></div>
        <div></div>
        <div></div>
    </div>
</div>
<header>
    <div class="row">
        <div class="column">
            <h1><fmt:message key="page.start.title"/></h1>
            <p class="lead">
                <fmt:message key="page.start.content"/>
            </p>
        </div>
    </div>
</header>
<main>
    <div class="row">
        <div class="column">
            <div class="entry__thumb">
                <a href="resume">
                    <img src="img/start/UI1.jpg" alt="">
                </a>
            </div>
            <div class="entry__title">
                <h3><fmt:message key="page.start.interface1"/></h3>
            </div>
        </div>
        <div class="column">
            <div class="entry__thumb">
                <a href="resumeAlt">
                    <img src="img/start/UI2.jpg" alt="">
                </a>
            </div>
            <div class="entry__title">
                <h3><fmt:message key="page.start.interface2"/></h3>
            </div>
        </div>
    </div>
</main>

<script>
    (function (html) {
        'use strict';
        html.className = html.className.replace(/\bno-js\b/g, '') + 'js';
        const body = document.querySelector('body');
        const preloader = document.querySelector('#preloader');
        if (!preloader) return;
        window.addEventListener('load', function () {
            body.classList.remove('ss-preload');
            body.classList.add('ss-loaded');
            preloader.addEventListener('transitionend', function afterTransition(e) {
                if (e.target.matches('#preloader')) {
                    body.classList.add('ss-show');
                    e.target.style.display = 'none';
                    preloader.removeEventListener(e.type, afterTransition);
                }
            });
        });
    })(document.documentElement);
</script>
</body>
</html>
