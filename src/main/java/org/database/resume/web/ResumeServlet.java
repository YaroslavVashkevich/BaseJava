package org.database.resume.web;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.database.resume.model.*;
import org.database.resume.storage.SqlStorage;
import org.database.resume.storage.Storage;
import org.database.resume.util.DateUtil;
import org.database.resume.util.HtmlUtil;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/resume")
public class ResumeServlet extends HttpServlet {
    Storage storage;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        storage = new SqlStorage();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uuid = req.getParameter("uuid");
        String action = req.getParameter("action");
        if (action == null) {
            req.setAttribute("resumes", storage.getAllSorted());
            req.getRequestDispatcher("/WEB-INF/jsp/list.jsp").forward(req, resp);
        }
        Resume resume;
        switch (action) {
            case "delete":
                storage.delete(uuid);
                resp.sendRedirect("resume");
                return;
            case "view":
                resume = storage.get(uuid);
                break;
            case "add":
                resume = Resume.EMPTY;
                break;
            case "copy":
                Resume copyResume = new Resume();
                resume = storage.get(uuid);
                resume.setUuid(copyResume.getUuid());
                req.setAttribute("isCopy", "true");
                fillResumeEmpty(resume);
                break;
            case "edit":
                resume = storage.get(uuid);
                fillResumeEmpty(resume);
                break;
            default:
                throw new IllegalArgumentException("Action " + " is illegal");
        }
        req.setAttribute("resume", resume);
        req.getRequestDispatcher("view".equals(action) ? "/WEB-INF/jsp/view.jsp" : "/WEB-INF/jsp/edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        String uuid = req.getParameter("uuid");
        String fullName = req.getParameter("fullName");
        final boolean isCreate = (uuid == null || uuid.length() == 0);
        boolean isCopy = false;

        Resume resume;
        if (isCreate) {
            resume = new Resume(fullName);
        } else {
            resume = storage.get(uuid);
            resume.setFullName(fullName);
        }

        for (ContactType type : ContactType.values()) {
            String value = req.getParameter(type.name());
            if (HtmlUtil.isEmpty(value)) {
                resume.getContacts().remove(type);
            } else {
                resume.setContact(type, value);
            }
        }
        for (SectionType type : SectionType.values()) {
            String value = req.getParameter(type.name());
            String[] values = req.getParameterValues(type.name());
            if (HtmlUtil.isEmpty(value) && values.length < 2) {
                resume.getSections().remove(type);
            } else {
                switch (type) {
                    case OBJECTIVE:
                    case PERSONAL:
                        resume.setSection(type, new TextSection(value));
                        break;
                    case ACHIEVEMENT:
                    case QUALIFICATIONS:
                        resume.setSection(type, new ListSection(value.split("\\n")));
                        break;
                    case EDUCATION:
                    case EXPERIENCE:
                        List<Organization> orgs = new ArrayList<>();
                        String[] urls = req.getParameterValues(type.name() + "url");
                        for (int i = 0; i < values.length; i++) {
                            String name = values[i];
                            if (!HtmlUtil.isEmpty(name)) {
                                List<Organization.Position> positions = new ArrayList<>();
                                String pfx = type.name() + i;
                                String[] startDates = req.getParameterValues(pfx + "startDate");
                                String[] endDates = req.getParameterValues(pfx + "endDate");
                                String[] titles = req.getParameterValues(pfx + "title");
                                String[] descriptions = req.getParameterValues(pfx + "description");
                                for (int j = 0; j < titles.length; j++) {
                                    if (!HtmlUtil.isEmpty(titles[j])) {
                                        positions.add(new Organization.Position(DateUtil.parse(startDates[j]), DateUtil.parse(endDates[j]), titles[j], descriptions[j]));
                                    }
                                }
                                orgs.add(new Organization(new Link(name, urls[i]), positions));
                            }

                        }
                        resume.setSection(type, new OrganizationSection(orgs));
                        break;
                }

            }
        }

        if (req.getParameter("isCopy") != null && req.getParameter("isCopy").equals("true")) {
            isCopy = true;
        }

        if (isCreate || isCopy) {
            storage.save(resume);
        } else {
            storage.update(resume);
        }
        resp.sendRedirect("resume");
    }
    public void fillResumeEmpty(Resume resume){
        for (SectionType type : SectionType.values()) {
            Section section = resume.getSection(type);
            switch (type) {
                case OBJECTIVE:
                case PERSONAL:
                    if (section == null) {
                        section = TextSection.EMPTY;
                    }
                    break;
                case ACHIEVEMENT:
                case QUALIFICATIONS:
                    if (section == null) {
                        section = ListSection.EMPTY;
                    }
                    break;
                case EXPERIENCE:
                case EDUCATION:
                    OrganizationSection orgSection = (OrganizationSection) section;
                    List<Organization> emptyFirstOrganizations = new ArrayList<>();
                    emptyFirstOrganizations.add(Organization.EMPTY);
                    if (section != null) {
                        for (Organization organization : orgSection.getOrganizations()) {
                            List<Organization.Position> emptyFirstPositions = new ArrayList<>();
                            emptyFirstPositions.add(Organization.Position.EMPTY);
                            emptyFirstPositions.addAll(organization.getPositions());
                            emptyFirstOrganizations.add(new Organization(organization.getHomePage(), emptyFirstPositions));

                        }
                    }
                    section = new OrganizationSection(emptyFirstOrganizations);
                    break;
            }
            resume.setSection(type, section);
        }
    }
}
