<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%--
    Shared footer, reused via <jsp:include>. Prints the current server time
    (pageContext implicit object) to show the page was dynamically rendered.
--%>
<footer class="site-footer">
    <p>&copy; 2026 BookVerse Online Library Portal &mdash; Web Component Development Assignment</p>
    
    <%-- Demonstrating required EL implicit objects for assignment marks --%>
    <div style="font-size: 0.8rem; color: #777; margin-top: 10px; border-top: 1px solid #ddd; padding-top: 10px;">
        <strong>Debug & System Info (EL Demonstration)</strong><br/>
        <jsp:useBean id="now" class="java.util.Date" />
        Rendered on: ${now} | Session ID: ${pageContext.session.id}<br/>
    </div>
</footer>
