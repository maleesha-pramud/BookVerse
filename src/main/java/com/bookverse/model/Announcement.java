package com.bookverse.model;

import java.io.Serializable;
import java.util.Date;

/** JavaBean representing a library announcement/notice. */
public class Announcement implements Serializable {

    private int id;
    private String title;
    private String message;
    private Date datePosted;

    public Announcement() {
    }

    public Announcement(int id, String title, String message, Date datePosted) {
        this.id = id;
        this.title = title;
        this.message = message;
        this.datePosted = datePosted;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getDatePosted() {
        return datePosted;
    }

    public void setDatePosted(Date datePosted) {
        this.datePosted = datePosted;
    }
}
