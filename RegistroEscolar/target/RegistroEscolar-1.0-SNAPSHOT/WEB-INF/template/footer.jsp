<!-- Footer -->
<footer class="sticky-footer bg-white">
    <div class="container my-auto">
        <div class="copyright text-center my-auto">
            <span>Copyright &copy; Escolar 2023</span>
        </div>
    </div>
</footer>
<!-- End of Footer -->

</div>
<!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>


<!-- Bootstrap core JavaScript-->
<script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="${pageContext.request.contextPath}/assets/js/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${pageContext.request.contextPath}/assets/js/sb-admin-2.min.js"></script>

<script src="${pageContext.request.contextPath}/assets/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/dataTables.bootstrap4.min.js"></script>

<script>
    $(document).ready(() => {
        $.ajax({
            url: $('body').attr('data-url') + "/UsuariosController",
            data: {
                'action': 'menu'
            },
            type: 'POST',
            success: (response) => {
                response.listaMenu.forEach((menu) => {
                    let li = '<a class="nav-link collapsed" href="' + menu.url_relativo + '"';
                    li += 'aria-expanded="true" aria-controls="collapseTwo">';
                    li += '<i class="' + menu.icono_menu + '"></i>';
                    li += '<span>' + menu.nombre_opcion + '</span>';
                    li += '</a>';
                    $('#menu-usuario').append(li);
                });
                console.log(response.listaMenu)
            },
            error: (xhr, status, error) => {
                alert("Error: " + error)
            }
        });
    });
</script>
</body>

</html>