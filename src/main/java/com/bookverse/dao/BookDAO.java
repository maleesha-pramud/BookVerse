package com.bookverse.dao;

import com.bookverse.model.Book;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Data Access Object for Book records.
 * Implemented as a Singleton so a single, shared in-memory catalogue is
 * used across the whole application (data is seeded on first access).
 *
 * This keeps the assessment focused on JSP/EL/JSTL/Tag concepts rather than
 * JDBC plumbing, while still separating data access from the view (DAO
 * pattern) and supporting the Model layer of the overall MVC design.
 */
public class BookDAO {

    private static final BookDAO INSTANCE = new BookDAO();
    private final List<Book> books = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(1);

    private BookDAO() {
        seedData();
    }

    public static BookDAO getInstance() {
        return INSTANCE;
    }

    private void seedData() {
        addBook(new Book(0, "Clean Code", "Robert C. Martin", "Software Engineering",
                "978-0132350884", "A handbook of agile software craftsmanship.", 4, 4, 4.5));
        addBook(new Book(0, "The Pragmatic Programmer", "Andrew Hunt", "Software Engineering",
                "978-0135957059", "Classic guide to becoming a better programmer.", 3, 2, 4.6));
        addBook(new Book(0, "Design Patterns", "Erich Gamma", "Software Engineering",
                "978-0201633610", "The classic Gang of Four design patterns book.", 2, 0, 4.3));
        addBook(new Book(0, "A Brief History of Time", "Stephen Hawking", "Science",
                "978-0553380163", "An accessible tour of cosmology and physics.", 3, 3, 4.7));
        addBook(new Book(0, "Sapiens", "Yuval Noah Harari", "History",
                "978-0062316097", "A brief history of humankind.", 5, 4, 4.8));
        addBook(new Book(0, "Atomic Habits", "James Clear", "Self Help",
                "978-0735211292", "An easy and proven way to build good habits.", 4, 1, 4.9));
        addBook(new Book(0, "The Great Gatsby", "F. Scott Fitzgerald", "Fiction",
                "978-0743273565", "A classic novel of the Jazz Age.", 3, 3, 4.2));
        addBook(new Book(0, "1984", "George Orwell", "Fiction",
                "978-0451524935", "A dystopian vision of a totalitarian future.", 4, 2, 4.8));
    }

    public synchronized List<Book> getAllBooks() {
        return new ArrayList<>(books);
    }

    public synchronized Book getBookById(int id) {
        for (Book b : books) {
            if (b.getId() == id) {
                return b;
            }
        }
        return null;
    }

    public synchronized void addBook(Book book) {
        book.setId(idGenerator.getAndIncrement());
        books.add(book);
    }

    public synchronized List<Book> searchByCategory(String category) {
        List<Book> result = new ArrayList<>();
        for (Book b : books) {
            if (category == null || category.isEmpty() || b.getCategory().equalsIgnoreCase(category)) {
                result.add(b);
            }
        }
        return result;
    }

    public synchronized List<Book> searchByKeyword(String keyword) {
        List<Book> result = new ArrayList<>();
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllBooks();
        }
        String lower = keyword.toLowerCase();
        for (Book b : books) {
            if (b.getTitle().toLowerCase().contains(lower) || b.getAuthor().toLowerCase().contains(lower)) {
                result.add(b);
            }
        }
        return result;
    }

    public synchronized boolean decreaseAvailability(int bookId) {
        Book b = getBookById(bookId);
        if (b != null && b.getAvailableCopies() > 0) {
            b.setAvailableCopies(b.getAvailableCopies() - 1);
            return true;
        }
        return false;
    }

    public synchronized void increaseAvailability(int bookId) {
        Book b = getBookById(bookId);
        if (b != null && b.getAvailableCopies() < b.getTotalCopies()) {
            b.setAvailableCopies(b.getAvailableCopies() + 1);
        }
    }
}
