package org.database.resume.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.database.resume.dto.CreateUserDto;
import org.database.resume.service.UserService;

import java.io.IOException;

@WebServlet("/registration")
public class RegistrationServlet extends HttpServlet {

    private final UserService userService = UserService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/jsp/login/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        userService.checkEmail(req.getParameter("email")).ifPresentOrElse(
                user -> onLoginFail(resp),
                () -> onLoginSuccess(req, resp)
        );
    }

    @SneakyThrows
    private void onLoginFail(HttpServletResponse resp) {
        resp.sendRedirect("login?errorReg");
    }

    @SneakyThrows
    private void onLoginSuccess(HttpServletRequest req, HttpServletResponse resp) {
        CreateUserDto userDto = CreateUserDto.builder()
                .name(req.getParameter("name"))
                .email(req.getParameter("email"))
                .password(req.getParameter("password"))
                .build();
        userService.create(userDto);
        resp.sendRedirect("login?success");
    }
}
