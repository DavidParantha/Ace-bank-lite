package com.acebank.lite.controllers;

import com.acebank.lite.service.BankService;
import com.acebank.lite.service.BankServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.java.Log;

import java.io.IOException;
import java.io.Serial;

 
@Log
@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final BankService bankService = new BankServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountNumber") == null) {
            response.sendRedirect("login.jsp?error=unauthorized");
            return;
        }

        String action = request.getParameter("action");
        int accountNo = (int) session.getAttribute("accountNumber");

        if (!"changePassword".equals(action)) {
            response.sendRedirect("ChangePassword.jsp");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Basic Validation
        if (currentPassword == null || newPassword == null || confirmPassword == null) {
            response.sendRedirect("ChangePassword.jsp?error=missing");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("ChangePassword.jsp?error=mismatch");
            return;
        }

        if (newPassword.length() < 10) {
            response.sendRedirect("ChangePassword.jsp?error=tooshort");
            return;
        }

        if (currentPassword.trim().equals(newPassword.trim())) {
            response.sendRedirect("ChangePassword.jsp?error=same");
            return;
        }

        try {
            boolean success = bankService.changePassword(accountNo, currentPassword, newPassword);
            if (success) {
                log.info("Password updated successfully for account: " + accountNo);
                response.sendRedirect("ChangePassword.jsp?success=Password+changed+successfully");
            } else {
                response.sendRedirect("ChangePassword.jsp?error=wrongcurrent");
            }
        } catch (Exception e) {
            log.severe("Error in ChangePasswordServlet: " + e.getMessage());
            response.sendRedirect("ChangePassword.jsp?error=system");
        }
    }
}
