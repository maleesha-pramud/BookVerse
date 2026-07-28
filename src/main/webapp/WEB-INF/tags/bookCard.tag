<%@ tag description="Displays a single book as a catalogue card" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bv" uri="http://bookverse.com/tags" %>
<%@ attribute name="book" required="true" type="com.bookverse.model.Book" %>

<div class="book-card">
    <div class="book-card-header">
        <h3>${book.title}</h3>
        <span class="badge">${book.category}</span>
    </div>
    <p class="book-author">by ${book.author}</p>
    <p class="book-rating"><bv:ratingStars value="${book.rating}" /></p>

    <c:choose>
        <c:when test="${book.availableCopies > 0}">
            <p class="status available">${book.availableCopies} of ${book.totalCopies} copies available</p>
        </c:when>
        <c:otherwise>
            <p class="status unavailable">Currently unavailable</p>
        </c:otherwise>
    </c:choose>

    <a class="btn btn-small" href="${pageContext.request.contextPath}/controller?action=viewBook&amp;id=${book.id}">
        View Details
    </a>
</div>
