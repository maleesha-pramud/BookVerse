package com.bookverse.dao;

import com.bookverse.model.BorrowRecord;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/** Data Access Object for BorrowRecord entries (Singleton, in-memory). */
public class BorrowDAO {

    private static final BorrowDAO INSTANCE = new BorrowDAO();
    private final List<BorrowRecord> records = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(1);

    private BorrowDAO() {
    }

    public static BorrowDAO getInstance() {
        return INSTANCE;
    }

    public synchronized void addRecord(BorrowRecord record) {
        record.setId(idGenerator.getAndIncrement());
        records.add(record);
    }

    public synchronized List<BorrowRecord> getHistoryForUser(String username) {
        List<BorrowRecord> result = new ArrayList<>();
        for (BorrowRecord r : records) {
            if (r.getUsername().equalsIgnoreCase(username)) {
                result.add(r);
            }
        }
        return result;
    }
}
