<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Announcements - BookVerse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="container">
    <h1 class="page-title">Library Announcements</h1>
    <p class="page-subtitle">Stay up to date with the latest news from BookVerse.</p>

    <c:forEach var="a" items="${announcements}">
        <div class="card">
            <h3 style="margin-top:0;color:#2b5f75;">${a.title}</h3>
            <p>${a.message}</p>
            <p style="color:#6b6b6b;font-size:0.85rem;">
                Posted on <fmt:formatDate value="${a.datePosted}" pattern="dd MMM yyyy" />
            </p>
        </div>
    </c:forEach>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
</body>
</html>
