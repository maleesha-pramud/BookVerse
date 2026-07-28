<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="hour" value="${now}" pattern="H" />
<c:choose>
    <c:when test="${hour < 12}"><c:set var="greeting" value="Good morning" scope="page" /></c:when>
    <c:when test="${hour < 18}"><c:set var="greeting" value="Good afternoon" scope="page" /></c:when>
    <c:otherwise><c:set var="greeting" value="Good evening" scope="page" /></c:otherwise>
</c:choose>
<c:set var="visitCount" value="${empty applicationScope.visitCount ? 1 : applicationScope.visitCount + 1}" scope="application" />
<!DOCTYPE html>
<html>
<head>
    <title>BookVerse Online Library Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="container">
    <h1 class="page-title">${greeting}, welcome to BookVerse</h1>
    <p class="page-subtitle">
        Your digital library for books, journals and reading resources.
        Browse the catalogue, reserve titles and track your reading &mdash; all in one place.
    </p>

    <c:if test="${not empty sessionScope.flashMessage}">
        <div class="flash">${sessionScope.flashMessage}</div>
        <c:remove var="flashMessage" scope="session" />
    </c:if>

    <div class="stats-row">
        <div class="stat-box">
            <div class="num">${fn:length(applicationScope.bookDao.allBooks)}</div>
            <div class="label">Books in catalogue</div>
        </div>
        <div class="stat-box">
            <div class="num">${applicationScope.visitCount}</div>
            <div class="label">Portal visits this session</div>
        </div>
        <div class="stat-box">
            <div class="num">Open</div>
            <div class="label">Registration status</div>
        </div>
    </div>

    <div class="card">
        <h3>Get started</h3>
        <p>New here? Create a free account to reserve and borrow books. Already a member? Sign in to see your dashboard.</p>
        <a class="btn" href="${pageContext.request.contextPath}/controller?action=catalogue">Browse Catalogue</a>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/controller?action=registerForm">Create Account</a>
    </div>

    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
</body>
</html>
