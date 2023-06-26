<%@ page import="org.database.resume.model.ContactType" %>
<%@ page import="org.database.resume.model.SectionType" %>
<%@ page import="org.database.resume.model.TextSection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/view1/style.css">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <title>Список всех резюме</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/view1/fragments/header.jsp" %>
<table border="1" cellpadding="8" cellspacing="0" class="center">
    <tr>
        <th>Name</th>
        <th>Position</th>
        <th>Edit</th>
        <th>Copy</th>
        <th>Delete</th>
        <th><a href="resume?action=add" title="Добавить">Add</a></th>
    </tr>
    <c:forEach var="resume" items="${resumes}">
        <jsp:useBean id="resume" type="org.database.resume.model.Resume"/>
        <tr>
            <td><a href="resume?uuid=${resume.uuid}&action=view" title="К резюме">${resume.fullName}</a></td>
            <td>${resume.getSection(SectionType.OBJECTIVE).content}</td>
                <%--<td>${ContactType.MAIL.toHtml(resume.getContact(ContactType.MAIL))}</td>--%>
            <td align="center"><a href="resume?uuid=${resume.uuid}&action=edit"><img src="img/view1/edit.png"
                                                                                     title="Редактировать"></a></td>
            <td align="center"><a href="resume?uuid=${resume.uuid}&action=copy" title="Копировать"><img
                    src="img/view1/copy.png" title="Копировать"></a></td>
            <td align="center"><a href="resume?uuid=${resume.uuid}&action=delete"><img src="img/view1/remove.png"
                                                                                       title="Удалить"></a></td>
            <td align="center"><a href="resume?action=add" title="Добавить"><img src="img/view1/add.png"
                                                                                 title="Добавить"></a></td>
        </tr>
    </c:forEach>
</table>
<%@ include file="/WEB-INF/jsp/view1/fragments/footer.jsp" %>
</body>
</html>
