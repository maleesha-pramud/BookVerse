package com.bookverse.controller;

import com.bookverse.dao.AnnouncementDAO;
import com.bookverse.dao.BookDAO;
import com.bookverse.dao.BorrowDAO;
import com.bookverse.dao.MemberDAO;
import com.bookverse.dao.ReservationDAO;
import com.bookverse.model.Book;
import com.bookverse.model.BorrowRecord;
import com.bookverse.model.Member;
import com.bookverse.model.Reservation;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Front Controller Servlet - the single entry point ("C" in MVC) for every
 * user action in the application. It receives requests, delegates work to
 * the DAO / Model layer, places results in an appropriate scope, and
 * forwards to the correct JSP view.
 *
 * Using one controller servlet (rather than scattering logic across many
 * servlets or, worse, inside the JSPs themselves) demonstrates the
 * Front Controller design pattern in addition to the mandatory MVC pattern.
 */
@WebServlet("/controller")
public class ControllerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        process(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        process(request, response);
    }

    private void process(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "catalogue";
        }

        String view;

        switch (action) {
            case "catalogue":
                view = showCatalogue(request);
                break;
            case "viewBook":
                view = showBookDetails(request);
                break;
            case "loginForm":
                view = "login.jsp";
                break;
            case "login":
                view = doLogin(request);
                break;
            case "logout":
                request.getSession().invalidate();
                view = "index.jsp";
                break;
            case "registerForm":
                view = "register.jsp";
                break;
            case "register":
                view = doRegister(request);
                break;
            case "reserve":
                view = doReserve(request);
                break;
            case "borrow":
                view = doBorrow(request);
                break;
            case "dashboard":
                view = showDashboard(request);
                break;
            case "history":
                view = showHistory(request);
                break;
            case "announcements":
                view = showAnnouncements(request);
                break;
            case "addBookForm":
                view = "admin_addbook.jsp";
                break;
            case "addBook":
                view = doAddBook(request);
                break;
            default:
                view = "catalogue.jsp";
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/" + view);
        dispatcher.forward(request, response);
    }

    // ---------------------------------------------------------------
    // Action handlers
    // ---------------------------------------------------------------

    private String showCatalogue(HttpServletRequest request) {
        String category = request.getParameter("category");
        String keyword = request.getParameter("keyword");

        List<Book> books;
        if (keyword != null && !keyword.trim().isEmpty()) {
            books = BookDAO.getInstance().searchByKeyword(keyword);
        } else {
            books = BookDAO.getInstance().searchByCategory(category);
        }
        request.setAttribute("books", books);
        request.setAttribute("selectedCategory", category);
        request.setAttribute("keyword", keyword);
        return "catalogue.jsp";
    }

    private String showBookDetails(HttpServletRequest request) {
        int id = parseInt(request.getParameter("id"), -1);
        Book book = BookDAO.getInstance().getBookById(id);
        if (book == null) {
            request.setAttribute("errorMessage", "The requested book could not be found.");
            return "WEB-INF/error.jsp";
        }
        request.setAttribute("book", book);
        return "bookDetails.jsp";
    }

    private String doLogin(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Member member = MemberDAO.getInstance().authenticate(username, password);
        if (member == null) {
            request.setAttribute("loginError", "Invalid username or password. Please try again.");
            return "login.jsp";
        }
        HttpSession session = request.getSession();
        session.setAttribute("member", member);
        return showDashboard(request);
    }

    private String doRegister(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");

        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            request.setAttribute("registerError", "Username and password are required.");
            return "register.jsp";
        }
        if (MemberDAO.getInstance().usernameExists(username)) {
            request.setAttribute("registerError", "That username is already taken.");
            return "register.jsp";
        }

        Member member = new Member(0, username, password, fullName, email, "MEMBER");
        MemberDAO.getInstance().register(member);

        HttpSession session = request.getSession();
        session.setAttribute("member", member);
        session.setAttribute("flashMessage", "Welcome to BookVerse, " + fullName + "! Your account was created.");
        return showDashboard(request);
    }

    private String doReserve(HttpServletRequest request) {
        Member member = getLoggedInMember(request);
        if (member == null) {
            return "login.jsp";
        }
        int bookId = parseInt(request.getParameter("bookId"), -1);
        Book book = BookDAO.getInstance().getBookById(bookId);
        if (book == null) {
            request.setAttribute("errorMessage", "That book no longer exists.");
            return "WEB-INF/error.jsp";
        }

        Reservation reservation = new Reservation(0, book.getId(), book.getTitle(),
                member.getUsername(), new Date(), "PENDING");
        ReservationDAO.getInstance().addReservation(reservation);

        request.setAttribute("book", book);
        request.setAttribute("reservationSuccess", true);
        return "reserve.jsp";
    }

    private String doBorrow(HttpServletRequest request) {
        Member member = getLoggedInMember(request);
        if (member == null) {
            return "login.jsp";
        }
        int bookId = parseInt(request.getParameter("bookId"), -1);
        Book book = BookDAO.getInstance().getBookById(bookId);
        if (book == null) {
            request.setAttribute("errorMessage", "That book no longer exists.");
            return "WEB-INF/error.jsp";
        }

        if (BookDAO.getInstance().decreaseAvailability(bookId)) {
            Calendar cal = Calendar.getInstance();
            Date borrowDate = cal.getTime();
            cal.add(Calendar.DAY_OF_MONTH, 14);
            Date dueDate = cal.getTime();

            BorrowRecord record = new BorrowRecord(0, book.getId(), book.getTitle(),
                    member.getUsername(), borrowDate, dueDate, "BORROWED");
            BorrowDAO.getInstance().addRecord(record);
            request.getSession().setAttribute("flashMessage",
                    "You have successfully borrowed \"" + book.getTitle() + "\". Due back in 14 days.");
        } else {
            request.getSession().setAttribute("flashMessage",
                    "Sorry, \"" + book.getTitle() + "\" has no available copies right now.");
        }
        return showDashboard(request);
    }

    private String showDashboard(HttpServletRequest request) {
        Member member = getLoggedInMember(request);
        if (member == null) {
            return "login.jsp";
        }
        List<Reservation> myReservations = ReservationDAO.getInstance().getReservationsForUser(member.getUsername());
        List<BorrowRecord> myBorrowed = BorrowDAO.getInstance().getHistoryForUser(member.getUsername());
        request.setAttribute("myReservations", myReservations);
        request.setAttribute("myBorrowed", myBorrowed);
        return "dashboard.jsp";
    }

    private String showHistory(HttpServletRequest request) {
        Member member = getLoggedInMember(request);
        if (member == null) {
            return "login.jsp";
        }
        request.setAttribute("myBorrowed", BorrowDAO.getInstance().getHistoryForUser(member.getUsername()));
        return "history.jsp";
    }

    private String showAnnouncements(HttpServletRequest request) {
        request.setAttribute("announcements", AnnouncementDAO.getInstance().getAllAnnouncements());
        return "announcements.jsp";
    }

    private String doAddBook(HttpServletRequest request) {
        Member member = getLoggedInMember(request);
        if (member == null || !member.isAdmin()) {
            request.setAttribute("errorMessage", "Only library administrators can add new books.");
            return "WEB-INF/error.jsp";
        }

        Book book = new Book();
        book.setTitle(request.getParameter("title"));
        book.setAuthor(request.getParameter("author"));
        book.setCategory(request.getParameter("category"));
        book.setIsbn(request.getParameter("isbn"));
        book.setDescription(request.getParameter("description"));
        int copies = parseInt(request.getParameter("totalCopies"), 1);
        book.setTotalCopies(copies);
        book.setAvailableCopies(copies);
        book.setRating(4.0);

        BookDAO.getInstance().addBook(book);
        request.getSession().setAttribute("flashMessage", "\"" + book.getTitle() + "\" was added to the catalogue.");
        return showCatalogue(request);
    }

    // ---------------------------------------------------------------
    // Helpers
    // ---------------------------------------------------------------

    private Member getLoggedInMember(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        return (Member) session.getAttribute("member");
    }

    private int parseInt(String value, int fallback) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return fallback;
        }
    }
}
