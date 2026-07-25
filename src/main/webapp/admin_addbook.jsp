<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.member or not sessionScope.member.admin}">
    <jsp:forward page="/controller">
        <jsp:param name="action" value="loginForm" />
    </jsp:forward>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Add Book - BookVerse Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="container">
    <h1 class="page-title">Add a New Book</h1>
    <p class="page-subtitle">Library administrators can add new titles to the catalogue.</p>

    <form class="form-box" method="post" action="${pageContext.request.contextPath}/controller">
        <input type="hidden" name="action" value="addBook" />

        <div class="form-group">
            <label for="title">Title</label>
            <input type="text" id="title" name="title" required />
        </div>
        <div class="form-group">
            <label for="author">Author</label>
            <input type="text" id="author" name="author" required />
        </div>
        <div class="form-group">
            <label for="category">Category</label>
            <select id="category" name="category" required>
                <option value="Software Engineering">Software Engineering</option>
                <option value="Science">Science</option>
                <option value="History">History</option>
                <option value="Self Help">Self Help</option>
                <option value="Fiction">Fiction</option>
            </select>
        </div>
        <div class="form-group">
            <label for="isbn">ISBN</label>
            <input type="text" id="isbn" name="isbn" required />
        </div>
        <div class="form-group">
            <label for="totalCopies">Total Copies</label>
            <input type="number" id="totalCopies" name="totalCopies" min="1" value="1" required />
        </div>
        <div class="form-group">
            <label for="description">Description</label>
            <textarea id="description" name="description" rows="4" required></textarea>
        </div>

        <button type="submit" class="btn" style="width:100%;">Add Book to Catalogue</button>
    </form>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
</body>
</html>
