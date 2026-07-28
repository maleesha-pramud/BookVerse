package com.bookverse.dao;

import com.bookverse.model.Reservation;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public class ReservationDAO {

    private static final ReservationDAO INSTANCE = new ReservationDAO();
    private final List<Reservation> reservations = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(1);

    private ReservationDAO() {
        seedData();
    }

    private void seedData() {
        addReservation(new Reservation(0, 3, "Design Patterns", "member1", new Date(), "PENDING"));
        addReservation(new Reservation(0, 4, "A Brief History of Time", "member2", new Date(), "READY"));
    }

    public static ReservationDAO getInstance() {
        return INSTANCE;
    }

    public synchronized void addReservation(Reservation reservation) {
        reservation.setId(idGenerator.getAndIncrement());
        reservations.add(reservation);
    }

    public synchronized List<Reservation> getReservationsForUser(String username) {
        List<Reservation> result = new ArrayList<>();
        for (Reservation r : reservations) {
            if (r.getUsername().equalsIgnoreCase(username)) {
                result.add(r);
            }
        }
        return result;
    }

    public synchronized Reservation getReservationById(int id) {
        for (Reservation r : reservations) {
            if (r.getId() == id) {
                return r;
            }
        }
        return null;
    }

    public synchronized void updateReservationStatus(int id, String status) {
        Reservation r = getReservationById(id);
        if (r != null) {
            r.setStatus(status);
        }
    }

    public synchronized List<Reservation> getAllReservations() {
        return new ArrayList<>(reservations);
    }
}
