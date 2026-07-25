<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reservation - BookVerse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="container">
    <h1 class="page-title">Reservation Confirmed</h1>

    <c:choose>
        <c:when test="${reservationSuccess}">
            <div class="flash">
                You have successfully reserved <strong>${book.title}</strong>.
                We'll notify you when it's ready for collection.
            </div>
        </c:when>
        <c:otherwise>
            <div class="error-box">We could not process your reservation.</div>
        </c:otherwise>
    </c:choose>

    <div class="card">
        <p><strong>Book:</strong> ${book.title}</p>
        <p><strong>Author:</strong> ${book.author}</p>
        <p><strong>Reserved by:</strong> ${sessionScope.member.fullName}</p>
        <p><strong>Reservation date:</strong>
            <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMM yyyy, hh:mm a" />
        </p>
    </div>

    <a class="btn" href="${pageContext.request.contextPath}/controller?action=dashboard">Go to Dashboard</a>
    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/controller?action=catalogue">Continue Browsing</a>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
</body>
</html>
