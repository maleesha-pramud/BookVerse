package com.bookverse.beans;

import java.io.Serializable;

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
