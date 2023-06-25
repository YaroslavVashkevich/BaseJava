package org.database.resume.util;

import java.time.LocalDate;
import java.time.Month;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;

public class DateUtil {
    public static final LocalDate NOW = LocalDate.of(LocalDate.now().getYear(), LocalDate.now().getMonth(), 1);

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("MM/yyyy");
    public static LocalDate of(int year, Month month) {
        LocalDate date = LocalDate.of(year, month, 1);
        return date;
    }

    public static String format(LocalDate date) {
        if (date == null) return "";
        return date.equals(NOW) ? "По наст. вр." : date.format(DATE_FORMATTER);
    }

    public static LocalDate parse(String date) {
        if (HtmlUtil.isEmpty(date) || "По наст. вр.".equals(date)) return NOW;
        YearMonth yearMonth = YearMonth.parse(date, DATE_FORMATTER);
        return LocalDate.of(yearMonth.getYear(), yearMonth.getMonth(), 1);
    }
}
