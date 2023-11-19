/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.utec.registroescolar.controller;

import com.utec.registroescolar.repository.CiclosRepository;
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
public class CiclosController extends HttpServlet {

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
            request.getRequestDispatcher("/dashboard/ciclos.jsp")
                    .forward(request, response);
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
            case "listarCiclos":
                this.listarCiclos(response);
                break;
            case "eliminar":
                this.eliminar(request, response);
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

    private void listarCiclos(HttpServletResponse response)
            throws ServletException, IOException {
        JSONObject jsonRespuesta = new JSONObject();
        CiclosRepository ciclosRepository = new CiclosRepository();

        jsonRespuesta.put("listaCiclos", ciclosRepository.listarCiclos());

        // Configurar la respuesta del servlet como un objeto JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Enviar el objeto JSON como respuesta al cliente (página JSP)
        response.getWriter().write(jsonRespuesta.toString());
    }

    private void guardar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonRespuesta = new JSONObject();

        String nombreCiclo = request.getParameter("nombreCiclo");
        String anioAcademico = request.getParameter("anioAcademico");
        String estadoC = request.getParameter("estadoC");
        String idCiclo = request.getParameter("idCiclo");

        String mensaje = "";
        if (Util.findNullOrEmpty(nombreCiclo)
                || Util.findNullOrEmpty(anioAcademico)
                || Util.findNullOrEmpty(estadoC)) {
            mensaje = "Por favor llene los campos faltantes";
        } else {
            CiclosRepository ciclosRepository = new CiclosRepository();

            if (Util.findNullOrEmpty(idCiclo)) {

                boolean isSave = ciclosRepository.saveCiclo(nombreCiclo, 
                        Integer.parseInt(anioAcademico), estadoC);

                if (isSave) {
                    mensaje = "Se ha guardado el ciclo";
                } else {
                    mensaje = "No se guardo el ciclo";
                }
            } else {
                boolean isUpdate = ciclosRepository.updateCiclo(nombreCiclo, 
                        Integer.parseInt(anioAcademico), estadoC, Integer.parseInt(idCiclo));
                if (isUpdate) {
                    mensaje = "Se ha actualizado el ciclo";
                } else {
                    mensaje = "No se actualizo el ciclo";
                }
            }

        }

        jsonRespuesta.put("mensaje", mensaje);

        // Configurar la respuesta del servlet como un objeto JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Enviar el objeto JSON como respuesta al cliente (página JSP)
        response.getWriter().write(jsonRespuesta.toString());
    }

    private void eliminar(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        JSONObject jsonRespuesta = new JSONObject();
        CiclosRepository ciclosRepository = new CiclosRepository();

        Integer idCiclo = Integer.parseInt(
                request.getParameter("cicloEliminar"));

        boolean isDelete = ciclosRepository.eliminarCiclo(idCiclo);
        if (isDelete) {
            jsonRespuesta.put("mensaje", "Se ha eliminado el ciclo");
        } else {
            jsonRespuesta.put("mensaje", "No se elimino el ciclo");
        }

        // Configurar la respuesta del servlet como un objeto JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Enviar el objeto JSON como respuesta al cliente (página JSP)
        response.getWriter().write(jsonRespuesta.toString());
    }

}
