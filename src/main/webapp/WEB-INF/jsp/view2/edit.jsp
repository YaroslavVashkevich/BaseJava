<%@ page import="org.database.resume.model.ContactType" %>
<%@ page import="org.database.resume.model.SectionType" %>
<%@ page import="org.database.resume.model.ListSection" %>
<%@ page import="org.database.resume.model.OrganizationSection" %>
<%@ page import="org.database.resume.util.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="css/view2/style.css">
    <link rel="stylesheet" href="css/view2/edit.css">
    <link rel="stylesheet" href="css/view2/theme/${theme}.css">
    <jsp:useBean id="resume" type="org.database.resume.model.Resume" scope="request"/>
    <fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : (param.lang != null ? param.lang : 'en_US')}"/>
    <fmt:setBundle basename="translations"/>
    <title><fmt:message key="page.view.view.title"/> ${resume.fullName}</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/view2/fragments/header.jsp" %>
<form method="post" action="resumeAlt" enctype="application/x-www-form-urlencoded">
    <input type="hidden" name="uuid" value="${resume.uuid}">
    <input type="hidden" name="theme" value="${theme}">
    <div class="scrollable-panel">
        <div class="form-wrapper">
            <div class="section">ФИО:</div>
            <input class="field" type="text" name="fullName" value="${resume.fullName}" placeholder="ФИО" required>
            <div class="section">Контакты</div>
            <c:forEach var="type" items="${ContactType.values()}">
                <input input class="field" type="text" name="${type.name()}" value="${resume.getContact(type)}"
                       placeholder="${type.title}">
            </c:forEach>
            <div class="spacer"></div>
            <c:forEach var="type" items="${SectionType.values()}">
                <c:set var="section" value="${resume.getSection(type)}"/>
                <jsp:useBean id="section" type="org.database.resume.model.Section"/>
                <div class="field-label">${type.title}</div>
                <c:choose>
                    <c:when test="${type=='OBJECTIVE' || type=='PERSONAL'}">
                        <textarea class="field" name="${type}">${section.content}</textarea>
                    </c:when>
                    <c:when test="${type=='QUALIFICATIONS' || type=='ACHIEVEMENT'}">
                        <textarea class="field"
                                  name="${type}"><%=String.join("\n", ((ListSection) section).getItems())%></textarea>
                    </c:when>
                    <c:when test="${type=='EXPERIENCE' || type=='EDUCATION'}">
                        <c:forEach var="org" items="<%=((OrganizationSection) section).getOrganizations()%>"
                                   varStatus="counter">
                            <c:choose>
                                <c:when test="${counter.index == 0}">
                                </c:when>
                                <c:otherwise>
                                    <div class="spacer"></div>
                                </c:otherwise>
                            </c:choose>
                            <input class="field" type="text" name="${type}" value="${org.homePage.name}"
                                   placeholder="Организация">
                            <input class="field" type="text" name="${type}url" value="${org.homePage.url}"
                                   placeholder="Сайт">
                            <h3>Поля для добавления новой должности</h3>
                            <c:forEach var="position" items="${org.positions}">
                                <jsp:useBean id="position" type="org.database.resume.model.Organization.Position"/>
                                <div class="date-section">
                                    <input class="field date" name="${type}${counter.index}startDate"
                                           value="<%=DateUtil.format(position.getStartDate())%>"
                                           placeholder="Начало работы, ММ/ГГГГ">

                                    <input class="field date date-margin" name="${type}${counter.index}endDate"
                                           value="<%=DateUtil.format(position.getEndDate())%>"
                                           placeholder="Окончание, ММ/ГГГГ">
                                </div>
                                <input class="field" type="text" name="${type}${counter.index}title"
                                       value="${position.title}" placeholder="Должность">
                                <textarea class="field" name="${type}${counter.index}description"
                                          placeholder="Обязанности">${position.description}</textarea>
                            </c:forEach>
                        </c:forEach>
                    </c:when>
                </c:choose>
            </c:forEach>
            <div class="spacer"></div>

            <div class="button-section">
                <button class="red-cancel-button" type="button" onclick="window.history.back()">Отменить</button>
                <button class="green-submit-button" type="submit">Сохранить</button>
            </div>
        </div>
    </div>
</form>
<%@ include file="/WEB-INF/jsp/view2/fragments/footer.jsp" %>
</body>
</html>
