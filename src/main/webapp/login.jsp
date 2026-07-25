<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - BookVerse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="container">
    <h1 class="page-title">Member Login</h1>
    <p class="page-subtitle">Sign in to reserve books, borrow titles and view your reading history.</p>

    <c:if test="${not empty loginError}">
        <div class="error-box" style="max-width:420px;margin:0 auto 16px;">${loginError}</div>
    </c:if>

    <form class="form-box" method="post" action="${pageContext.request.contextPath}/controller">
        <input type="hidden" name="action" value="login" />

        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required autofocus />
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required />
        </div>

        <button type="submit" class="btn" style="width:100%;">Login</button>
        <p style="text-align:center;margin-top:14px;font-size:0.9rem;">
            No account yet?
            <a href="${pageContext.request.contextPath}/controller?action=registerForm">Register here</a>
        </p>
    </form>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
</body>
</html>
