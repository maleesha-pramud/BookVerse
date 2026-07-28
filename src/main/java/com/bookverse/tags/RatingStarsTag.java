package com.bookverse.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

public class RatingStarsTag extends SimpleTagSupport {

    private double value;

    public void setValue(double value) {
        this.value = value;
    }

    @Override
    public void doTag() throws JspException, IOException {
        JspWriter out = getJspContext().getOut();
        int fullStars = (int) Math.round(value);
        if (fullStars > 5) {
            fullStars = 5;
        }
        if (fullStars < 0) {
            fullStars = 0;
        }

        StringBuilder sb = new StringBuilder();
        sb.append("<span class=\"rating-stars\" title=\"").append(value).append(" out of 5\">");
        for (int i = 0; i < fullStars; i++) {
            sb.append("&#9733;"); // filled star
        }
        for (int i = fullStars; i < 5; i++) {
            sb.append("&#9734;"); // empty star
        }
        sb.append("</span>");

        out.print(sb.toString());
    }
}
