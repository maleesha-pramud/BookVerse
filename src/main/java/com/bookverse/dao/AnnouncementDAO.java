package com.bookverse.dao;

import com.bookverse.model.Announcement;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/** Data Access Object for library Announcements (Singleton, in-memory). */
public class AnnouncementDAO {

    private static final AnnouncementDAO INSTANCE = new AnnouncementDAO();
    private final List<Announcement> announcements = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(1);

    private AnnouncementDAO() {
        addAnnouncement(new Announcement(0, "Scheduled Maintenance",
                "The portal will undergo brief maintenance this weekend between 2 AM and 4 AM.", new Date()));
        addAnnouncement(new Announcement(0, "New Arrivals: Science Fiction",
                "Check out our newly added collection of science-fiction titles in the catalogue.", new Date()));
        addAnnouncement(new Announcement(0, "Extended Opening Hours",
                "BookVerse's digital reading room is now available 24/7 for all members.", new Date()));
    }

    public static AnnouncementDAO getInstance() {
        return INSTANCE;
    }

    public synchronized void addAnnouncement(Announcement a) {
        a.setId(idGenerator.getAndIncrement());
        announcements.add(0, a);
    }

    public synchronized List<Announcement> getAllAnnouncements() {
        return new ArrayList<>(announcements);
    }
}
