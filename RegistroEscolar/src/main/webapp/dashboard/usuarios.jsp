<%@include file="../WEB-INF/template/header.jsp" %>    

<%@include file="../dashboard/template/menu.jsp" %>    

<%@include file="../dashboard/template/body-up.jsp" %>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
    <h1 class="h3 mb-0 text-gray-800">Usuarios</h1>
</div>

<!-- Content Row -->

<div class="row">
    <div class="col-xl-12 col-lg-12">
        <div class="card shadow mb-4">
            <!-- Card Header - Dropdown -->
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold text-primary">Gestion de usuarios</h6>

            </div>
            <!-- Card Body -->
            <div class="card-body">
                <div class="table-responsive">
                    <button class="btn btn-success" id="agregarUsuario">Agregar un usuario</button>
                    <br/>
                    <br/><hr/>
                    <table class="table table-bordered" id="dtUsuario" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Nombres</th>
                                <th>Apellidos</th>
                                <th>Correo</th>
                                <th>Estado pago</th>
                                <th>Role</th>
                                <th>Ciclo</th>
                                <th>Estado</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>Nombres</th>
                                <th>Apellidos</th>
                                <th>Correo</th>
                                <th>Estado pago</th>
                                <th>Role</th>
                                <th>Ciclo</th>
                                <th>Estado</th>
                                <th></th>
                            </tr>
                        </tfoot>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="usuarios" tabindex="-1" data-backdrop="static" 
     data-keyboard="false" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" >Usuarios</h5>
            </div>
            <form id="usuario" name="usuario" class="user">
                <div class="modal-body">
                    <div class="form-group">
                        <input class="form-control form-control-user" type="text" name="nombre" id="nombre" 
                               placeholder="Ingrese un nombre"/>
                    </div>
                    <div class="form-group">
                        <input class="form-control form-control-user" type="text" name="apellido" id="apellido" 
                               placeholder="Ingrese un apellido"/>
                    </div>
                    <div class="form-group">
                        <input class="form-control form-control-user" type="text" name="correo" id="correo" 
                               placeholder="Ingrese un correo"/>
                    </div>
                    <div class="form-group">
                        <input class="form-control form-control-user" type="text" name="contrasena" id="contrasena" 
                               placeholder="Ingrese una contraseña"/>
                    </div>
                    <div class="form-group">
                        <select class="form-control form-control-user"  id="ciclo" name="ciclo">
                            <option value="">--Seleccione un ciclo--</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <select class="form-control form-control-user"  id="role" name="role">
                            <option value="">--Seleccione un role--</option>
                            <option value="ADMINISTRADOR">ADMINISTRADOR</option>
                            <option value="DOCENTE">DOCENTE</option>
                            <option value="ALUMNO">ALUMNO</option>
                        </select> 
                    </div>

                    <div class="form-group">
                        <select class="form-control form-control-user"  id="pago" name="pago">
                            <option value="">--Seleccione un estado de pago--</option>
                            <option value="PENDIENTE">PENDIENTE</option>
                            <option value="SOLVENTE">SOLVENTE</option>
                        </select> 
                    </div>

                    <div class="form-group">
                        <select class="form-control form-control-user"  id="estadoU" name="estadoU">
                            <option value="">--Seleccione un estado del usuario--</option>
                            <option value="PENDIENTE APROV">PENDIENTE APROV</option>
                            <option value="ACTIVO">ACTIVO</option>
                        </select> 
                    </div>
                    <hr/>
                    <h5 id="mensajeUsuario"></h5>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="action" id="action"/>
                    <input type="hidden" name="idUsuario" id="idUsuario"/>
                    <button class="btn btn-secondary" type="button" id="cerrarModalUsuario">No</button>
                    <button class="btn btn-primary" type="submit" id="guardar">Si</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="eliminarUsuarioModal" tabindex="-1" role="dialog"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Eliminar usuario </h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="eliminacionUsuarioInput"/>
                Desea eliminar el usuario?</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">No</button>
                <button class="btn btn-primary" type="button" id="eliminarUsuarioBtn" data-dismiss="modal">Si</button>
            </div>
        </div>
    </div>
</div>

<%@include file="../dashboard/template/body-donw.jsp" %>

<%@include file="../WEB-INF/template/footer.jsp" %>

