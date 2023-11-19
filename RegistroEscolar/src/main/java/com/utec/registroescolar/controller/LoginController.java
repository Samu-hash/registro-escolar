/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.utec.registroescolar.controller;

import com.utec.registroescolar.repository.UsuariosRepository;
import com.utec.registroescolar.resources.Util;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Objects;

/**
 *
 * @author Samuel
 */
public class LoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

        if (!Objects.isNull(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/DashboardController");
        } else {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

        String action = request.getParameter("action");

        switch (action) {
            case "login":
                this.login(request, response);
                break;
            case "create":
                this.createAccount(request, response);
                break;
            default:
                throw new AssertionError();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String message = "";
        if (Util.findNullOrEmpty(email) || Util.findNullOrEmpty(password)) {
            message = "Es requerido el usuario y contraseña";
            request.setAttribute("message", message);
            response.sendRedirect(request.getContextPath() + "/DashboardController");
        } else {
            UsuariosRepository usuariosRepository = new UsuariosRepository();
            boolean isAuth = usuariosRepository.validateCredential(email, password);

            if (isAuth) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuariosRepository.buscarUsuario(email));
                //response.sendRedirect("/dashboard/dashboard.jsp");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/dashboard/dashboard.jsp");
                dispatcher.forward(request, response);
            } else {
                message = "Credenciales no validas";
                request.setAttribute("message", message);
                RequestDispatcher dispatcher = request.getRequestDispatcher(request.getContextPath() + "/LoginController");
                dispatcher.forward(request, response);
            }
        }
    }

    private void createAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");
        String claveR = request.getParameter("claveR");
        String message = "";
        if (Util.findNullOrEmpty(nombres)
                || Util.findNullOrEmpty(apellidos)
                || Util.findNullOrEmpty(correo)
                || Util.findNullOrEmpty(clave)) {
            message = "Por favor llenar los cambios restantes";
            request.setAttribute("message", message);
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request, response);
        } else {

            if (!clave.equals(claveR)) {
                request.setAttribute("message", "Las claves no coinciden.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
                dispatcher.forward(request, response);
            } else {
                UsuariosRepository usuariosRepository = new UsuariosRepository();
                boolean isUpdate = usuariosRepository.saveUser(nombres, apellidos, correo, clave, "0", null, null, "ALUMNO", "PENDIENTE APROV");

                message = isUpdate ? "Usuario creado." : "No se pudo crear el usuario.";
                request.setAttribute("message", message);
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }
        }
    }
}
