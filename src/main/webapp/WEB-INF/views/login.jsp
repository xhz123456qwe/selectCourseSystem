<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <html>

        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Login</title>
            <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
            <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/login.css" /> ">
        </head>

        <body>
            <div class="container-fluid login">
                <div class="login_right">
                    <div class="top">校园选课系统</div>
                    <div class="bottom"><img src="static/imgs/img2.png" class="bottom" /></div>
                </div>
                <div class="login_left">
                    <div class="lTop">欢迎登陆</div>
                    <div id="choose">
                        <div id="choose1"><a href="#" class="active" data-id="0" style="text-decoration:none">学生登录</a>
                        </div>
                        <div id="choose2"><a href="#" data-id="1" style="text-decoration: none">管理员登录</a></div>
                    </div>
                    <div class="show">
                        <div class="tab">
                            <form action="${pageContext.request.contextPath}/student" method="post">
                                <label class="fontstyle">学&emsp;号</label>
                                <input type="text" name="username" style="width: 235px"
                                    value="${cookie.stuName.value}" /><br><br>
                                <label class="fontstyle">密&emsp;码</label>
                                <input type="password" name="password" style="width: 235px"
                                    value="${cookie.stuPassword.value}" /><br><br>
                                <div class="check">
                                    <input type="checkbox" name="remember" checked><label
                                        class="rem">记住学号与密码</label><br>
                                </div>
                                <input type="submit" value="登录" class="sub">
                            </form>
                        </div>
                        <div class="tab" style="display: none;">
                            <form action="${pageContext.request.contextPath}/manager" method="post">
                                <label class="fontstyle">用户名</label>
                                <input type="text" name="username" style="width: 235px"
                                    value="${cookie.username.value}" /><br><br>
                                <label class="fontstyle">密&emsp;码</label>
                                <input type="password" name="password" style="width: 235px"
                                    value="${cookie.password.value}" /><br><br>
                                <div class="check">
                                    <input type="checkbox" name="remember" checked><label
                                        class="rem">记住用户名与密码</label><br>
                                </div>
                                <input type="submit" value="登录" class="sub">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <script src="static/jquery/jquery-3.4.1.js"></script>
            <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
            <script src="static/js/login.js"></script>
        </body>

        </html>