<script>
    $(document).ready(function () {

        let listarCiclo = () => {
            $.ajax({
                url: $('body').attr('data-url') + "/UsuariosController",
                data: {
                    'action': 'listarCiclos'
                },
                type: "POST",
                success: function (response) {
                    response.listaCiclos.forEach(function (obj) {
                        let option = '<option value="' + obj.ciclo_id + '">' + obj.nombre_ciclo + ' - ' + obj.anio_academico + '</option>'
                        $("#ciclo").append(option)
                    });
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        }

        let listar = () => {
            $.ajax({
                url: $('body').attr('data-url') + "/UsuariosController",
                data: {
                    'action': 'listarUsuarios'
                },
                type: "POST",
                success: function (response) {
                    response.listaUsuarios.forEach(function (obj) {
                        let row = '<tr><td>' + obj.nombre + '</td>';
                        row += '<td>' + obj.apellido + '</td><td>' + obj.correo_electronico + '</td>';
                        row += '<td>' + obj.estado_pago + '</td>';
                        row += '<td>' + obj.role + '</td>';
                        row += '<td>' + (obj.cicloActual == null ? '' : obj.cicloActual.anio_academico) + '</td>';
                        row += '<td>' + obj.estado_usuario + '</td>';
                        row += '<td><button class="btn btn-danger" id="eliminar-' + obj.user_id + '">Eliminar</button> ';
                        row += '<button class="btn btn-warning" id="actualizar-' + obj.user_id + '">Actualizar</button></td>';
                        $('#dtUsuario > tbody').append(row);
                        eliminar(obj);
                        actualizar(obj);
                    });
                    $('#dtUsuario').DataTable();
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        }

        let eliminar = (obj) => {
            $('#eliminar-' + obj.user_id).click((e) => {
                e.preventDefault();
                $('#eliminacionUsuarioInput').val(obj.user_id)
                $('#eliminarUsuarioModal').modal()
                $('#eliminarUsuarioBtn').click((e) => {
                    e.preventDefault();
                    $.ajax({
                        url: $('body').attr('data-url') + "/UsuariosController",
                        data: {
                            'action': 'eliminar',
                            'usuarioEliminar': $('#eliminacionUsuarioInput').val()
                        },
                        type: 'POST',
                        success: function (response) {
                            alert(response.mensaje);
                            $('#dtUsuario > tbody').remove();
                            location.reload()
                        },
                        error: function (xhr, status, error) {
                            alert("Error: " + error);
                        }
                    })
                })
            });
        }

        let actualizar = (obj) => {
            $('#actualizar-' + obj.user_id).click((e) => {
                e.preventDefault();
                $("#nombre").val(obj.nombre);
                $("#apellido").val(obj.apellido);
                $("#correo").val(obj.correo_electronico);
                $("#contrasena").val(obj.contrasena);
                $("#role").val(obj.role);
                $("#pago").val(obj.estado_pago);
                $("#ciclo").val(obj.ciclo_actual);
                $("#estadoU").val(obj.estado_usuario);
                $("#action").val("actualizar");
                $("#idUsuario").val(obj.user_id);
                $("#usuarios").modal()
            });
        }

        $("#usuario").submit(function (e) {
            e.preventDefault();
            $.ajax({
                url: $('body').attr('data-url') + "/UsuariosController",
                data: {
                    'action': $('#action').val(),
                    'nombre': $('#nombre').val(),
                    'apellido': $('#apellido').val(),
                    'correo': $('#correo').val(),
                    'contrasena': $('#contrasena').val(),
                    'role': $('#role').val(),
                    'ciclo': $('#ciclo').val(),
                    'pago': $('#pago').val(),
                    'estadoU': $('#estadoU').val(),
                    'idUsuario': $('#idUsuario').val()
                },
                type: "POST",
                success: function (response) {
                    $('#mensajeUsuario').text(response.mensaje);
                    alert(response.mensaje);
                    location.reload()
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        });

        $("#agregarUsuario").click((e) => {
            e.preventDefault()

            $("#action").val("guardar");
            $("#usuarios").modal()
        })

        $("#cerrarModalUsuario").click((e) => {
            e.preventDefault()
            $("#nombre").val("");
            $("#apellido").val("");
            $("#correo").val("");
            $("#contrasena").val("");
            $("#role").val("");
            $("#pago").val("");
            $("#ciclo").val("");
            $("#estadoU").val("");
            $("#action").val("");
            $("#idUsuario").val("");
            $("#usuarios").modal('hide')
        })

        listar();
        listarCiclo();
    });
</script>