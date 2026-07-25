package com.bookverse.beans;

import java.io.Serializable;

/**
 * A small helper JavaBean instantiated directly inside catalogue.jsp with
 * <jsp:useBean> and populated with <jsp:setProperty name="filter"
 * property="*" />. It simply mirrors the incoming request parameters
 * (keyword / category) so the search form can be redisplayed with the
 * user's last search still filled in ("sticky form").
 */
public class SearchFilterBean implements Serializable {

    private String keyword;
    private String category;

    public SearchFilterBean() {
    }

    public String getKeyword() {
        return keyword == null ? "" : keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getCategory() {
        return category == null ? "" : category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
