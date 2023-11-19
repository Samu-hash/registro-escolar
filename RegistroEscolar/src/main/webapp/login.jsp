<%      
    if (session != null && session.getAttribute("usuario") != null) {
        response.sendRedirect("dashboard/dashboard.jsp");
    }
%>
<%@include file="WEB-INF/template/header.jsp" %>
<div class="bg-gradient-primary container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

        <div class="col-xl-10 col-lg-12 col-md-9">

            <div class="card o-hidden border-0 shadow-lg my-5">
                <div class="card-body p-0">
                    <!-- Nested Row within Card Body -->
                    <div class="row">
                        <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                        <div class="col-lg-6">
                            <div class="p-5">
                                <div class="text-center">
                                    <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                                </div>
                                <form class="user" method="post" action="${pageContext.request.contextPath}/LoginController">
                                    <input type="hidden" value="login" name="action" id="action"/>
                                    <div class="form-group">
                                        <input type="email" class="form-control form-control-user"
                                               id="email" name="email" 
                                               placeholder="Ingrese un correo electronico...">
                                    </div>
                                    <div class="form-group">
                                        <input type="password" class="form-control form-control-user"
                                               id="password" name="password" placeholder="Contraseña">
                                    </div>
                                    <button type="submit" class="btn btn-primary btn-user btn-block">
                                        Iniciar Sesion
                                    </button>
                                    <hr>
                                    <h5><%=request.getAttribute("message") == null ? "" : request.getAttribute("message")%></h5>
                                </form>
                                <hr>
                                <div class="text-center">
                                    <a class="small" href="register.jsp">Crear cuenta!</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>

</div>
