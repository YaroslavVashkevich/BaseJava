<%@ page import="org.database.resume.model.*" %>
<%@ page import="org.database.resume.util.HtmlUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="css/view2/style.css">
    <link rel="stylesheet" href="css/view2/view.css">
    <link rel="stylesheet" href="css/view2/theme/${theme}.css">
    <jsp:useBean id="resume" type="org.database.resume.model.Resume" scope="request"/>
    <fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : (param.lang != null ? param.lang : 'en_US')}"/>
    <fmt:setBundle basename="translations"/>
    <title><fmt:message key="page.view.view.title"/> ${resume.fullName}</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/view2/fragments/header.jsp" %>
<div class="scrollable-panel">
    <div class="form-wrapper">
        <div class="full-name">${resume.fullName}
            <a href="resumeAlt?uuid=${resume.uuid}&action=edit&theme=${theme}"><img src="img/view2/${theme}/edit.svg" alt=""></a>
        </div>
        <div class="contacts">
            <c:forEach var="contactEntry" items="${resume.contacts}">
                <jsp:useBean id="contactEntry"
                             type="java.util.Map.Entry<org.database.resume.model.ContactType, java.lang.String>"/>
                <div><%=contactEntry.getKey().toHtml(contactEntry.getValue())%>
                </div>
            </c:forEach>
        </div>
        <div class="spacer"></div>
        <c:forEach var="sectionEntry" items="${resume.sections }">
            <jsp:useBean id="sectionEntry"
                         type="java.util.Map.Entry<org.database.resume.model.SectionType, org.database.resume.model.Section>"/>
            <c:set var="type" value="${sectionEntry.key}"/>
            <c:set var="section" value="${sectionEntry.value}"/>
            <jsp:useBean id="section" type="org.database.resume.model.Section"/>
            <div class="section">${type.title}</div>
            <c:choose>
                <c:when test="${type=='OBJECTIVE'}">
                    <div class="position"><%=((TextSection) section).getContent()%>
                    </div>
                </c:when>
                <c:when test="${type=='PERSONAL'}">
                    <div class="qualities"><%=((TextSection) section).getContent()%>
                    </div>
                </c:when>
                <c:when test="${type=='QUALIFICATIONS' || type=='ACHIEVEMENT'}">
                    <ul class="list">
                        <c:forEach var="item" items="<%=((ListSection) section).getItems()%>">
                            <li>${item}</li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:when test="${type=='EXPERIENCE' || type=='EDUCATION'}">
                    <c:forEach var="org" items="<%=((OrganizationSection) section).getOrganizations()%>">
                        <div class="section-wrapper">
                            <c:choose>
                                <c:when test="${empty org.homePage.url}">
                                    <div class="job-name">${org.homePage.name}</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="job-name"><a class="contact-link" href="${org.homePage.url}"
                                                             target="_blank">${org.homePage.name}</a></div>
                                </c:otherwise>
                            </c:choose>

                            <c:forEach var="position" items="${org.positions}">
                                <jsp:useBean id="position" type="org.database.resume.model.Organization.Position"/>
                                <div class="period-position">
                                    <div class="period"><%=HtmlUtil.formatDates(position)%>
                                    </div>
                                    <div class="position">${position.title}</div>
                                </div>
                                <c:choose>
                                    <c:when test="${empty position.description}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="description">${position.description}</div>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </c:when>
            </c:choose>
        </c:forEach>
        <div class="footer-spacer"></div>
    </div>
</div>
<%@ include file="/WEB-INF/jsp/view2/fragments/footer.jsp" %>
</body>
</html>
