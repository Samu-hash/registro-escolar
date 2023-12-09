<%@include file="../WEB-INF/template/header.jsp" %>    

<%@include file="../dashboard/template/menu.jsp" %>    

<%@include file="../dashboard/template/body-up.jsp" %>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
    <h1 class="h3 mb-0 text-gray-800">Materia por Ciclo</h1>
</div>

<!-- Content Row -->

<div class="row">
    <div class="col-xl-12 col-lg-12">
        <div class="card shadow mb-4">
            <!-- Card Header - Dropdown -->
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold text-primary">Gestion de materias por ciclo</h6>

            </div>
            <!-- Card Body -->
            <div class="card-body">
                <div class="table-responsive">
                    <button class="btn btn-success" id="agregarMateriaCiclo">Agregar una materia de ciclo</button>
                    <br/>
                    <br/><hr/>
                    <table class="table table-bordered" id="dtMateriaCiclo" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Materia</th>
                                <th>Ciclo</th>
                                <th>Periodo Ini</th>
                                <th>Periodo Fin</th>
                                <th>Estado</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>ID</th>
                                <th>Materia</th>
                                <th>Ciclo</th>
                                <th>Periodo Ini</th>
                                <th>Periodo Fin</th>
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

<div class="modal fade" id="MateriaCicloM" tabindex="-1" data-backdrop="static" 
     data-keyboard="false" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" >Materias en Ciclo</h5>
            </div>
            <form id="MateriaCicloF" name="MateriaCicloF" class="user">
                <div class="modal-body">
                    <div class="form-group">
                        <select class="form-control form-control-user" name="idMateriaS" id="idMateriaS" >
                            <option value="">--Seleccione una materia--</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control form-control-user" name="idCicloS" id="idCicloS" >
                            <option value="">--Seleccione un ciclo--</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <input type="date" class="form-control form-control-user" id="peIni" name="peIni" />
                    </div>
                    <div class="form-group">
                        <input type="date" class="form-control form-control-user" id="peFin" name="peFin" />
                    </div>
                    <div class="form-group">
                        <select class="form-control form-control-user"  id="estadoS" name="estadoS">
                            <option value="">--Seleccione un estado--</option>
                            <option value="ACTIVO">ACTIVO</option>
                            <option value="PENDIENTE">PENDIENTE</option>
                        </select> 
                    </div>
                    <hr/>
                    <h5 id="mensajeMateriaCiclo"></h5>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="action" id="action"/>
                    <input type="hidden" name="idMateriaCiclo" id="idMateriaCiclo"/>
                    <button class="btn btn-secondary" type="button" id="cerrarModalMateriaCiclo">No</button>
                    <button class="btn btn-primary" type="submit" id="guardar">Si</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="eliminarMateriaCicloModal" tabindex="-1" role="dialog"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Eliminar Materias en Ciclo </h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="eliminacionMateriaCicloInput"/>
                Desea eliminar la materia de ciclo?</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">No</button>
                <button class="btn btn-primary" type="button" id="eliminarMateriaCicloBtn" data-dismiss="modal">Si</button>
            </div>
        </div>
    </div>
</div>

<%@include file="../dashboard/template/body-donw.jsp" %>

<%@include file="../WEB-INF/template/footer.jsp" %>

