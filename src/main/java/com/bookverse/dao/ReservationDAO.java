package com.bookverse.dao;

import com.bookverse.model.Reservation;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/** Data Access Object for Reservation records (Singleton, in-memory). */
public class ReservationDAO {

    private static final ReservationDAO INSTANCE = new ReservationDAO();
    private final List<Reservation> reservations = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(1);

    private ReservationDAO() {
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

    public synchronized List<Reservation> getAllReservations() {
        return new ArrayList<>(reservations);
    }
}
