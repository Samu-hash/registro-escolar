/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.utec.registroescolar.controller;

import com.utec.registroescolar.repository.TipoActividadesRepository;
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
public class TipoActividadController extends HttpServlet {

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
            request.getRequestDispatcher("/dashboard/tipo-actividad.jsp").forward(request, response);
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
            case "listarTipoAct":
                this.listarTipoAct(response);
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
        
        String nombre = request.getParameter("nombreTipoAct");
        String estadoTA = request.getParameter("estadoTA");
        String idTipoAct = request.getParameter("idTipoAct");
        
        String mensaje = "";
        if(Util.findNullOrEmpty(nombre) || 
                Util.findNullOrEmpty(estadoTA)){
            mensaje = "Por favor llenar los campos faltantes";
        }else{
            
            TipoActividadesRepository tipoActividadesRepository = new TipoActividadesRepository();
            
            if (Util.findNullOrEmpty(idTipoAct)) {
                
                boolean isSave = tipoActividadesRepository.saveTiposActividades(
                        nombre, estadoTA);
                
                if (isSave) {
                    mensaje = "Se ha guardado la materia";
                } else {
                    mensaje = "No se guardo la materia";
                }
            }else{
                boolean isUpdate = tipoActividadesRepository.updateTipoActividades(
                        nombre, estadoTA, Integer.parseInt(idTipoAct));
                
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

    private void listarTipoAct(HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonRespuesta = new JSONObject();
        TipoActividadesRepository tipoActividadesRepository = new TipoActividadesRepository();

        jsonRespuesta.put("listaTipoAct", tipoActividadesRepository.listarTiposActividades());

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
        TipoActividadesRepository tipoActividadesRepository = new TipoActividadesRepository();

        String idMateria = request.getParameter("materiaEliminar");

        boolean isDelete = tipoActividadesRepository.eliminarCiclo(Integer.parseInt(idMateria));

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
