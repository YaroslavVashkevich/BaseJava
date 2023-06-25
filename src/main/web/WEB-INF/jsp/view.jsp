<%@ page import="org.database.resume.model.*" %>
<%@ page import="org.database.resume.util.HtmlUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <jsp:useBean id="resume" type="org.database.resume.model.Resume" scope="request"/>
    <title>Резюме ${resume.fullName}</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/fragments/header.jsp" %>
    <h2>${resume.fullName}&nbsp;<a href="resume?uuid=${resume.uuid}&action=edit"><img src="img/editView.png" title="Редактировать"></a></h2>
    <p>
        <c:forEach var="contactEntry" items="${resume.contacts}">
            <jsp:useBean id="contactEntry"
                         type="java.util.Map.Entry<org.database.resume.model.ContactType, java.lang.String>"/>
            <%=contactEntry.getKey().toHtml(contactEntry.getValue())%><br/>
        </c:forEach>
    </p>
    <hr>
    <table cellpadding="2">
        <c:forEach var="sectionEntry" items="${resume.sections }">
            <jsp:useBean id="sectionEntry" type="java.util.Map.Entry<org.database.resume.model.SectionType, org.database.resume.model.Section>"/>
            <c:set var="type" value="${sectionEntry.key}"/>
            <c:set var="section" value="${sectionEntry.value}"/>
            <jsp:useBean id="section" type="org.database.resume.model.Section"/>
            <tr>
                <td><h3>${type.title}</h3></td>
            </tr>
            <tr>
                <td>
                    <c:if test="${type=='OBJECTIVE'}">
                    <%=((TextSection) section).getContent()%>
                    </c:if>
                </td>
            </tr>
            <c:if test="${type !='OBJECTIVE'}">
                <c:choose>
                    <c:when test="${type=='PERSONAL'}">
                        <tr>
                            <td>
                                <%=((TextSection) section).getContent()%>
                            </td>
                        </tr>
                    </c:when>
                    <c:when test="${type=='QUALIFICATIONS' || type=='ACHIEVEMENT'}">
                        <tr>
                            <td>
                                <ul>
                                    <c:forEach var="item" items="<%=((ListSection) section).getItems()%>">
                                        <li>${item}</li>
                                    </c:forEach>
                                </ul>
                            </td>
                        </tr>
                    </c:when>
                    <c:when test="${type=='EXPERIENCE' || type=='EDUCATION'}">
                        <c:forEach var="org" items="<%=((OrganizationSection) section).getOrganizations()%>">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty org.homePage.url}">
                                            <h4>${org.homePage.name}</h4>
                                        </c:when>
                                        <c:otherwise>
                                            <h4><a href="${org.homePage.url}">${org.homePage.name}</a></h4>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <c:forEach var="position" items="${org.positions}">
                                <jsp:useBean id="position" type="org.database.resume.model.Organization.Position"/>
                                <tr>
                                    <td><%=HtmlUtil.formatDates(position)%>
                                    </td>
                                    <td><b>${position.title}</b><br>${position.description}</td>
                                </tr>
                            </c:forEach>
                        </c:forEach>
                    </c:when>
                </c:choose>
            </c:if>
        </c:forEach>
    </table>
    <form action="resume">
        <button>К списку резюме</button>
    </form>
<%@ include file="/WEB-INF/jsp/fragments/footer.jsp" %>
</body>
</html>
