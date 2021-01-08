<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme()+ "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">
<link href="js/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="js/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
	<script>
		$(function () {
			if(window.top!=window){
				Window.top.location = window.location;
			}
            $("#loginAct").val("");
			//页面加载完毕后，用户文本框自动获取焦点
			$("#loginAct").focus();
			//
			$("#submitbBtn").click(function () {
                login();
            })
            $(window).keydown(function (event) {

			    if(event.keyCode == 13){
					login();
				}
            })
        })
		function login() {
			//验证账号秘密不能为空,将文本中左右空格去掉
			var loginAct = $.trim($("#loginAct").val());
			var loginPwd = $.trim($("#loginPwd").val());
			if(loginAct == "" ||  loginPwd == ""){
			    $("#msg").html("账号密码不能为空");

			    return false;
			}
			// 去后台发送请求 ajax
			$.ajax({
				url:"user/login",
				data:{
				    "loginAct":loginAct,
				    "loginPwd":loginPwd,
				},
				type:"post",
				dataType:"json",
				success:function (data) {

				    if (data.state == 1){
						window.location.href="workbench/index.jsp";
					}else{
				        $("#msg").html(data.message)
					}
                }
			})
        }
	</script>
</head>
<body>
	<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
		<img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
	</div>
	
	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1>登录</h1>
			</div>
			<form action="WEB-INF/jsp/workbench/index.jsp" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input class="form-control" type="text" placeholder="用户名" id="loginAct">
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<input class="form-control" type="password" placeholder="密码" id="loginPwd">
					</div>
					<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
						
							<span id="msg" style="color: red"></span>
						
					</div>
					<%--
					 	按钮卸载form表单中，默认就是提交表单
					 	一定将按钮的类型设置为button
					 --%>
					<button type="button" id="submitbBtn" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;">登录</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>