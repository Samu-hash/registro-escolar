<%@include file="../WEB-INF/template/header.jsp" %>    

<%@include file="../dashboard/template/menu.jsp" %>    

<%@include file="../dashboard/template/body-up.jsp" %>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
    <h1 class="h3 mb-0 text-gray-800">Inscripciones</h1>
</div>

<!-- Content Row -->

<div class="row">
    <div class="col-xl-12 col-lg-12">
        <div class="card shadow mb-4">
            <!-- Card Header - Dropdown -->
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold text-primary">Gestion de inscripciones</h6>

            </div>
            <!-- Card Body -->
            <div class="card-body">
                <div class="table-responsive">
                    <button class="btn btn-success" id="agregarInscripciones">Agregar una inscripcion</button>
                    <br/>
                    <br/><hr/>
                    <table class="table table-bordered" id="dtInscripciones" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Alumno</th>
                                <th>Materia</th>
                                <th>Fecha</th>
                                <th>Estado</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>ID</th>
                                <th>Alumno</th>
                                <th>Materia</th>
                                <th>Fecha</th>
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

<div class="modal fade" id="inscripcionesM" tabindex="-1" data-backdrop="static" 
     data-keyboard="false" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" >Inscripciones</h5>
            </div>
            <form id="inscripcionesF" name="inscripcionesF" class="user">
                <div class="modal-body">
                    <div class="form-group">
                        <select class="form-control form-control-user" name="idMateriaCicloS" id="idMateriaCicloS" >
                            <option value="">--Seleccione una materia en ciclo--</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control form-control-user" name="idAlumnoS" id="idAlumnoS" >
                            <option value="">--Seleccione un alumno--</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <input class="form-control form-control-user" type="date" id="fechaIns" 
                               name="fechaIns" placeholder="Ingrese una fecha." />
                    </div>
                    <div class="form-group">
                        <select class="form-control form-control-user"  id="estadoS" name="estadoS">
                            <option value="">--Seleccione un estado--</option>
                            <option value="ACTIVO">ACTIVO</option>
                            <option value="PENDIENTE">PENDIENTE</option>
                        </select> 
                    </div>
                    <hr/>
                    <h5 id="mensajeInscripciones"></h5>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="action" id="action"/>
                    <input type="hidden" name="idInscripcion" id="idInscripcion"/>
                    <button class="btn btn-secondary" type="button" id="cerrarModalInscripciones">No</button>
                    <button class="btn btn-primary" type="submit" id="guardar">Si</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="eliminarInscripcionModal" tabindex="-1" role="dialog"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Eliminar una Inscripción</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="eliminacionInscripcionInput"/>
                Desea eliminar la inscripcion de ciclo?</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">No</button>
                <button class="btn btn-primary" type="button" id="eliminarInscripcionBtn" data-dismiss="modal">Si</button>
            </div>
        </div>
    </div>
</div>

<%@include file="../dashboard/template/body-donw.jsp" %>

<%@include file="../WEB-INF/template/footer.jsp" %>

