<%@ page import="org.database.resume.model.SectionType" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="css/view2/style.css">
    <link rel="stylesheet" href="css/view2/list.css">
    <title>Список резюме</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/view2/fragments/header.jsp" %>
<div class="scrollable-panel">
    <div class="table-wrapper">
        <div class="add-resume">
            <a class="no-underline-anchor" href="resumeAlt?action=add"><img src="img/view2/add.svg" alt=""></a>
            <a class="text-anchor" href="resumeAlt?action=add"><p class="add-resume-title">Добавить резюме</p></a>
        </div>
        <div class="resumes-list">
            <table>
                <tr class="t-header">
                    <th class="name-column">Имя</th>
                    <th class="info-column">Должность</th>
                    <th class="img-column">Редактировать</th>
                    <th class="img-column">Копировать</th>
                    <th class="img-column">Удалить</th>
                </tr>
                <c:forEach var="resume" items="${resumes}">
                    <jsp:useBean id="resume" type="org.database.resume.model.Resume"/>
                    <tr class="t-body">
                        <td class="name-column"><a class="contact-link"
                                                   href="resumeAlt?uuid=${resume.uuid}&action=view">${resume.fullName}</a>
                        </td>
                        <td class="info-column">${resume.getSection(SectionType.OBJECTIVE).content}</td>
                        <td class="img-column"><a class="no-underline-anchor"
                                                  href="resumeAlt?uuid=${resume.uuid}&action=edit"><img
                                src="img/view2/edit.svg" alt=""></a></td>
                        <td class="img-column"><a class="no-underline-anchor"
                                                  href="resumeAlt?uuid=${resume.uuid}&action=copy"><img
                                src="img/view2/copy.svg" alt=""></a></td>
                        <td class="img-column"><a class="no-underline-anchor"
                                                  href="resumeAlt?uuid=${resume.uuid}&action=delete"><img
                                src="img/view2/remove.svg" alt=""></a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jsp/view2/fragments/footer.jsp" %>
</body>
</html>
