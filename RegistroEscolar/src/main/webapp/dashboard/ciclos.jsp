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
                <h6 class="m-0 font-weight-bold text-primary">Gestion de ciclos</h6>

            </div>
            <!-- Card Body -->
            <div class="card-body">
                <div class="table-responsive">
                    <button class="btn btn-success" id="agregarCiclo">Agregar un Ciclo</button>
                    <br/>
                    <br/><hr/>
                    <table class="table table-bordered" id="dtCiclo" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombres Ciclo</th>
                                <th>Año de Ciclo</th>
                                <th>Estado</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>ID</th>
                                <th>Nombres Ciclo</th>
                                <th>Año de Ciclo</th>
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

<div class="modal fade" id="ciclo" tabindex="-1" data-backdrop="static" 
     data-keyboard="false" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" >Ciclos</h5>
            </div>
            <form id="cicloF" name="cicloF" class="user">
                <div class="modal-body">
                    <div class="form-group">
                        <input class="form-control form-control-user" type="text" name="nombreCiclo" id="nombreCiclo" 
                               placeholder="Ingrese un nombre de ciclo"/>
                    </div>
                    <div class="form-group">
                        <input class="form-control form-control-user" type="text" name="anioAcademico" id="anioAcademico" 
                               placeholder="Ingrese un año de ciclo"/>
                    </div>
                    <div class="form-group">
                        <select class="form-control form-control-user"  id="estadoC" name="estadoC">
                            <option value="">--Seleccione un estado del usuario--</option>
                            <option value="ACTIVO">ACTIVO</option>
                        </select> 
                    </div>
                    <hr/>
                    <h5 id="mensajeCiclo"></h5>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="action" id="action"/>
                    <input type="hidden" name="idCiclo" id="idCiclo"/>
                    <button class="btn btn-secondary" type="button" id="cerrarModalCiclo">No</button>
                    <button class="btn btn-primary" type="submit" id="guardar">Si</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="eliminarCicloModal" tabindex="-1" role="dialog"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Eliminar Ciclo </h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="eliminacionCicloInput"/>
                Desea eliminar el ciclo?</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">No</button>
                <button class="btn btn-primary" type="button" id="eliminarCicloBtn" data-dismiss="modal">Si</button>
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
                url: $('body').attr('data-url') + "/CiclosController",
                data: {
                    'action': 'listarCiclos'
                },
                type: "POST",
                success: function (response) {
                    response.listaCiclos.forEach(function (obj) {
                        let row = '<tr><td>' + obj.ciclo_id + '</td><td>' + obj.nombre_ciclo + '</td>';
                        row += '<td>' + obj.anio_academico + '</td><td>' + obj.estado + '</td>';
                        row += '<td><button class="btn btn-danger" id="eliminar-' + obj.ciclo_id + '">Eliminar</button> ';
                        row += '<button class="btn btn-warning" id="actualizar-' + obj.ciclo_id + '">Actualizar</button></td>';
                        $('#dtCiclo > tbody').append(row);
                        eliminar(obj);
                        actualizar(obj);
                    });
                    $('#dtCiclo').DataTable();
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        }

        let eliminar = (obj) => {
            $('#eliminar-' + obj.ciclo_id).click((e) => {
                e.preventDefault();
                $('#eliminacionCicloInput').val(obj.ciclo_id)
                $('#eliminarCicloModal').modal()
                $('#eliminarCicloBtn').click((e) => {
                    e.preventDefault();
                    $.ajax({
                        url: $('body').attr('data-url') + "/CiclosController",
                        data: {
                            'action': 'eliminar',
                            'cicloEliminar': $('#eliminacionCicloInput').val()
                        },
                        type: 'POST',
                        success: function (response) {
                            alert(response.mensaje);
                            $('#dtCiclo > tbody').remove();
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
            $('#actualizar-' + obj.ciclo_id).click((e) => {
                e.preventDefault();
                $("#nombreCiclo").val(obj.nombre_ciclo);
                $("#anioAcademico").val(obj.anio_academico);
                $("#estadoC").val(obj.estado);
                $("#idCiclo").val(obj.ciclo_id);
                $("#action").val("actualizar");
                $("#ciclo").modal()
            });
        }

        $("#cicloF").submit(function (e) {
            e.preventDefault();
            $.ajax({
                url: $('body').attr('data-url') + "/CiclosController",
                data: {
                    'action': $('#action').val(),
                    'nombreCiclo': $('#nombreCiclo').val(),
                    'anioAcademico': $('#anioAcademico').val(),
                    'estadoC': $('#estadoC').val(),
                    'idCiclo': $('#idCiclo').val()
                },
                type: "POST",
                success: function (response) {
                    $('#mensajeCiclo').text(response.mensaje);
                    alert(response.mensaje);
                    location.reload()
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        });

        $("#agregarCiclo").click((e) => {
            e.preventDefault()

            $("#action").val("guardar");
            $("#ciclo").modal()
        })

        $("#cerrarModalCiclo").click((e) => {
            e.preventDefault()
            $("#nombreCiclo").val("");
            $("#anioAcademico").val("");
            $("#estadoC").val("");
            $("#idCiclo").val("");
            $("#ciclo").modal('hide')
        })

        listarCiclo();
    });
</script>