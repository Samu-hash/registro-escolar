/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.utec.registroescolar.controller;

import com.utec.registroescolar.repository.MateriasCiclosRepository;
import com.utec.registroescolar.resources.Util;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.Objects;
import org.json.JSONObject;

/**
 *
 * @author Samuel
 */
public class MateriasCiclosController extends HttpServlet {

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
            request.getRequestDispatcher("/dashboard/materia-ciclo.jsp").forward(request, response);
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

        String materiaId = request.getParameter("idMateriaS");
        String cicloId = request.getParameter("idCicloS");
        String estado = request.getParameter("estadoS");
        String fechaIni = request.getParameter("peIni");
        String fechaEnd = request.getParameter("peFin");
        String materiaCicloId = request.getParameter("idMateriaCiclo");

        String mensaje = "";
        int isError = 0;
        if (Util.findNullOrEmpty(materiaId)
                || Util.findNullOrEmpty(cicloId)
                || Util.findNullOrEmpty(estado)
                || Util.findNullOrEmpty(fechaIni) || Util.findNullOrEmpty(fechaEnd)) {
            mensaje = "Por favor llenar los campos faltantes";
            isError = 1;
        } else {

            boolean existe = false;
            MateriasCiclosRepository materiasCiclosRepository = new MateriasCiclosRepository();
            if (Util.findNullOrEmpty(materiaCicloId)) {
                 existe = materiasCiclosRepository.existeRegistroMateriaCiclo(Integer.parseInt(materiaId),
                        Integer.parseInt(cicloId));
            }

            isError = existe ? 1 : 0;

            if (!existe) {
                if (Util.findNullOrEmpty(materiaCicloId)) {

                    boolean isSave = materiasCiclosRepository.saveMateriasCiclo(Integer.parseInt(materiaId),
                            Integer.parseInt(cicloId), estado, fechaIni, fechaEnd);

                    if (isSave) {
                        mensaje = "Se ha guardado la materia";
                    } else {
                        mensaje = "No se guardo la materia";
                    }
                } else {
                    boolean isUpdate = materiasCiclosRepository.updateMateriasCiclo(Integer.parseInt(materiaCicloId), Integer.parseInt(cicloId),
                            estado, fechaIni, fechaEnd, Integer.parseInt(materiaCicloId));

                    if (isUpdate) {
                        mensaje = "Se ha actualizado la materia";
                    } else {
                        mensaje = "No se actualizo la materia";
                    }
                }
            } else {
                mensaje = "No se puede realizar la gestion ya que existe un registro con los parametros enviados.";
                isError = 1;
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
        MateriasCiclosRepository materiasCiclosRepository = new MateriasCiclosRepository();

        jsonRespuesta.put("lista", materiasCiclosRepository.listarMateriasCiclos(0));

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
        MateriasCiclosRepository materiasCiclosRepository = new MateriasCiclosRepository();

        String materiaCicloId = request.getParameter("materiaCicloEliminar");

        boolean isDelete = materiasCiclosRepository.eliminarCiclo(Integer.parseInt(materiaCicloId));

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
