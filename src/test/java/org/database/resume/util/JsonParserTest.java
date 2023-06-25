package org.database.resume.util;

import org.database.resume.model.Resume;
import org.database.resume.model.Section;
import org.database.resume.model.TextSection;
import org.junit.jupiter.api.Test;

import static org.database.resume.TestData.RESUME1;
import static org.junit.jupiter.api.Assertions.*;

public class JsonParserTest {

    @Test
    void testResume() {
        String json = JsonParser.write(RESUME1, Resume.class);
        Resume resume = JsonParser.read(json, Resume.class);
        assertEquals(RESUME1, resume);
    }

    @Test
    void testSection() {
        Section section1 = new TextSection("Objective");
        String json = JsonParser.write(section1, Section.class);
        Section section2 = JsonParser.read(json, Section.class);
        assertEquals(section1, section2);
    }
}