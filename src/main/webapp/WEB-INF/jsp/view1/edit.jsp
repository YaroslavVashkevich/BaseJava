<%@ page import="org.database.resume.model.ContactType" %>
<%@ page import="org.database.resume.model.SectionType" %>
<%@ page import="org.database.resume.model.ListSection" %>
<%@ page import="org.database.resume.model.OrganizationSection" %>
<%@ page import="org.database.resume.util.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/view1/style.css">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <jsp:useBean id="resume" type="org.database.resume.model.Resume" scope="request"/>
    <title>Резюме ${resume.fullName}</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/view1/fragments/header.jsp" %>
<form method="post" action="resume" enctype="application/x-www-form-urlencoded">
    <input type="hidden" name="uuid" value="${resume.uuid}">
    <dl>
        <dt>Имя:</dt>
        <dd><input type="text" name="fullName" size="50" value="${resume.fullName}"></dd>
    </dl>
    <h3>Контакты</h3>
    <c:forEach var="type" items="${ContactType.values()}">
        <dl>
            <dt>${type.title}</dt>
            <dd><input type="text" name="${type.name()}" size="30" value="${resume.getContact(type)}"></dd>
        </dl>
    </c:forEach>
    <hr>
    <c:forEach var="type" items="${SectionType.values()}">
        <c:set var="section" value="${resume.getSection(type)}"/>
        <jsp:useBean id="section" type="org.database.resume.model.Section"/>
        <h3><a>${type.title}</a></h3>
        <c:choose>
            <c:when test="${type=='OBJECTIVE'}">
                <input type="text" name="${type}" size=75 value="${section.content}">
            </c:when>
            <c:when test="${type=='PERSONAL'}">
                <textarea name="${type}" cols=75 rows=5>${section.content}</textarea>
            </c:when>
            <c:when test="${type=='QUALIFICATIONS' || type=='ACHIEVEMENT'}">
                <textarea name="${type}" cols=75
                          rows=5><%=String.join("\n", ((ListSection) section).getItems())%></textarea>
            </c:when>
            <c:when test="${type=='EXPERIENCE' || type=='EDUCATION'}">
                <c:forEach var="org" items="<%=((OrganizationSection) section).getOrganizations()%>"
                           varStatus="counter">
                    <dl>
                        <dt>Название учреждения:</dt>
                        <dd><input type="text" name="${type}" size=100 value="${org.homePage.name}"></dd>
                    </dl>
                    <dl>
                        <dt>Сайт учреждения:</dt>
                        <dd><input type="text" name="${type}url" size=100 value="${org.homePage.url}"></dd>
                    </dl>
                    <br>
                    <div style="margin-left: 30px">
                        <c:forEach var="position" items="${org.positions}">
                            <jsp:useBean id="position" type="org.database.resume.model.Organization.Position"/>
                            <dl>
                                <dt>Начальная дата:</dt>
                                <dd>
                                    <input type="text" name="${type}${counter.index}startDate" size=10
                                           value="<%=DateUtil.format(position.getStartDate())%>" placeholder="MM/yyyy">
                                </dd>
                            </dl>
                            <dl>
                                <dt>Конечная дата:</dt>
                                <dd>
                                    <input type="text" name="${type}${counter.index}endDate" size=10
                                           value="<%=DateUtil.format(position.getEndDate())%>"
                                           placeholder="MM/yyyy">
                                </dd>
                            </dl>
                            <dl>
                                <dt>Должность:</dt>
                                <dd>
                                    <input type="text" name="${type}${counter.index}title" size=75
                                           value="${position.title}">
                                </dd>
                            </dl>
                            <dl>
                                <dt>Описание:</dt>
                                <dd>
                                    <textarea name="${type}${counter.index}description" rows=2
                                              cols=75>${position.description}</textarea>
                                </dd>
                            </dl>
                        </c:forEach>
                    </div>

                </c:forEach>
            </c:when>
        </c:choose>
    </c:forEach>
    <button type="submit">Сохранить</button>
</form>
<form action="resume">
    <button>Отменить</button>
</form>
<%@ include file="/WEB-INF/jsp/view1/fragments/footer.jsp" %>
</body>
</html>