<script>
    $(document).ready(function () {

        let listarMateriasCiclos = () => {
            $.ajax({
                url: $('body').attr('data-url') + "/MateriasCiclosController",
                data: {
                    'action': 'listar'
                },
                type: "POST",
                success: function (response) {
                    response.lista.forEach(function (obj) {
                        let row = '<tr><td>' + obj.materia_en_ciclo_id + '</td><td>' + obj.materia.nombre_materia + '</td>';
                        row += '<td>' + obj.ciclo.nombre_ciclo + ' - ' + obj.ciclo.anio_academico + '</td>';
                        row += '<td>' + obj.periodo_ini + '</td>'
                        row += '<td>' + obj.periodo_end + '</td>'
                        row += '<td>' + obj.estado + '</td>'
                        row += '<td><button class="btn btn-danger" id="eliminar-' + obj.materia_en_ciclo_id + '">Eliminar</button> ';
                        row += '<button class="btn btn-warning" id="actualizar-' + obj.materia_en_ciclo_id + '">Actualizar</button></td>';
                        $('#dtMateriaCiclo > tbody').append(row);
                        eliminar(obj);
                        actualizar(obj);
                    });
                    $('#dtMateriaCiclo').DataTable();
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
                        let option = '<option value="' + obj.materia_id + '">' + obj.nombre_materia + ' - ' + obj.docente.nombre + '</option>';
                        $("#idMateriaS").append(option)
                    });
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        }

        let listarCiclos = () => {
            $.ajax({
                url: $('body').attr('data-url') + "/CiclosController",
                data: {
                    'action': 'listarCiclos'
                },
                type: "POST",
                success: function (response) {
                    response.listaCiclos.forEach(function (obj) {
                        let option = '<option value="' + obj.ciclo_id + '">' + obj.nombre_ciclo + ' - ' + obj.anio_academico + '</option>';
                        $("#idCicloS").append(option)
                    });
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        }

        let eliminar = (obj) => {
            $('#eliminar-' + obj.materia_en_ciclo_id).click((e) => {
                e.preventDefault();
                $('#eliminacionMateriaCicloInput').val(obj.materia_en_ciclo_id)
                $('#eliminarMateriaCicloModal').modal()
                $('#eliminarMateriaCicloBtn').click((e) => {
                    e.preventDefault();
                    $.ajax({
                        url: $('body').attr('data-url') + "/MateriasCiclosController",
                        data: {
                            'action': 'eliminar',
                            'materiaCicloEliminar': $('#eliminacionMateriaCicloInput').val()
                        },
                        type: 'POST',
                        success: function (response) {
                            alert(response.mensaje);
                            $('#dtMateriaCiclo > tbody').remove();
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
            $('#actualizar-' + obj.materia_en_ciclo_id).click((e) => {
                e.preventDefault();
                $("#idMateriaS").val(obj.materia_id);
                $("#idCicloS").val(obj.ciclo_id);
                $("#peIni").val(obj.periodo_ini);
                $("#peFin").val(obj.periodo_end);
                $("#estadoS").val(obj.estado);
                $("#idMateriaCiclo").val(obj.materia_en_ciclo_id);
                $("#action").val("actualizar");
                $("#MateriaCicloM").modal()
            });
        }

        $("#MateriaCicloF").submit(function (e) {
            e.preventDefault();
            $.ajax({
                url: $('body').attr('data-url') + "/MateriasCiclosController",
                data: {
                    'action': $('#action').val(),
                    'idMateriaS': $('#idMateriaS').val(),
                    'idCicloS': $('#idCicloS').val(),
                    'peIni': $('#peIni').val(),
                    'peFin': $('#peFin').val(),
                    'estadoS': $('#estadoS').val(),
                    'idMateriaCiclo': $('#idMateriaCiclo').val()
                },
                type: "POST",
                success: function (response) {
                    console.log(response.isError === 1)
                    $('#mensajeMateriaCiclo').text(response.mensaje);

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

        $("#agregarMateriaCiclo").click((e) => {
            e.preventDefault()
            $("#action").val("guardar");
            $("#MateriaCicloM").modal()
        })

        $("#cerrarModalMateriaCiclo").click((e) => {
            e.preventDefault()
            $("#idMateriaS").val("");
            $("#idCicloS").val("");
            $("#peIni").val("");
            $("#peFin").val("");
            $("#estadoS").val("");
            $("#idMateriaCiclo").val("");
            $("#action").val("");
            $("#MateriaCicloM").modal('hide')
        });

        listarMateriasCiclos();
        listarMaterias();
        listarCiclos();
    });
</script>