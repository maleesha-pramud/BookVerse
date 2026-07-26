package com.bookverse.dao;

import com.bookverse.model.BorrowRecord;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/** Data Access Object for BorrowRecord entries (Singleton, in-memory). */
public class BorrowDAO {

    private static final BorrowDAO INSTANCE = new BorrowDAO();
    private final List<BorrowRecord> records = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(1);

    private BorrowDAO() {
        seedData();
    }

    private void seedData() {
        Calendar cal = Calendar.getInstance();
        Date borrow1 = cal.getTime();
        cal.add(Calendar.DAY_OF_MONTH, 14);
        Date due1 = cal.getTime();
        addRecord(new BorrowRecord(0, 1, "Clean Code", "member1", borrow1, due1, "BORROWED"));
        
        cal.add(Calendar.DAY_OF_MONTH, -30);
        Date borrow2 = cal.getTime();
        cal.add(Calendar.DAY_OF_MONTH, 14);
        Date due2 = cal.getTime();
        addRecord(new BorrowRecord(0, 2, "The Pragmatic Programmer", "member2", borrow2, due2, "OVERDUE"));
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

    public synchronized List<BorrowRecord> getAllRecords() {
        return new ArrayList<>(records);
    }
}
