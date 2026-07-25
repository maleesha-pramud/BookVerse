<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bv" tagdir="/WEB-INF/tags" %>
<%--
    <jsp:useBean> + <jsp:setProperty property="*"> populate a plain
    JavaBean (SearchFilterBean) straight from the request parameters so the
    search form can redisplay the member's last search ("sticky form").
--%>
<jsp:useBean id="filter" class="com.bookverse.beans.SearchFilterBean" scope="page" />
<jsp:setProperty name="filter" property="*" />

<!DOCTYPE html>
<html>
<head>
    <title>Catalogue - BookVerse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="container">
    <h1 class="page-title">Book Catalogue</h1>
    <p class="page-subtitle">Browse, search, and filter BookVerse's collection.</p>

    <c:if test="${not empty sessionScope.flashMessage}">
        <div class="flash">${sessionScope.flashMessage}</div>
        <c:remove var="flashMessage" scope="session" />
    </c:if>

    <form class="filter-bar" method="get" action="${pageContext.request.contextPath}/controller">
        <input type="hidden" name="action" value="catalogue" />
        <input type="text" name="keyword" placeholder="Search by title or author"
               value="<jsp:getProperty name='filter' property='keyword' />" />

        <select name="category">
            <option value="">All Categories</option>
            <option value="Software Engineering" ${filter.category == 'Software Engineering' ? 'selected' : ''}>Software Engineering</option>
            <option value="Science" ${filter.category == 'Science' ? 'selected' : ''}>Science</option>
            <option value="History" ${filter.category == 'History' ? 'selected' : ''}>History</option>
            <option value="Self Help" ${filter.category == 'Self Help' ? 'selected' : ''}>Self Help</option>
            <option value="Fiction" ${filter.category == 'Fiction' ? 'selected' : ''}>Fiction</option>
        </select>

        <button type="submit" class="btn btn-small">Search</button>
        <a class="btn btn-small btn-secondary" href="${pageContext.request.contextPath}/controller?action=catalogue">Reset</a>
    </form>

    <c:choose>
        <c:when test="${empty books}">
            <p class="empty-state">No books matched your search. Try a different keyword or category.</p>
        </c:when>
        <c:otherwise>
            <div class="grid">
                <c:forEach var="b" items="${books}">
                    <bv:bookCard book="${b}" />
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
</body>
</html>
