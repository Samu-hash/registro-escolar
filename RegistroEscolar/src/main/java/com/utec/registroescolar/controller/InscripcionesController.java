/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.utec.registroescolar.controller;

import com.utec.registroescolar.repository.InscripcionesRepository;
import com.utec.registroescolar.resources.Util;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Objects;
import org.json.JSONObject;

/**
 *
 * @author Samuel
 */
public class InscripcionesController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

        if (Objects.isNull(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/LoginController");
        } else {
            request.getRequestDispatcher("/dashboard/inscripciones.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

        String action = request.getParameter("action");

        switch (action) {
            case "guardar":
            case "actualizar":
                this.guardar(request, response);
                break;
            case "listar":
                this.listar(response);
                break;
            case "eliminar":
                this.eliminar(request, response);
                break;
            default:
                throw new AssertionError();
        }
    }

    private void guardar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonRespuesta = new JSONObject();

        String userId = request.getParameter("idAlumnoS");
        String cicloMateriaCicloId = request.getParameter("idMateriaCicloS");
        String fechaIns = request.getParameter("fechaIns");
        String estadoS = request.getParameter("estadoS");
        String inscripcionId = request.getParameter("idInscripcion");

        String mensaje = "";
        Integer isError = 0;
        if (Util.findNullOrEmpty(userId)
                || Util.findNullOrEmpty(cicloMateriaCicloId) 
                || Util.findNullOrEmpty(fechaIns) 
                || Util.findNullOrEmpty(estadoS)) {
            mensaje = "Por favor llenar los campos faltantes";
            isError = 1;
        } else {

            InscripcionesRepository inscripcionesRepository = new InscripcionesRepository();

            if (Util.findNullOrEmpty(inscripcionId)) {

                boolean isSave = inscripcionesRepository.saveInscripciones(Integer.parseInt(userId), 
                        Integer.parseInt(cicloMateriaCicloId), 
                        fechaIns, estadoS);

                if (isSave) {
                    mensaje = "Se ha guardado la inscripcion";
                    isError = 0;
                } else {
                    mensaje = "No se guardo la inscripcion";
                    isError = 1;
                }
            } else {
                boolean isUpdate = inscripcionesRepository.updateInscripciones(Integer.parseInt(userId), 
                        Integer.parseInt(cicloMateriaCicloId), 
                        fechaIns, estadoS, Integer.parseInt(inscripcionId));

                if (isUpdate) {
                    mensaje = "Se ha actualizado la materia";
                    isError = 0;
                } else {
                    mensaje = "No se actualizo la materia";
                    isError = 1;
                }
            }
        }

        jsonRespuesta.put("mensaje", mensaje);
        jsonRespuesta.put("isError", isError);

        // Configurar la respuesta del servlet como un objeto JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Enviar el objeto JSON como respuesta al cliente (página JSP)
        response.getWriter().write(jsonRespuesta.toString());
    }

    private void listar(HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonRespuesta = new JSONObject();
        InscripcionesRepository inscripcionesRepository = new InscripcionesRepository();

        jsonRespuesta.put("lista", inscripcionesRepository.listarInscripciones());

        // Configurar la respuesta del servlet como un objeto JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Enviar el objeto JSON como respuesta al cliente (página JSP)
        response.getWriter().write(jsonRespuesta.toString());
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonRespuesta = new JSONObject();
        InscripcionesRepository inscripcionesRepository = new InscripcionesRepository();

        String inscripcionesId = request.getParameter("inscripcionEliminar");

        boolean isDelete = inscripcionesRepository.eliminar(Integer.parseInt(inscripcionesId));

        if (isDelete) {
            jsonRespuesta.put("mensaje", "Se ha eliminado el registro");
        } else {
            jsonRespuesta.put("mensaje", "No se ha eliminado el registro");
        }

        // Configurar la respuesta del servlet como un objeto JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Enviar el objeto JSON como respuesta al cliente (página JSP)
        response.getWriter().write(jsonRespuesta.toString());
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
