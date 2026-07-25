package com.bookverse.dao;

import com.bookverse.model.Member;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/** Data Access Object for Member records (Singleton, in-memory). */
public class MemberDAO {

    private static final MemberDAO INSTANCE = new MemberDAO();
    private final List<Member> members = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(1);

    private MemberDAO() {
        // Seed a demo member and an admin account so the app is usable
        // immediately without registering first.
        register(new Member(0, "member1", "member123", "Kasun Perera",
                "kasun@example.com", "MEMBER"));
        register(new Member(0, "admin", "admin123", "Library Admin",
                "admin@bookverse.com", "ADMIN"));
    }

    public static MemberDAO getInstance() {
        return INSTANCE;
    }

    public synchronized Member findByUsername(String username) {
        for (Member m : members) {
            if (m.getUsername().equalsIgnoreCase(username)) {
                return m;
            }
        }
        return null;
    }

    public synchronized Member authenticate(String username, String password) {
        Member m = findByUsername(username);
        if (m != null && m.getPassword().equals(password)) {
            return m;
        }
        return null;
    }

    public synchronized boolean usernameExists(String username) {
        return findByUsername(username) != null;
    }

    public synchronized void register(Member member) {
        member.setId(idGenerator.getAndIncrement());
        if (member.getMemberType() == null || member.getMemberType().isEmpty()) {
            member.setMemberType("MEMBER");
        }
        members.add(member);
    }
}
