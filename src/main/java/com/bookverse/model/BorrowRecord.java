package com.bookverse.model;

import java.io.Serializable;
import java.util.Date;

/** JavaBean representing a borrowing history entry for a member. */
public class BorrowRecord implements Serializable {

    private int id;
    private int bookId;
    private String bookTitle;
    private String username;
    private Date borrowDate;
    private Date dueDate;
    private String status; // BORROWED, RETURNED

    public BorrowRecord() {
    }

    public BorrowRecord(int id, int bookId, String bookTitle, String username,
                         Date borrowDate, Date dueDate, String status) {
        this.id = id;
        this.bookId = bookId;
        this.bookTitle = bookTitle;
        this.username = username;
        this.borrowDate = borrowDate;
        this.dueDate = dueDate;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
