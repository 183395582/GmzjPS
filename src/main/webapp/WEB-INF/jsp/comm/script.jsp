<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script src="<%=basePath%>static/plugins/jquery.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap-select.min.js"></script>
<script src="<%=basePath%>static/plugins/jquery.tableManaged.js"></script>
<script src="<%=basePath%>static/plugins/jquery.toolbarlite.js"></script>

<script src="<%=basePath%>static/plugins/ie10-viewport-bug-workaround.js"></script>
<%-- <script src="<%=basePath%>static/plugins/jquery.cityselect.js"></script> --%>
<script src="http://cdn.static.runoob.com/libs/angular.js/1.4.6/angular.min.js"></script>
<script src="<%=basePath%>static/plugins/localcity.js"></script>
<link rel="stylesheet" href="<%=basePath%>static/plugins/localcity.css">

<!--[if IE 6]>
    <script src="static/admin/js/DD_belatedPNG.js"></script>
    <script>
    DD_belatedPNG.fix('*');
    </script>
<![endif]-->

<script type="text/javascript">

</script>