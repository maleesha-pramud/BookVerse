<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - BookVerse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="WEB-INF/includes/header.jsp" />

<div class="container">
    <h1 class="page-title">Create an Account</h1>
    <p class="page-subtitle">Join BookVerse to start reserving and borrowing books.</p>

    <c:if test="${not empty registerError}">
        <div class="error-box" style="max-width:420px;margin:0 auto 16px;">${registerError}</div>
    </c:if>

    <form class="form-box" method="post" action="${pageContext.request.contextPath}/controller">
        <input type="hidden" name="action" value="register" />

        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" required />
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required />
        </div>
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required />
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required />
        </div>

        <button type="submit" class="btn" style="width:100%;">Create Account</button>
        <p style="text-align:center;margin-top:14px;font-size:0.9rem;">
            Already registered?
            <a href="${pageContext.request.contextPath}/controller?action=loginForm">Login here</a>
        </p>
    </form>
</div>

<jsp:include page="WEB-INF/includes/footer.jsp" />
</body>
</html>
