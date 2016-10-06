<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="utf-8" />
<title>后台管理系统</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<jsp:include page="../comm/script.jsp" flush="true" />
<jsp:include page="../comm/css.jsp" flush="true" />
<script src="<%=basePath %>static/plugins/handlebars.js"></script>
<script src="<%=basePath %>static/plugins/jquery.gridly.js"></script>

<link href="<%=basePath %>static/css/jquery.gridly.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>static/css/ace.min.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>static/css/jquery.gridly.sample.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="main-container" id="main-container">
		<script type="text/javascript">
			try {
				ace.settings.check('main-container', 'fixed')
			} catch (e) {
			}
		</script>

		<div class="main-container-inner">
			<div class="main-content">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<div class="row">
								<div class="col-xs-6">
									<h3><span id="resName">${resName}</span></h3>
									<input id="resId" type="hidden" value="${resId}">
									<input id="resType" type="hidden" value="${resType}">
								</div>
							</div>
							<div class="row">
								<div id = "message" class="col-xs-8 alert alert-warning"></div>
								<div class="col-xs-1">
									<button id="upfileBtn" class="btn btn-purple">上传图片</button>
								</div>
							</div>
							
							<div class="row">
								<div class="col-xs-12" id="image-panel">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" id="upfileModal" tabindex="-1" role="dialog"
				aria-labelledby="upfileModalLabel" aria-hidden="false">
				<div class="modal-dialog" style="width: 75%;height:100px">
					<div class="modal-content">
						
					</div>
				</div>
			</div>
		</div>
		
	</div>
	<c:if test="${!empty succflag && succflag =='1'}">
		<script type="text/javascript">
			$('.jump-step').removeClass('hide');
			setTimeout('window.location="/home.htm"', 5000);
		</script>
	</c:if>
	<script type="text/x-handlebars-template" id="imgTpt">
		{{#each this}}
			<div class="imgblock" id="img_wrapper_{{id}}" data-id="{{id}}" data-seq="{{seq}}" data-srcFile="{{imgUrl}}">
				<a class="imgdelete" id="img_a_{{id}}" onclick="deleteImg('img_a_{{id}}', '<%=basePath%>')">×</a>
				<img src="http://localhost/{{imgUrl}}">
			</div>
		{{/each}}
	</script>
	<script src="<%=basePath %>static/js/pic/pic.js"></script>
	<script>
		function findpics(){
			var json={};
			json["resNo"]=$("#resNo").val();
			json["resType"]=$("#resType").val();
			$.ajax({
			     type: 'POST',
			     url: '<%=basePath%>pic/findPic.htm' ,
			     data: json,
			     success: function(data){
							if(data.result == "ok") {
								$("#message").text("查询记录成功");
								showpics(data.data);
								return true;
							}
							else {
								$("#message").text("查询记录失败:" + data.message );
								return false;
							}
							return false;
						} ,
			    dataType: 'json',
			});
		}
		
		function updateSeqs(param){
			var url="<%=basePath%>pic/updateSeqs";
			$.ajax({
			    type: 'POST',
			    url:url,
			    data:param,
			    success: function(data){
						if(data.result == "ok"){
						}
						else {
							$("#message").text("修改图片显示顺序失败:" + json.message );
							return false;
						}
						return false;
					} ,
			    dataType: 'json',
			});
		}
		//文件上传
		$("#upfileBtn").on("click", function() {
			$("#upfileModal").modal({
			    remote: "<%=basePath%>pic/addPage"
			});
		});
	</script>
</body>
</html>
