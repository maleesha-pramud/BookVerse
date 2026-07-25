<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%--
    Shared footer, reused via <jsp:include>. Prints the current server time
    (pageContext implicit object) to show the page was dynamically rendered.
--%>
<footer class="site-footer">
    <p>&copy; 2026 BookVerse Online Library Portal &mdash; Web Component Development Assignment</p>
    <p>Rendered on: <%= new java.util.Date() %> | Session ID: <%= session.getId() %></p>
</footer>
