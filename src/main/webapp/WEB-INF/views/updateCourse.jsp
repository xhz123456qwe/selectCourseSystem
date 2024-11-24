<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改课程信息</title>
    <link href="<c:url value="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/side.css"/> ">
    <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/addCourse.css"/> ">
</head>
<body>
<div class="container-fluid side" style="height: 500px;">
    <div class="act">
        修改课程
    </div>
    <form action="${pageContext.request.contextPath}/manager/courseInfo/update/${page}" method="post">
        <div class="acb">
            <input type="hidden" name="cid" value="${course.cId}">
            <div class="acb1">
                <label>课程编号</label>
                <input type="text" name="cnumber" value="${course.cNumber}" readonly>
            </div>
            <div class="acb1">
                <label>课程名称</label>
                <input type="text" name="cname" value="${course.cName}">
            </div>
            <div class="acb1">
                <label>授课教师</label>
                <input type="text" name="teacher" value="${course.teacher}">
            </div>
            <div class="acb1">
                <label>课程学分</label>
                <input type="text" name="credit" value="${course.credit}"><br>
            </div>
            <div class="acb1">
                <label>开设学院</label>
                <input type="text" name="department" value="${course.department}"><br>
            </div>
            <div class="acb1">
                <label>开设地点</label>
                <input type="text" name="location" value="${course.location}"><br>
            </div>
        </div>
        <div class="acb" style="margin-left: 30px;margin-right: 30px;">
            <div class="acb1">
                <label>最大学生容量</label>
                <input type="text" name="maxNumber" value="${course.maxNumber}">
            </div>
            <div class="acb1" style="margin-top: 40px">
                <label>描述</label>
                <textarea name="description" rows="12" cols="31">${course.description}</textarea>
            </div>
        </div>
        <div class="acb">
            <fieldset>
                <legend>开设时间</legend>
                <div>
                    <label>开设日期</label><br/>
                    <input type="text" name="cYear1" value="${(course.cStart.split('年'))[0]}"
                           style="width: 40px;margin-right: 10px">年
                    <c:set var="split1" value="${(course.cStart.split('年'))[1]}"/>
                    <input type="text" name="cMonth1" value="${(split1.split('月'))[0]}"
                           style="width: 40px;margin-right: 10px">月
                    <c:set var="split2" value="${(split1.split('月'))[1]}"/>
                    <input type="text" name="cDay1" value="${(split2.split('日'))[0]}"
                           style="width: 40px;margin-right: 10px">日-
                    <div style="width: 100%;height: 10px;"></div>
                    <input type="text" name="cYear2" value="${(course.cEnd.split('年'))[0]}"
                           style="width: 40px;margin-right: 10px">年
                    <c:set var="split3" value="${(course.cEnd.split('年'))[1]}"/>
                    <input type="text" name="cMonth2" value="${(split3.split('月'))[0]}"
                           style="width: 40px;margin-right: 10px">月
                    <c:set var="split4" value="${(split3.split('月'))[1]}"/>
                    <input type="text" name="cDay2" value="${(split4.split('日'))[0]}"
                           style="width: 40px;margin-right: 10px">日
                </div>
                <div style="margin-top: 10px">
                    <label style="float:left;width: 100%;">开设星期</label>
                    <div class="ch2">
                        <input type="checkbox" id="day1" name="day" value="星期日" checked>
                        <label for="day1">星期日</label>
                    </div>
                    <div class="ch2">
                        <input type="checkbox" id="day2" name="day" value="星期一">
                        <label for="day2">星期一</label>
                    </div>
                    <div class="ch2">
                        <input type="checkbox" id="day3" name="day" value="星期二">
                        <label for="day3">星期二</label>
                    </div>
                    <div class="ch2">
                        <input type="checkbox" id="day4" name="day" value="星期三">
                        <label for="day4">星期三</label>
                    </div>
                    <div class="ch2">
                        <input type="checkbox" id="day5" name="day" value="星期四">
                        <label for="day5">星期四</label>
                    </div>
                    <div class="ch2">
                        <input type="checkbox" id="day6" name="day" value="星期五">
                        <label for="day6">星期五</label>
                    </div>
                    <div class="ch2">
                        <input type="checkbox" id="day7" name="day" value="星期六">
                        <label for="day7">星期六</label>
                    </div>
                </div>
                <div style="width: 100%;float:left;">
                    <label style="float:left;width: 100%;">开设的具体时间</label>
                    <div style="width: 50%;float:left;">
                        <input type="radio" id="time1" name="time" value="8:30-10:10" checked>
                        <label for="time1">8:30-10:10</label>
                    </div>
                    <div style="width: 50%;float:left;">
                        <input type="radio" id="time2" name="time" value="10:30-12:10">
                        <label for="time2">10:30-12:10</label>
                    </div>
                    <div style="width: 50%;float:left;">
                        <input type="radio" id="time3" name="time" value="2:00-3:40">
                        <label for="time3">2:00-3:40</label>
                    </div>
                    <div style="width: 50%;float:left;">
                        <input type="radio" id="time4" name="time" value="4:00-5:40">
                        <label for="time4">4:00-5:40</label>
                    </div>
                    <div style="width: 50%;float:left;">
                        <input type="radio" id="time5" name="time" value="7:00-8:40">
                        <label for="time5">7:00-8:40</label>
                    </div>
                    <div style="width: 50%;float:left;">
                        <input type="radio" id="time6" name="time" value="7:00-9:25">
                        <label for="time6">7:00-9:25</label>
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="acb3">
            <input type="submit" value="提交" style="border: 0;background-color:#2b669a;padding: 0 20px;margin-left: 310px">
            <a href="<c:url value="/manager/courseInfo/1"/>" rel="" class="a4">返回</a>
        </div>
    </form>
</div>
</body>
</html>
