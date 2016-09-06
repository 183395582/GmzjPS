<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.gmzj.util.UrlHelper"%>
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
				<div class="box-title">
					<h4>
						<span>公司信息查询</span>
					</h4>
					<div class="tools"></div>
				</div>
				<div class="box-body">
					<div class="box-body big">
						<form:form modelAttribute="searchModel" class="form-horizontal" method="GET">
							<div class="row">
								<div class="col-md-3 col-sm-3">
									<label style="float:left;" for="cusName">公司名称：</label>
									<form:input path="name" name="name" class="form-control placeholder-no-fix" autocomplete="off" placeholder="公司名称" />
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
									<th>公司名称</th>
									<th>经营类型</th>
									<th>所属地区</th>
									<th>状态</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${contentModel}" var="item">
									<tr class="success">
										<td>${item.name }</td>
										<td>${item.typeDescribe }</td>
										<td>${item.city}-${item.dist }</td>
										<td>${item.statDescribe }</td>
										<td>
											<a href="<%=basePath%>company/${item.id }/update" ><li class="fa fa-edit"></li>编辑</a>&nbsp;&nbsp;
											<a herf="#" onClick="javascript:confirm('确认要删除该内容?'); location='<%=basePath%>company/delete?id=${item.id }'"><li class="fa fa-trash-o"></li>删除</a>
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

	<script type="text/javascript">
   	  $(function() {   
         $("#data-table").tableManaged();
         $(".table-toolbar").toolbarLite({
             items: [
                 { link: true, display: "新增", css: "fa fa-plus", showIcon: true, url: "<%=basePath%>company/add"}
             ]
         });
         $(".toolbar").addClass("col-md-4");
         $(".toolbar").css("padding", "0px");
         $(".tool_box").addClass("col-md-3");
      });
   </script>
	<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>