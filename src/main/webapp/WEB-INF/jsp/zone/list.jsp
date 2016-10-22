<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="gmfn" uri="http://www.gmzj.co/tags/functions"%>
<jsp:include page="../comm/script.jsp" flush="true" />
<jsp:include page="../comm/css.jsp" flush="true" />
<%@ include file="../comm/taglib.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<c:url value='/static/js/app.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/jquery.toolbarlite.js?ver=10'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/jquery.tableManaged.js'/>"></script>
</head>
<body>
	<div class="row">
		<div class="col-md-12">
			<!-- BOX -->
			<div class="box border">
				<div class="box-body">
					<div class="box-body big">
					
						<form:form modelAttribute="searchModel" class="form-horizontal" method="GET">
						 
							<div class="row">
								<div class="col-md-3 col-sm-3">
									<label style="float:left;" for="cusName">园区管理：</label>
									<form:input path="name" name="name" class="form-control placeholder-no-fix" autocomplete="off" placeholder="园区名称" />
									<input type="hidden" name="currentPage" id="currentPage" value="${page.currentPage}" />
								</div>
							</div>
							<div class="row" style="float: right;">
								<button type="submit" class="btn btn-sm btn-success">查询</button>
							</div>
						</form:form> 
						<br>
						<hr>
						<div class="table-toolbar"></div>
						<table class="table table-striped table-bordered table-hover" style="width: 100%">
							<thead>
								<tr>
									<th>园区名称</th>
									<th>园区描述</th>
									
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${contentModel}" var="item">
									<tr class="success">
										<td>${item.name }</td>
										<td>${item.description }</td>
										
										<td>
											<a href="<%=basePath%>zone/${item.id }/update" ><li class="fa fa-edit"></li>编辑</a>&nbsp;&nbsp;
											<a herf="#" onClick="javascript:confirm('确认要删除该内容?'); location='<%=basePath%>zone/delete?id=${item.id }'"><li class="fa fa-trash-o"></li>删除</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="pagination" style="float: right;margin-top: -25px;">
							<ul class="pagination">
								${page.pageStr}
							</ul>
						</div>
					</div>
				<!-- /BOX -->
				</div>
			</div>
		</div>
		<!-- 模态框（图片） -->
		<div class="modal fade" id="picModal" tabindex="-1" role="dialog" aria-labelledby="picModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width: auto; height: auto">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="picModalLabel">图片管理</h4>
					</div>
					<div class="modal-body">
						<iframe id="picIframe" width="100%" height="500px" frameborder="0" scrolling="yes"></iframe>

					</div>

					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->
		</div>

	<script type="text/javascript">
   	  $(function() {   
         $("#data-table").tableManaged();
         $(".table-toolbar").toolbarLite({
             items: [
                 { link: true, display: "新增", css: "fa fa-plus", showIcon: true, url: "<%=basePath%>zone/add"}
             ]
         });
         $(".toolbar").addClass("col-md-4");
         $(".toolbar").css("padding", "0px");
         $(".tool_box").addClass("col-md-3");
      });
	   	function picCustom() {
	   		var frameSrc = "<%=basePath%>/pic/picpage";
	   	    $("#picIframe").attr("src", frameSrc);
	   	    $('#picModal').modal({ show: true, backdrop: 'static' });
	   	};
   </script>
	<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>