<script>
    $(document).ready(function () {

        let listarInscripciones = () => {
            $.ajax({
                url: $('body').attr('data-url') + "/InscripcionesController",
                data: {
                    'action': 'listar'
                },
                type: "POST",
                success: function (response) {
                    response.lista.forEach(function (obj) {
                        let row = '<tr><td>' + obj.inscripcion_id + '</td><td>' + obj.usuario.nombre + '- '+obj.usuario.apellido+'</td>';
                        row += '<td>' + obj.materiasEnCiclo.materia.descripcion + ' - ' 
                                + obj.materiasEnCiclo.materia.docente.nombre + ' '+obj.materiasEnCiclo.materia.docente.apellido+'</td>';
                        row += '<td>' + obj.fecha_inscripcion + '</td>'
                        row += '<td>' + obj.estado + '</td>'
                        row += '<td><button class="btn btn-danger" id="eliminar-' + obj.inscripcion_id + '">Eliminar</button> ';
                        row += '<button class="btn btn-warning" id="actualizar-' + obj.inscripcion_id + '">Actualizar</button></td>';
                        $('#dtInscripciones > tbody').append(row);
                        eliminar(obj);
                        actualizar(obj);
                    });
                    $('#dtInscripciones').DataTable();
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        }

        let listarMateriasCiclos = () => {
            $.ajax({
                url: $('body').attr('data-url') + "/MateriasCiclosController",
                data: {
                    'action': 'listar'
                },
                type: "POST",
                success: function (response) {
                    response.lista.forEach(function (obj) {
                        let option = '<option value="' + obj.materia_en_ciclo_id + '">' + obj.materia.nombre_materia + ' - ' + obj.ciclo.nombre_ciclo + '</option>';
                        $("#idMateriaCicloS").append(option)
                    });
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        }

        let listarAlumnos = () => {
            $.ajax({
                url: $('body').attr('data-url') + "/UsuariosController",
                data: {
                    'action': 'listarAlumnos'
                },
                type: "POST",
                success: function (response) {
                    response.listaAlumnos.forEach(function (obj) {
                        let option = '<option value="' + obj.user_id + '">' + obj.nombre + ' - ' + obj.apellido + '</option>';
                        $("#idAlumnoS").append(option)
                    });
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        }

        let eliminar = (obj) => {
            $('#eliminar-' + obj.inscripcion_id).click((e) => {
                e.preventDefault();
                $('#eliminacionInscripcionInput').val(obj.inscripcion_id)
                $('#eliminarInscripcionModal').modal()
                $('#eliminarInscripcionBtn').click((e) => {
                    e.preventDefault();
                    $.ajax({
                        url: $('body').attr('data-url') + "/InscripcionesController",
                        data: {
                            'action': 'eliminar',
                            'inscripcionEliminar': $('#eliminacionInscripcionInput').val()
                        },
                        type: 'POST',
                        success: function (response) {
                            alert(response.mensaje);
                            $('#dtInscripciones > tbody').remove();
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
            $('#actualizar-' + obj.inscripcion_id).click((e) => {
                e.preventDefault();
                $("#idMateriaCicloS").val(obj.materia_en_ciclo_id);
                $("#idAlumnoS").val(obj.user_id);
                $("#estadoS").val(obj.estado);
                $("#fechaIns").val(obj.fecha_inscripcion);
                $("#idInscripcion").val(obj.inscripcion_id);
                $("#action").val("actualizar");
                $("#inscripcionesM").modal();
            });
        }

        $("#inscripcionesF").submit(function (e) {
            e.preventDefault();
            $.ajax({
                url: $('body').attr('data-url') + "/InscripcionesController",
                data: {
                    'action': $('#action').val(),
                    'idMateriaCicloS': $('#idMateriaCicloS').val(),
                    'idAlumnoS': $('#idAlumnoS').val(),
                    'estadoS': $('#estadoS').val(),
                    'fechaIns':$('#fechaIns').val(),
                    'idInscripcion': $('#idInscripcion').val()
                },
                type: "POST",
                success: function (response) {
                    console.log(response)
                    $('#mensajeInscripciones').text(response.mensaje);

                    if (response.isError === 0) {
                        alert(response.mensaje);
                        location.reload();
                    }
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        });

        $("#agregarInscripciones").click((e) => {
            e.preventDefault()
            $("#action").val("guardar");
            $("#inscripcionesM").modal()
        })

        $("#cerrarModalInscripciones").click((e) => {
            e.preventDefault()
            $("#idMateriaS").val("");
            $("#idCicloS").val("");
            $("#estadoS").val("");
            $("#idInscripcion").val("");
            $("#action").val("");
            $("#inscripcionesM").modal('hide')
        });
        
        listarInscripciones();
        listarMateriasCiclos();
        listarAlumnos();
    });
</script>