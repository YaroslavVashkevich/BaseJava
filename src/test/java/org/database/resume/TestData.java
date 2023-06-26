package org.database.resume;

import org.database.resume.model.*;

import java.time.Month;
import java.util.UUID;

public class TestData {
    public static final String UUID_1 = UUID.randomUUID().toString();
    public static final String UUID_2 = UUID.randomUUID().toString();
    public static final String UUID_3 = UUID.randomUUID().toString();
    public static final String UUID_4 = UUID.randomUUID().toString();
    public static final Resume RESUME1;
    public static final Resume RESUME2;
    public static final Resume RESUME3;
    public static final Resume RESUME4;

    static {
        RESUME1 = new Resume(UUID_1, "Name1");
        RESUME2 = new Resume(UUID_2, "Name2");
        RESUME3 = new Resume(UUID_3, "Name3");
        RESUME4 = new Resume(UUID_4, "Name4");

        RESUME1.setContact(ContactType.MAIL, "mail@yandex.ru");
        RESUME1.setContact(ContactType.PHONE, "+375291111111");
        RESUME1.setSection(SectionType.PERSONAL, new TextSection("Personal data"));
        RESUME1.setSection(SectionType.OBJECTIVE, new TextSection("Objective №1"));
        RESUME1.setSection(SectionType.ACHIEVEMENT, new ListSection("Achievement №1", "Achievement №2", "Achievement №3"));
        RESUME1.setSection(SectionType.QUALIFICATIONS, new ListSection("Qualification №1", "Qualification №2", "Qualification №3"));
        RESUME1.setSection(SectionType.EXPERIENCE, new OrganizationSection(
                new Organization("Organization №1", "http://Organization1.ru",
                        new Organization.Position(2020, Month.JANUARY, "Position №1", "Content №1"),
                        new Organization.Position(2010, Month.MARCH, 2020, Month.JANUARY, "Position №2", "Content №2")),
                new Organization("Organization №2", "http://Organization2.ru",
                        new Organization.Position(2005, Month.JULY,2010, Month.MARCH, "Position №1", "Content №1"),
                        new Organization.Position(2001, Month.JANUARY, 2005, Month.JULY, "Position №2", "Content №2"))));
        RESUME1.setSection(SectionType.EDUCATION, new OrganizationSection(
                new Organization("University", "http://University.ru",
                        new Organization.Position(1999, Month.SEPTEMBER, 2000, Month.DECEMBER, "Aspirant", "Facultet №2"),
                        new Organization.Position(1994, Month.SEPTEMBER, 1999, Month.AUGUST, "Student", "Facultet №1")),
                new Organization("Institute", "http://Institute.ru",
                        new Organization.Position(1989, Month.SEPTEMBER, 1994, Month.AUGUST, "Student", "Facultet №1"))));

        RESUME2.setContact(ContactType.SKYPE, "Skype");
        RESUME2.setContact(ContactType.PHONE, "+375296666666");
        RESUME2.setSection(SectionType.PERSONAL, new TextSection("Personal data"));
        RESUME2.setSection(SectionType.OBJECTIVE, new TextSection("Objective №2"));
        RESUME2.setSection(SectionType.ACHIEVEMENT, new ListSection("Achievement №1", "Achievement №2", "Achievement №3"));
        RESUME2.setSection(SectionType.QUALIFICATIONS, new ListSection("Qualification №1", "Qualification №2", "Qualification №3"));
        RESUME2.setSection(SectionType.EXPERIENCE, new OrganizationSection(
                new Organization("Organization №1", "http://Organization1.ru",
                        new Organization.Position(2015, Month.JANUARY, "Position №1", "Content №1"))));

        RESUME4.setContact(ContactType.PHONE, "+375294444444");
        RESUME4.setContact(ContactType.SKYPE, "Skype");
    }
}