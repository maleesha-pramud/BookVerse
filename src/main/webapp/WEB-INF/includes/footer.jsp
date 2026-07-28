<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<footer class="site-footer">
    <p>&copy; 2026 BookVerse Online Library Portal &mdash; Web Component Development Assignment</p>

    <div style="font-size: 0.8rem; color: #777; margin-top: 10px; border-top: 1px solid #ddd; padding-top: 10px;">
        <strong>Debug & System Info (EL Demonstration)</strong><br/>
        <jsp:useBean id="now" class="java.util.Date" />
        Rendered on: ${now} | Session ID: ${pageContext.session.id}<br/>
    </div>
</footer>
