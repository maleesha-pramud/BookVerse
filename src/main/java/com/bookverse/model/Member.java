package com.bookverse.model;

import java.io.Serializable;

/**
 * JavaBean representing a library member (or an admin/staff user).
 * Stored in the session scope once a user logs in.
 */
public class Member implements Serializable {

    private int id;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String memberType; // "MEMBER" or "ADMIN"

    public Member() {
    }

    public Member(int id, String username, String password, String fullName,
                  String email, String memberType) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.memberType = memberType;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMemberType() {
        return memberType;
    }

    public void setMemberType(String memberType) {
        this.memberType = memberType;
    }

    public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(memberType);
    }
}
