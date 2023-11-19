</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->


<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a


<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Lista para cerrar sesion</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Desea cerrar sesion?</div>
            <div class="modal-footer">
                <form method="post" action="${pageContext.request.contextPath}/DashboardController">
                    <input type="hidden" value="cerrar" name="action" id="action"/>
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">No</button>
                    <button class="btn btn-primary" type="submit">Si</button>
                </form>
            </div>
        </div>
    </div>
</div>