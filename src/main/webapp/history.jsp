<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${empty sessionScope.member}">
    <jsp:forward page="/controller">
        <jsp:param name="action" value="loginForm" />
    </jsp:forward>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Borrowing History - BookVerse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="WEB-INF/includes/header.jsp" />

<div class="container">
    <h1 class="page-title">Borrowing History</h1>
    <p class="page-subtitle">A record of every book ${sessionScope.member.fullName} has borrowed.</p>

    <c:choose>
        <c:when test="${empty myBorrowed}">
            <p class="empty-state">No borrowing history yet. Books you borrow will appear here.</p>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>#</th>
                    <th>Book Title</th>
                    <th>Borrowed On</th>
                    <th>Due Date</th>
                    <th>Status</th>
                </tr>
                <c:forEach var="rec" items="${myBorrowed}" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td>${rec.bookTitle}</td>
                        <td><fmt:formatDate value="${rec.borrowDate}" pattern="dd MMM yyyy" /></td>
                        <td><fmt:formatDate value="${rec.dueDate}" pattern="dd MMM yyyy" /></td>
                        <td>${rec.status}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>

    <p style="margin-top:20px;">
        <a class="btn" href="${pageContext.request.contextPath}/controller?action=dashboard">Back to Dashboard</a>
    </p>
</div>

<jsp:include page="WEB-INF/includes/footer.jsp" />
</body>
</html>
