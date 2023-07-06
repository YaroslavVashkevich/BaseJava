<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js" lang="en">
<head>
    <meta charset="utf-8">
    <title>Start</title>
    <link rel="stylesheet" href="css/start/style.css">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
</head>
<body class="ss-preload">
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
            <h1>Разработка web-приложения «База данных резюме»</h1>
            <p class="lead">
                Используемые технологии: Java, Intellij IDEA, Git, Maven, Log4j2, PostgreSQL, JUnit5, JDBC, Apache
                Tomcat, HTTP, Servlets,JSP/JSTL, Lombok, XML, JSON. Хранение резюме: в памяти на основе массива,
                отсортированного массива, списка и ассоциированного массива(Map), в файловой системе, в стандартной и
                кастомной сериализации Java, в формате JSON (Google Gson), в формате XML (JAXB), в реляционной базе данных
                PostgreSQL. Деплой веб-приложения: в контейнер сервлетов Apache Tomcat, на собственный выделенный сервер.
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
                <h3>User interface №1</h3>
            </div>
        </div>
        <div class="column">
            <div class="entry__thumb">
                <a href="resumeAlt">
                    <img src="img/start/UI2.jpg" alt="">
                </a>
            </div>
            <div class="entry__title">
                <h3>User interface №2</h3>
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