/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.utec.registroescolar.controller;

import com.utec.registroescolar.entities.Usuarios;
import com.utec.registroescolar.repository.MateriasRepository;
import com.utec.registroescolar.repository.UsuariosRepository;
import com.utec.registroescolar.resources.Util;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Objects;
import org.json.JSONObject;

/**
 *
 * @author Samuel
 */
public class MateriasController extends HttpServlet {

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
            request.getRequestDispatcher("/dashboard/materias.jsp")
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
            case "listarDocentes":
                this.listarDocentes(request, response);
                break;
            case "listarMaterias":
                this.listarMaterias(response);
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

        String nombreMateria = request.getParameter("nombreMateria");
        String descripcion = request.getParameter("descripcion");
        String docente = request.getParameter("docenteSelect");
        String estado = request.getParameter("estadoM");
        String idMateria = request.getParameter("idMateria");

        String mensaje = "";
        if (Util.findNullOrEmpty(nombreMateria)
                || Util.findNullOrEmpty(descripcion)
                || Util.findNullOrEmpty(docente)
                || Util.findNullOrEmpty(estado)) {
            mensaje = "Por favor llene los campos faltantes";
        } else {
            MateriasRepository materiasRepository = new MateriasRepository();

            if (Util.findNullOrEmpty(idMateria)) {

                boolean isSave = materiasRepository.saveUser(nombreMateria,
                        descripcion, Integer.parseInt(docente),
                        estado);

                if (isSave) {
                    mensaje = "Se ha guardado la materia";
                } else {
                    mensaje = "No se guardo la materia";
                }
            } else {
                boolean isUpdate = materiasRepository.updateUser(nombreMateria, descripcion,
                        Integer.parseInt(docente), estado, Integer.parseInt(idMateria));
                if (isUpdate) {
                    mensaje = "Se ha actualizado la materia";
                } else {
                    mensaje = "No se actualizo la materia";
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

    private void listarMaterias(HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonRespuesta = new JSONObject();
        MateriasRepository materiasRepository = new MateriasRepository();

        jsonRespuesta.put("listaMaterias", materiasRepository.listarMaterias());

        // Configurar la respuesta del servlet como un objeto JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Enviar el objeto JSON como respuesta al cliente (página JSP)
        response.getWriter().write(jsonRespuesta.toString());
    }

    private void listarDocentes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonRespuesta = new JSONObject();
        UsuariosRepository usuariosRepository = new UsuariosRepository();

        HttpSession session = request.getSession(false);
        Usuarios u = (Usuarios) session.getAttribute("usuario");

        jsonRespuesta.put("listaDocentes", usuariosRepository.listarUsuarios(
                u.getUser_id(), true, true));

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
        MateriasRepository ciclosRepository = new MateriasRepository();

        Integer idMateria = Integer.parseInt(
                request.getParameter("materiaEliminar"));

        boolean isDelete = ciclosRepository.eliminarCiclo(idMateria);
        if (isDelete) {
            jsonRespuesta.put("mensaje", "Se ha eliminado el materias");
        } else {
            jsonRespuesta.put("mensaje", "No se elimino el materias");
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
