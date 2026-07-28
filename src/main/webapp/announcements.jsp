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

    <c:if test="${not empty sessionScope.flashMessage}">
        <div class="flash">${sessionScope.flashMessage}</div>
        <c:remove var="flashMessage" scope="session" />
    </c:if>

    <c:if test="${not empty sessionScope.member and sessionScope.member.admin}">
        <div class="card" style="margin-bottom: 40px; border-color: var(--primary);">
            <h3>Post New Announcement</h3>
            <form method="post" action="${pageContext.request.contextPath}/controller">
                <input type="hidden" name="action" value="addAnnouncement" />
                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text" id="title" name="title" required />
                </div>
                <div class="form-group">
                    <label for="message">Message</label>
                    <textarea id="message" name="message" required></textarea>
                </div>
                <button type="submit" class="btn">Post Announcement</button>
            </form>
        </div>
    </c:if>

    <c:forEach var="a" items="${announcements}">
        <div class="card">
            <h3 style="margin-top:0;">${a.title}</h3>
            <p>${a.message}</p>
            <p style="color:var(--text-muted);font-size:0.85rem;margin-top:16px;">
                Posted on <fmt:formatDate value="${a.datePosted}" pattern="dd MMM yyyy" />
            </p>
        </div>
    </c:forEach>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
</body>
</html>
