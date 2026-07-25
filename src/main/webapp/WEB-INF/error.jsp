<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>BookVerse - Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="container">
    <h1 class="page-title">Something went wrong</h1>
    <div class="error-box">
        <c:choose>
            <c:when test="${not empty errorMessage}">
                ${errorMessage}
            </c:when>
            <c:when test="${not empty exception}">
                <%-- exception is the implicit object available on isErrorPage="true" pages --%>
                An unexpected error occurred: ${exception.message}
            </c:when>
            <c:otherwise>
                The page you requested could not be processed.
            </c:otherwise>
        </c:choose>
    </div>
    <a class="btn" href="${pageContext.request.contextPath}/controller?action=catalogue">Back to Catalogue</a>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
</body>
</html>
