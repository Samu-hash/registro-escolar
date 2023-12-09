<%@include file="../WEB-INF/template/header.jsp" %>    

<%@include file="../dashboard/template/menu.jsp" %>    

<%@include file="../dashboard/template/body-up.jsp" %>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
    <h1 class="h3 mb-0 text-gray-800">Materias</h1>
</div>

<!-- Content Row -->

<div class="row">
    <div class="col-xl-12 col-lg-12">
        <div class="card shadow mb-4">
            <!-- Card Header - Dropdown -->
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold text-primary">Gestion de materias</h6>

            </div>
            <!-- Card Body -->
            <div class="card-body">
                <div class="table-responsive">
                    <button class="btn btn-success" id="agregarMateria">Agregar una materia</button>
                    <br/>
                    <br/><hr/>
                    <table class="table table-bordered" id="dtMateria" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombres Materia</th>
                                <th>Descripcion</th>
                                <th>Docente</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>ID</th>
                                <th>Nombres Materia</th>
                                <th>Descripcion</th>
                                <th>Docente</th>
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

<div class="modal fade" id="materia" tabindex="-1" data-backdrop="static" 
     data-keyboard="false" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" >Materia</h5>
            </div>
            <form id="materiaF" name="materiaF" class="user">
                <div class="modal-body">
                    <div class="form-group">
                        <input class="form-control form-control-user" type="text" name="nombreMateria" id="nombreMateria" 
                               placeholder="Ingrese un nombre de materia"/>
                    </div>
                    <div class="form-group">
                        <input class="form-control form-control-user" type="text" name="descripcion" id="descripcion" 
                               placeholder="Ingrese una descripcion"/>
                    </div>
                    <div class="form-group">
                        <select class="form-control form-control-user"  id="docenteSelect" name="docenteSelect">
                            <option value="">--Seleccione un docente--</option>
                        </select> 
                    </div>

                    <div class="form-group">
                        <select class="form-control form-control-user"  id="estadoM" name="estadoM">
                            <option value="">--Seleccione un estado--</option>
                            <option value="ACTIVO">ACTIVO</option>
                            <option value="PENDIENTE">PENDIENTE</option>
                        </select> 
                    </div>
                    <hr/>
                    <h5 id="mensajeMateria"></h5>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="action" id="action"/>
                    <input type="hidden" name="idMateria" id="idMateria"/>
                    <button class="btn btn-secondary" type="button" id="cerrarModalMateria">No</button>
                    <button class="btn btn-primary" type="submit" id="guardar">Si</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="eliminarMateriaModal" tabindex="-1" role="dialog"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Eliminar Materia </h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="eliminacionMateriaInput"/>
                Desea eliminar la materia?</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">No</button>
                <button class="btn btn-primary" type="button" id="eliminarMateriaBtn" data-dismiss="modal">Si</button>
            </div>
        </div>
    </div>
</div>

<%@include file="../dashboard/template/body-donw.jsp" %>

<%@include file="../WEB-INF/template/footer.jsp" %>

<script>
    $(document).ready(function () {

        let listarDocentes = () => {
            $.ajax({
                url: $('body').attr('data-url') + "/MateriasController",
                data: {
                    'action': 'listarDocentes'
                },
                type: "POST",
                success: function (response) {
                    response.listaDocentes.forEach(function (obj) {
                        let option = '<option value="' + obj.user_id + '">' + obj.nombre + ' - ' + obj.apellido + '</option>';
                        $("#docenteSelect").append(option)
                    });
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        }

        let listarMaterias = () => {
            $.ajax({
                url: $('body').attr('data-url') + "/MateriasController",
                data: {
                    'action': 'listarMaterias'
                },
                type: "POST",
                success: function (response) {
                    response.listaMaterias.forEach(function (obj) {
                        let row = '<tr><td>' + obj.materia_id + '</td><td>' + obj.nombre_materia + '</td>';
                        row += '<td>' + obj.descripcion + '</td>';
                        row += '<td>' + obj.docente.nombre +' '+ obj.docente.apellido +'</td>';
                        row += '<td><button class="btn btn-danger" id="eliminar-' + obj.materia_id + '">Eliminar</button> ';
                        row += '<button class="btn btn-warning" id="actualizar-' + obj.materia_id + '">Actualizar</button></td>';
                        $('#dtMateria > tbody').append(row);
                        eliminar(obj);
                        actualizar(obj);
                    });
                    $('#dtMateria').DataTable();
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        }

        let eliminar = (obj) => {
            $('#eliminar-' + obj.materia_id).click((e) => {
                e.preventDefault();
                $('#eliminacionMateriaInput').val(obj.materia_id)
                $('#eliminarMateriaModal').modal()
                $('#eliminarMateriaBtn').click((e) => {
                    e.preventDefault();
                    $.ajax({
                        url: $('body').attr('data-url') + "/MateriasController",
                        data: {
                            'action': 'eliminar',
                            'materiaEliminar': $('#eliminacionMateriaInput').val()
                        },
                        type: 'POST',
                        success: function (response) {
                            alert(response.mensaje);
                            $('#dtMateria > tbody').remove();
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
            $('#actualizar-' + obj.materia_id).click((e) => {
                console.log(obj)
                e.preventDefault();
                $("#nombreMateria").val(obj.nombre_materia);
                $("#descripcion").val(obj.descripcion);
                $("#docenteSelect").val(obj.docente_id);
                $("#estadoM").val(obj.estado);
                $("#idMateria").val(obj.materia_id);
                $("#action").val("actualizar");
                $("#materia").modal()
            });
        }

        $("#materiaF").submit(function (e) {
            e.preventDefault();
            $.ajax({
                url: $('body').attr('data-url') + "/MateriasController",
                data: {
                    'action': $('#action').val(),
                    'nombreMateria': $('#nombreMateria').val(),
                    'descripcion': $('#descripcion').val(),
                    'docenteSelect': $('#docenteSelect').val(),
                    'estadoM': $('#estadoM').val(),
                    'idMateria': $('#idMateria').val()
                },
                type: "POST",
                success: function (response) {
                    $('#mensajeMateria').text(response.mensaje);
                    alert(response.mensaje);
                    location.reload()
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        });

        $("#agregarMateria").click((e) => {
            e.preventDefault()

            $("#action").val("guardar");
            $("#materia").modal()
        })

        $("#cerrarModalMateria").click((e) => {
            e.preventDefault()
            $("#nombreMateria").val("");
            $("#descripcion").val("");
            $("#docenteSelect").val("");
            $("#idMateria").val("");
            $("#materia").modal('hide')
        })

        listarMaterias();
        listarDocentes();
    });
</script>