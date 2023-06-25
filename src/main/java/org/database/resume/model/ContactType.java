package org.database.resume.model;

public enum ContactType {
    PHONE("Тел:"),
    MOBILE("Мобильный:"),
    HOME_PHONE("Домашний:"),
    SKYPE("Skype:"){
        @Override
        public String toHtml0(String value) {
            return "<a href=\"skype:" + value + "\">" + value + "</a>";
        }
    },
    MAIL("E-mail:"){
        @Override
        public String toHtml0(String value) {
            return "<a href=\"mailto:" + value + "\">" + value + "</a>";
        }
    },
    LINKEDIN("LinkedIn:"),
    GITHUB("GitHub:"),
    STATCKOVERFLOW("Stackoverflow:"),
    HOMEPAGE("Домашняя страница:");
    private final String title;

    ContactType(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    protected String toHtml0(String value){
        return title + " " + value;
    }

    public String toHtml(String value){
        return (value == null) ? "" : toHtml0(value);
    }
}
