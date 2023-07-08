package org.database.resume.web;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/locale")
public class LocaleServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String language = req.getParameter("lang");
        req.getSession().setAttribute("lang", language);
        String prevPage = req.getHeader("referer");
        Object page = prevPage != null ? prevPage : "login";
        resp.sendRedirect(page + "?lang=" + language);
    }
}
