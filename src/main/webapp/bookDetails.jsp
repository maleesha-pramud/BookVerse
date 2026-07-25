<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bv" uri="http://bookverse.com/tags" %>

<c:if test="${empty book}">
    <%--
        If this page is opened directly (e.g. bookmarked as
        bookDetails.jsp?id=3) instead of through the controller, forward
        the request back through the Front Controller so the "id" request
        parameter is preserved via <jsp:param>.
    --%>
    <jsp:forward page="/controller">
        <jsp:param name="action" value="viewBook" />
        <jsp:param name="id" value="${param.id}" />
    </jsp:forward>
</c:if>

<%-- book was placed in request scope by the controller; jsp:useBean simply
     binds a page-level EL/scriptlet handle to that existing object. --%>
<jsp:useBean id="book" scope="request" type="com.bookverse.model.Book" />

<!DOCTYPE html>
<html>
<head>
    <title><jsp:getProperty name="book" property="title" /> - BookVerse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="container">
    <a href="${pageContext.request.contextPath}/controller?action=catalogue">&larr; Back to Catalogue</a>

    <div class="card" style="margin-top:16px;">
        <span class="badge"><jsp:getProperty name="book" property="category" /></span>
        <h1 class="page-title" style="margin-top:8px;"><jsp:getProperty name="book" property="title" /></h1>
        <p class="page-subtitle">by <jsp:getProperty name="book" property="author" /></p>

        <p><bv:ratingStars value="${book.rating}" /> (${book.rating} / 5)</p>

        <p>${book.description}</p>

        <p><strong>ISBN:</strong> ${book.isbn}</p>

        <c:choose>
            <c:when test="${book.availableCopies > 0}">
                <p class="status available">${book.availableCopies} of ${book.totalCopies} copies available</p>
            </c:when>
            <c:otherwise>
                <p class="status unavailable">All copies are currently on loan</p>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${empty sessionScope.member}">
                <p>
                    <a class="btn" href="${pageContext.request.contextPath}/controller?action=loginForm">
                        Login to reserve or borrow this book
                    </a>
                </p>
            </c:when>
            <c:otherwise>
                <form method="post" action="${pageContext.request.contextPath}/controller" style="display:inline;">
                    <input type="hidden" name="action" value="reserve" />
                    <input type="hidden" name="bookId" value="${book.id}" />
                    <button type="submit" class="btn">Reserve</button>
                </form>

                <c:if test="${book.availableCopies > 0}">
                    <form method="post" action="${pageContext.request.contextPath}/controller" style="display:inline;">
                        <input type="hidden" name="action" value="borrow" />
                        <input type="hidden" name="bookId" value="${book.id}" />
                        <button type="submit" class="btn btn-secondary">Borrow Now</button>
                    </form>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
</body>
</html>
