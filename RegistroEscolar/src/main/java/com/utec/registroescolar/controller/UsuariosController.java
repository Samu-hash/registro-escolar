/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.utec.registroescolar.controller;

import com.utec.registroescolar.repository.CiclosRepository;
import com.utec.registroescolar.repository.UsuariosRepository;
import com.utec.registroescolar.resources.Util;
import java.io.IOException;
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
public class UsuariosController extends HttpServlet {

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
            request.getRequestDispatcher("/dashboard/usuarios.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

        String action = request.getParameter("action");

        switch (action) {
            case "guardar":
            case"actualizar":
                this.guardar(request, response);
                break;
            case "listarCiclos":
                this.listarCiclos(response);
                break;
            case "listarUsuarios":
                this.listarUsuarios(response);
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

    private void listarUsuarios(HttpServletResponse response)
            throws ServletException, IOException {
        JSONObject jsonRespuesta = new JSONObject();
        UsuariosRepository usuariosRepository = new UsuariosRepository();

        jsonRespuesta.put("listaUsuarios", usuariosRepository.listarUsuarios());

        // Configurar la respuesta del servlet como un objeto JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Enviar el objeto JSON como respuesta al cliente (página JSP)
        response.getWriter().write(jsonRespuesta.toString());
    }

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

        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String role = request.getParameter("role");
        String ciclo = request.getParameter("ciclo");
        String pago = request.getParameter("pago");
        String estadoU = request.getParameter("estadoU");

        String mensaje = "";
        if (Util.findNullOrEmpty(nombre) || Util.findNullOrEmpty(apellido)
                || Util.findNullOrEmpty(correo) || Util.findNullOrEmpty(contrasena)
                || Util.findNullOrEmpty(role) || Util.findNullOrEmpty(ciclo)
                || Util.findNullOrEmpty(pago) || Util.findNullOrEmpty(estadoU)) {
            mensaje = "Por favor llene los campos faltantes";
        }else{
            UsuariosRepository usuariosRepository = new UsuariosRepository();
            
            String esDocente = "0";
            if(role.equals("DOCENTE"))
                esDocente = "1";
            
            boolean isSave = usuariosRepository.saveUser(nombre, 
                    apellido, correo, contrasena, esDocente, 
                    pago, Integer.parseInt(ciclo), role, estadoU);
            
            if(isSave)
                mensaje = "Se ha guardado el usuario";
            else
                mensaje = "No se guardo el usuario";
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
            throws ServletException, IOException{
        
        JSONObject jsonRespuesta = new JSONObject();
        UsuariosRepository usuariosRepository = new UsuariosRepository();
        
        Integer idUsuario = Integer.parseInt(
                request.getParameter("usuarioEliminar"));

        boolean isDelete  = usuariosRepository.eliminarUsuario(idUsuario);
        if(isDelete)
            jsonRespuesta.put("mensaje", "Se ha eliminado el registro");
        else
            jsonRespuesta.put("mensaje", "No se elimino");

        // Configurar la respuesta del servlet como un objeto JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Enviar el objeto JSON como respuesta al cliente (página JSP)
        response.getWriter().write(jsonRespuesta.toString());
    }
}
