<%@ page import="org.database.resume.model.SectionType" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="css/view2/style.css">
    <link rel="stylesheet" href="css/view2/list.css">
    <link rel="stylesheet" href="css/view2/theme/${theme}.css">
    <fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : (param.lang != null ? param.lang : 'en_US')}"/>
    <fmt:setBundle basename="translations"/>
    <title><fmt:message key="page.view.list.title"/></title>
</head>
<body>

<div class="themes">
    <div class="theme-title"><fmt:message key="page.view.list.theme"/></div>
    <div class="theme-selector">
        <form action="" method="GET">
            <select name="theme" onchange="this.form.submit()">
                <option value="light" ${theme == null || theme == 'light' ? 'selected' : ''}><fmt:message key="page.view.list.theme.light"/></option>
                <option value="dark" ${theme == 'dark' ? 'selected' : ''}><fmt:message key="page.view.list.theme.dark"/></option>
            </select>
        </form>
    </div>
</div>
<%@ include file="/WEB-INF/jsp/view2/fragments/header.jsp" %>
<div class="scrollable-panel">
    <div class="table-wrapper">
        <div class="add-resume">
            <div class="exit-resume">
                <a class="no-underline-anchor" href="logout"><img src="img/view2/${theme}/exit.png" alt=""></a>
                <a class="text-anchor" href="logout"><p class="add-resume-title"><fmt:message key="page.view.list.exit"/></p></a>
            </div>
            <a class="no-underline-anchor" href="resumeAlt?action=add&theme=${theme}"><img src="img/view2/${theme}/add.svg" alt=""></a>
            <a class="text-anchor" href="resumeAlt?action=add&theme=${theme}"><p class="add-resume-title"><fmt:message key="page.view.list.add"/></p></a>
        </div>

        <div class="resumes-list">
            <table>
                <tr class="t-header">
                    <th class="name-column"><fmt:message key="page.view.list.name"/></th>
                    <th class="info-column"><fmt:message key="page.view.list.position"/></th>
                    <th class="img-column"><fmt:message key="page.view.list.edit"/></th>
                    <th class="img-column"><fmt:message key="page.view.list.copy"/></th>
                    <th class="img-column"><fmt:message key="page.view.list.delete"/></th>
                </tr>
                <c:forEach var="resume" items="${resumes}">
                    <jsp:useBean id="resume" type="org.database.resume.model.Resume"/>
                    <tr class="t-body">
                        <td class="name-column"><a class="contact-link"
                                                   href="resumeAlt?uuid=${resume.uuid}&action=view&theme=${theme}">${resume.fullName}</a>
                        </td>
                        <td class="info-column">${resume.getSection(SectionType.OBJECTIVE).content}</td>
                        <td class="img-column"><a class="no-underline-anchor"
                                                  href="resumeAlt?uuid=${resume.uuid}&action=edit&theme=${theme}"><img
                                src="img/view2/${theme}/edit.svg" alt=""></a></td>
                        <td class="img-column"><a class="no-underline-anchor"
                                                  href="resumeAlt?uuid=${resume.uuid}&action=copy&theme=${theme}"><img
                                src="img/view2/${theme}/copy.svg" alt=""></a></td>
                        <td class="img-column"><a class="no-underline-anchor"
                                                  href="resumeAlt?uuid=${resume.uuid}&action=delete&theme=${theme}"><img
                                src="img/view2/${theme}/remove.svg" alt=""></a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jsp/view2/fragments/footer.jsp" %>
</body>
</html>
