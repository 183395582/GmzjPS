<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!-- dropzone，图片上传 -->
<script src="<%=basePath %>static/plugins/dropzone.min.js"></script>
<link href="<%=basePath %>static/css/dropzone.css" rel="stylesheet" type="text/css" />

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
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
								<h4 class="modal-title" id="upModalLabel">文件上传(注意！图片不超过2M)</h4>
							</div>
							<div class="modal-body">
								<form action="/pic/addPic" class="dropzone" id="dropzone" enctype="multipart/form-data">
									<div class="fallback">
										<input name="files" type="file" multiple="multiple" />
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		jQuery(function($) {
			var url = '<%=basePath %>/pic/addPic?resType=' + $("#resType").val() +  '&resId=' + $("#resId").val();
			Dropzone.autoDiscover = false;
			try {
				var myDropzone = new Dropzone(
						"#dropzone",
						{
							url : url,
							paramName : "files",
							maxFilesize : 10,
							addRemoveLinks : true,
							dictDefaultMessage : '<span class="bigger-150 bolder"><i class="ace-icon fa fa-caret-right red"></i> 拖动文件</span>上传 \
												<span class="smaller-80 grey">(或点击)</span> <br /> \<i class="upload-icon ace-icon fa fa-cloud-upload blue fa-3x"></i>',
							dictResponseError : '文件上传错误!',
							dictRemoveFile : '',
							previewTemplate : "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-details\">\n    <div class=\"dz-filename\"><span data-dz-name></span></div>\n    <div class=\"dz-size\" data-dz-size></div>\n    <img data-dz-thumbnail />\n  </div>\n  <div class=\"progress progress-small progress-striped active\"><div class=\"progress-bar progress-bar-success\" data-dz-uploadprogress></div></div>\n  <div class=\"dz-success-mark\"><span></span></div>\n  <div class=\"dz-error-mark\"><span></span></div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage></span></div>\n</div>"
						});
			} catch (e) {
				alert('Dropzone.js does not support older browsers!');
			}
		});
	</script>
	<c:if test="${!empty succflag && succflag =='1'}">
		<script type="text/javascript">
	          $('.jump-step').removeClass('hide');
	          setTimeout('window.location="/home.htm"',5000);
	    </script>
	</c:if>
</body>
</html>
