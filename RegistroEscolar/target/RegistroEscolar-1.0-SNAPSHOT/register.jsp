<%      
    if (session != null && session.getAttribute("usuario") != null) {
        response.sendRedirect("dashboard/dashboard.jsp");
    }
%>
<%@include file="WEB-INF/template/header.jsp" %>
    <div class="bg-gradient-primary container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Crear cuenta!</h1>
                            </div>
                            <form class="user" method="post" action="${pageContext.request.contextPath}/LoginController">
                                <input type="hidden" value="create" name="action" id="action"/>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user" id="exampleFirstName"
                                               placeholder="First Name" name="nombres" id="nombres">
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-user" id="exampleLastName"
                                            placeholder="Last Name" name="apellidos" id="apellidos">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="email" class="form-control form-control-user" id="exampleInputEmail"
                                        placeholder="Email Address" name="correo" id="correo">
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="password" class="form-control form-control-user"
                                            id="exampleInputPassword" placeholder="Password" name="clave" id="clave">
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="password" class="form-control form-control-user"
                                            id="exampleRepeatPassword" placeholder="Repeat Password" name="claveR" id="claveR">
                                    </div>
                                </div>
                                <button class="btn btn-primary btn-user btn-block">
                                    Registrarme
                                </button>
                                <h5><%=request.getAttribute("message") == null ? "" : request.getAttribute("message")%></h5>
                            </form>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="login.jsp">Ya tiene cuenta? Inicia Sesion!</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>