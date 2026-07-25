package com.bookverse.model;

import java.io.Serializable;
import java.util.Date;

/** JavaBean representing a book reservation made by a member. */
public class Reservation implements Serializable {

    private int id;
    private int bookId;
    private String bookTitle;
    private String username;
    private Date reservationDate;
    private String status; // PENDING, READY, CANCELLED

    public Reservation() {
    }

    public Reservation(int id, int bookId, String bookTitle, String username,
                        Date reservationDate, String status) {
        this.id = id;
        this.bookId = bookId;
        this.bookTitle = bookTitle;
        this.username = username;
        this.reservationDate = reservationDate;
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

    public Date getReservationDate() {
        return reservationDate;
    }

    public void setReservationDate(Date reservationDate) {
        this.reservationDate = reservationDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
