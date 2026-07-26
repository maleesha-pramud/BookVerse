<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${empty sessionScope.member}">
    <jsp:forward page="/controller">
        <jsp:param name="action" value="loginForm" />
    </jsp:forward>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - BookVerse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="container">
    <h1 class="page-title">Welcome back, ${sessionScope.member.fullName}</h1>
    <p class="page-subtitle">Member type: ${sessionScope.member.memberType}</p>

    <c:if test="${not empty sessionScope.flashMessage}">
        <div class="flash">${sessionScope.flashMessage}</div>
        <c:remove var="flashMessage" scope="session" />
    </c:if>

    <div class="stats-row">
        <%--
            <jsp:element> + <jsp:attribute> build the "class" attribute
            dynamically instead of hard-coding it, illustrating the
            jsp:attribute standard action.
        --%>
        <jsp:element name="div">
            <jsp:attribute name="class">stat-box<c:if test="${fn:length(myBorrowed) > 0}"> available</c:if></jsp:attribute>
            <jsp:body>
                <div class="num">${fn:length(myBorrowed)}</div>
                <div class="label">Books Currently Borrowed</div>
            </jsp:body>
        </jsp:element>

        <div class="stat-box">
            <div class="num">${fn:length(myReservations)}</div>
            <div class="label">Active Reservations</div>
        </div>
        
        <c:if test="${sessionScope.member.admin}">
            <div class="stat-box">
                <div class="num">${fn:length(allBorrowed)}</div>
                <div class="label">Total System Borrows</div>
            </div>
            <div class="stat-box">
                <div class="num">${fn:length(allReservations)}</div>
                <div class="label">Total System Reservations</div>
            </div>
        </c:if>
    </div>

    <c:if test="${sessionScope.member.admin}">
        <div class="card">
            <h3>Admin Overview: All Active Reservations</h3>
            <div class="table-container">
            <table>
                <tr><th>User</th><th>Book</th><th>Date</th><th>Status</th><th>Action</th></tr>
                <c:forEach var="r" items="${allReservations}">
                    <tr>
                        <td>${r.username}</td>
                        <td>${r.bookTitle}</td>
                        <td><fmt:formatDate value="${r.reservationDate}" pattern="dd MMM yyyy" /></td>
                        <td><span class="status ${r.status == 'READY' ? 'available' : 'unavailable'}">${r.status}</span></td>
                        <td>
                            <c:if test="${r.status == 'PENDING'}">
                                <a href="${pageContext.request.contextPath}/controller?action=approveReservation&id=${r.id}" class="btn btn-small">Approve</a>
                            </c:if>
                            <c:if test="${r.status == 'READY'}">
                                <a href="${pageContext.request.contextPath}/controller?action=issueReservation&id=${r.id}" class="btn btn-small">Issue</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            </div>
        </div>
        
        <div class="card">
            <h3>Admin Overview: All Borrowed Books</h3>
            <div class="table-container">
            <table>
                <tr><th>User</th><th>Book</th><th>Borrowed On</th><th>Due Date</th><th>Status</th></tr>
                <c:forEach var="rec" items="${allBorrowed}">
                    <tr>
                        <td>${rec.username}</td>
                        <td>${rec.bookTitle}</td>
                        <td><fmt:formatDate value="${rec.borrowDate}" pattern="dd MMM yyyy" /></td>
                        <td><fmt:formatDate value="${rec.dueDate}" pattern="dd MMM yyyy" /></td>
                        <td><span class="status ${rec.status == 'OVERDUE' ? 'unavailable' : 'available'}">${rec.status}</span></td>
                    </tr>
                </c:forEach>
            </table>
            </div>
        </div>
    </c:if>

    <div class="card">
        <h3>My Reservations</h3>
        <c:choose>
            <c:when test="${empty myReservations}">
                <p class="empty-state">You have no reservations yet.</p>
            </c:when>
            <c:otherwise>
                <div class="table-container">
                <table>
                    <tr><th>Book</th><th>Date</th><th>Status</th></tr>
                    <c:forEach var="r" items="${myReservations}">
                        <tr>
                            <td>${r.bookTitle}</td>
                            <td><fmt:formatDate value="${r.reservationDate}" pattern="dd MMM yyyy" /></td>
                            <td>${r.status}</td>
                        </tr>
                    </c:forEach>
                </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="card">
        <h3>Currently Borrowed</h3>
        <c:choose>
            <c:when test="${empty myBorrowed}">
                <p class="empty-state">You haven't borrowed any books yet.</p>
            </c:when>
            <c:otherwise>
                <div class="table-container">
                <table>
                    <tr><th>Book</th><th>Borrowed On</th><th>Due Date</th><th>Status</th></tr>
                    <c:forEach var="rec" items="${myBorrowed}">
                        <tr>
                            <td>${rec.bookTitle}</td>
                            <td><fmt:formatDate value="${rec.borrowDate}" pattern="dd MMM yyyy" /></td>
                            <td><fmt:formatDate value="${rec.dueDate}" pattern="dd MMM yyyy" /></td>
                            <td>${rec.status}</td>
                        </tr>
                    </c:forEach>
                </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <a class="btn" href="${pageContext.request.contextPath}/controller?action=catalogue">Browse More Books</a>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
</body>
</html>
