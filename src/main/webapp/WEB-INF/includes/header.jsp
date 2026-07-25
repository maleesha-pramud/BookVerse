<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
    Shared navigation header, reused on every page via <jsp:include>.
    Demonstrates: request/session implicit objects, EL, JSTL c:if/c:choose.
--%>
<div class="navbar">
    <a class="brand" href="${pageContext.request.contextPath}/controller?action=catalogue">
        Book<span>Verse</span>
    </a>
    <nav>
        <a href="${pageContext.request.contextPath}/controller?action=catalogue">Catalogue</a>
        <a href="${pageContext.request.contextPath}/controller?action=announcements">Announcements</a>

        <c:choose>
            <c:when test="${not empty sessionScope.member}">
                <a href="${pageContext.request.contextPath}/controller?action=dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/controller?action=history">History</a>
                <c:if test="${sessionScope.member.admin}">
                    <a href="${pageContext.request.contextPath}/controller?action=addBookForm">Add Book</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/controller?action=logout">
                    Logout (${sessionScope.member.username})
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/controller?action=loginForm">Login</a>
                <a href="${pageContext.request.contextPath}/controller?action=registerForm">Register</a>
            </c:otherwise>
        </c:choose>
    </nav>
</div>
