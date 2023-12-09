<%@include file="../WEB-INF/template/header.jsp" %>    

<%@include file="../dashboard/template/menu.jsp" %>    

<%@include file="../dashboard/template/body-up.jsp" %>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
    <h1 class="h3 mb-0 text-gray-800">Tipo Actividad</h1>
</div>

<!-- Content Row -->

<div class="row">
    <div class="col-xl-12 col-lg-12">
        <div class="card shadow mb-4">
            <!-- Card Header - Dropdown -->
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold text-primary">Gestion de Tipo de actividades</h6>

            </div>
            <!-- Card Body -->
            <div class="card-body">
                <div class="table-responsive">
                    <button class="btn btn-success" id="agregarTipoAct">Agregar un tipo de actividad</button>
                    <br/>
                    <br/><hr/>
                    <table class="table table-bordered" id="dtTipoAct" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre Tipo Act</th>
                                <th>Estado</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>ID</th>
                                <th>Nombre Tipo Act</th>
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

<div class="modal fade" id="tipoActM" tabindex="-1" data-backdrop="static" 
     data-keyboard="false" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" >Tipo de actividad</h5>
            </div>
            <form id="tipoActF" name="tipoActF" class="user">
                <div class="modal-body">
                    <div class="form-group">
                        <input class="form-control form-control-user" type="text" name="nombreTipoAct" id="nombreTipoAct" 
                               placeholder="Ingrese un nombre de materia"/>
                    </div>
                    <div class="form-group">
                        <select class="form-control form-control-user"  id="estadoTA" name="estadoTA">
                            <option value="">--Seleccione un estado--</option>
                            <option value="ACTIVO">ACTIVO</option>
                            <option value="PENDIENTE">PENDIENTE</option>
                        </select> 
                    </div>
                    <hr/>
                    <h5 id="mensajeTipoAct"></h5>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="action" id="action"/>
                    <input type="hidden" name="idTipoAct" id="idTipoAct"/>
                    <button class="btn btn-secondary" type="button" id="cerrarModalTipoAct">No</button>
                    <button class="btn btn-primary" type="submit" id="guardar">Si</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="eliminarTipoActModal" tabindex="-1" role="dialog"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Eliminar Tipo Actividad </h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="eliminacionTipoActInput"/>
                Desea eliminar la tipo actividad?</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">No</button>
                <button class="btn btn-primary" type="button" id="eliminarTipoActBtn" data-dismiss="modal">Si</button>
            </div>
        </div>
    </div>
</div>

<%@include file="../dashboard/template/body-donw.jsp" %>

<%@include file="../WEB-INF/template/footer.jsp" %>

<script>
    $(document).ready(function () {

        let listarTipoAct = () => {
            $.ajax({
                url: $('body').attr('data-url') + "/TipoActividadController",
                data: {
                    'action': 'listarTipoAct'
                },
                type: "POST",
                success: function (response) {
                    response.listaTipoAct.forEach(function (obj) {
                        let row = '<tr><td>' + obj.tipo_id + '</td><td>' + obj.nombre_tipo + '</td>';
                        row += '<td>' + obj.estado + '</td>';
                        row += '<td><button class="btn btn-danger" id="eliminar-' + obj.tipo_id + '">Eliminar</button> ';
                        row += '<button class="btn btn-warning" id="actualizar-' + obj.tipo_id + '">Actualizar</button></td>';
                        $('#dtTipoAct > tbody').append(row);
                        eliminar(obj);
                        actualizar(obj);
                    });
                    $('#dtTipoAct').DataTable();
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        }

        let eliminar = (obj) => {
            $('#eliminar-' + obj.tipo_id).click((e) => {
                e.preventDefault();
                $('#eliminacionTipoActInput').val(obj.tipo_id)
                $('#eliminarTipoActModal').modal()
                $('#eliminarTipoActBtn').click((e) => {
                    e.preventDefault();
                    $.ajax({
                        url: $('body').attr('data-url') + "/TipoActividadController",
                        data: {
                            'action': 'eliminar',
                            'materiaEliminar': $('#eliminacionTipoActInput').val()
                        },
                        type: 'POST',
                        success: function (response) {
                            alert(response.mensaje);
                            $('#dtTipoAct > tbody').remove();
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
            $('#actualizar-' + obj.tipo_id).click((e) => {
                console.log(obj)
                e.preventDefault();
                $("#nombreTipoAct").val(obj.nombre_tipo);
                $("#estadoTA").val(obj.estado);
                $("#idTipoAct").val(obj.tipo_id);
                $("#action").val("actualizar");
                $("#tipoActM").modal()
            });
        }

        $("#tipoActF").submit(function (e) {
            e.preventDefault();
            $.ajax({
                url: $('body').attr('data-url') + "/TipoActividadController",
                data: {
                    'action': $('#action').val(),
                    'nombreTipoAct': $('#nombreTipoAct').val(),
                    'estadoTA': $('#estadoTA').val(),
                    'idTipoAct': $('#idTipoAct').val()
                },
                type: "POST",
                success: function (response) {
                    console.log(response)
                    $('#mensajeTipoAct').text(response.mensaje);
                    alert(response.mensaje);
                    location.reload()
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        });

        $("#agregarTipoAct").click((e) => {
            e.preventDefault()

            $("#action").val("guardar");
            $("#tipoActM").modal()
        })

        $("#cerrarModalTipoAct").click((e) => {
            e.preventDefault()
            $("#nombreTipoAct").val("");
            $("#estadoTA").val("");
            $("#idTipoAct").val("");
            $("#action").val("");
            $("#tipoActM").modal('hide')
        });

        listarTipoAct();
    });
</script>