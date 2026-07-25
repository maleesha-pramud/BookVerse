<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.bookverse.dao.BookDAO" %>
<%--
    Home / welcome page.
    Demonstrates the "application" and "out" implicit objects (visit
    counter) plus a scriptlet-based time-of-day greeting. Business data
    for the rest of the app flows through the Front Controller servlet;
    this landing page reads the DAOs directly only to show a couple of
    simple summary counts.
--%>
<%
    // application implicit object: a simple shared hit counter
    Integer visits = (Integer) application.getAttribute("visitCount");
    visits = (visits == null) ? 1 : visits + 1;
    application.setAttribute("visitCount", visits);

    // out implicit object + time-based greeting
    int hour = java.util.Calendar.getInstance().get(java.util.Calendar.HOUR_OF_DAY);
    String greeting = (hour < 12) ? "Good morning" : (hour < 18) ? "Good afternoon" : "Good evening";
    pageContext.setAttribute("greeting", greeting);
%>
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
            <div class="num"><%= BookDAO.getInstance().getAllBooks().size() %></div>
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

    <div class="card">
        <h3>Demo accounts</h3>
        <p>Member &mdash; username: <strong>member1</strong> / password: <strong>member123</strong></p>
        <p>Admin &mdash; username: <strong>admin</strong> / password: <strong>admin123</strong></p>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
</body>
</html>
