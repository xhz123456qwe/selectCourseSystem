<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="ct" uri="/WEB-INF/tld/courseTable.tld" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <html>

            <head>
                <title>stu Course Table</title>
                <link href="<c:url value=" /static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
                <link rel="stylesheet" type="text/css" href="<c:url value=" /static/css/head.css" />">
                <link rel="stylesheet" type="text/css" href="<c:url value=" /static/css/footer.css" />">
                <link rel="stylesheet" type="text/css" href="<c:url value=" /static/css/stuCourseTable.css" />">
            </head>

            <body>
                <c:set var="time"
                    value="${['8:30-10:10','10:30-12:10','14:00-15:40','16:00-17:40','19:00-20:40','19:00-21:25']}" />
                <c:set var="day" value="${['星期一','星期二','星期三','星期四','星期五','星期六','星期日']}" />
                <c:set var="stu" scope="session" value="${sessionScope.student}" />
                <header class="top">
                    <div class="w">
                        <div class="logo">
                            <img src="<c:url value=" /static/imgs/logo.png" />" alt="logo">
                        </div>
                        <div class="name">
                            校园选课系统
                        </div>
                        <div class="navitems">
                            <div class="navitems_in">
                                <ul>
                                    <li>
                                        <a href="<c:url value=" /student/mainPage" />">首页</a>
                                    </li>
                                    <li><a href="<c:url value=" /student/selectCourse" />">选择课程</a></li>
                                    <li><a href="<c:url value=" /student/showCourse" />">已选课程</a></li>
                                    <li><a href="<c:url value=" /student/stuCourseTable" />" class="choose">课程表</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="welcome">
                            欢迎登陆,
                            <c:out value="${stu.sName}" />
                        </div>
                        <div class="back">
                            <div class="backPic">
                                <img src="<c:url value=" /static/imgs/back.png" />" alt="back"/>
                            </div>
                            <a href="<c:url value=" /student/back" />" class="backWords">退出</a>
                        </div>
                    </div>
                </header>
                <br><br><br><br><br><br>
                <div class="w" style="height: 1200px">
                    <div class="cTable">
                        <div class="titleT" style="background-color: white;font-size: 36px;font-style: italic">
                            课程表
                        </div>
                        <div class="cTab">
                            <table>
                                <thead>
                                    <tr>
                                        <th style="width: 31px"></th>
                                        <th>星期一</th>
                                        <th>星期二</th>
                                        <th>星期三</th>
                                        <th>星期四</th>
                                        <th>星期五</th>
                                        <th>星期六</th>
                                        <th>星期日</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th style="width: 31px">1</th>
                                        <ct:stuCourseTable courseChosen="${courseChosen}" time="${time[0]}" />
                                    </tr>
                                    <tr>
                                        <th style="width: 31px">2</th>
                                        <ct:stuCourseTable courseChosen="${courseChosen}" time="${time[1]}" />
                                    </tr>
                                    <tr>
                                        <th style="width: 31px">午</th>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th style="width: 31px">3</th>
                                        <ct:stuCourseTable courseChosen="${courseChosen}" time="${time[2]}" />
                                    </tr>
                                    <tr>
                                        <th style="width: 31px">4</th>
                                        <ct:stuCourseTable courseChosen="${courseChosen}" time="${time[3]}" />
                                    </tr>
                                    <tr>
                                        <th style="width: 31px">晚</th>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th style="width: 31px">6</th>
                                        <ct:stuCourseTable courseChosen="${courseChosen}" time="${time[4]}" />
                                    </tr>
                                    <tr>
                                        <th style="width: 31px">7</th>
                                        <ct:stuCourseTable courseChosen="${courseChosen}" time="${time[5]}" />
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div><br />
                <div class="foot">
                    <div class="w">
                        <div class="pic2">
                            <div class="pic3">FOLLOW</div>
                            <div class="pic4">
                                <div class="pic5">
                                    <img src="<c:url value=" /static/imgs/github.png" />" alt="github"/>
                                </div>
                                <div class="pic5">
                                    <img src="<c:url value=" /static/imgs/wechat.png" />" alt="wechat"/>
                                </div>
                                <div class="pic5">
                                    <img src="<c:url value=" /static/imgs/qq.png" />" alt="qq"/>
                                </div>
                                <div class="pic5">
                                    <img src="<c:url value=" /static/imgs/x.png" />" alt="x"/>
                                </div>
                            </div>
                        </div>
                        <div class="tel">
                            <div class="tel1">SUPPORT</div>
                            <div class="tel1">PRIVACY</div>
                            <div class="tel1">TEAMS</div>
                            <div class="tel1">REVIEWS</div>
                            <div class="tel1">STOCKISTS</div>
                            <div class="footer_info">
                                <div class="footer_Info1">
                                    信息化管理处（信息中心）用户服务电话：029-88491717
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门户技术服务：029-88493092
                                </div>
                                <div class="footer_Info1">
                                    友谊校区地址：西安市友谊西路127号 邮编：710072 长安校区地址：西安市长安区东祥路1号
                                </div>
                                <div class="footer_Info1">
                                    版权所有 © 西北工业大学 ICP备案号：陕ICP备05010979
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </body>

            </html>