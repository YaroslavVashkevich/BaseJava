package org.database.resume.util;

import jakarta.xml.bind.annotation.adapters.XmlAdapter;

import java.time.LocalDate;

public class XmlLocalDateAdapter extends XmlAdapter<String, LocalDate> {
    @Override
    public LocalDate unmarshal(String str) {
        return LocalDate.parse(str);
    }

    @Override
    public String marshal(LocalDate date) {
        return date.toString();
    }
}
