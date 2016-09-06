<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script src="<%=basePath%>static/plugins/jquery.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap-select.min.js"></script>

<script src="<%=basePath%>static/js/ie10-viewport-bug-workaround.js"></script>
<script src="<%=basePath%>static/plugins/jquery.cityselect.js"></script>

<!--[if IE 6]>
    <script src="static/admin/js/DD_belatedPNG.js"></script>
    <script>
    DD_belatedPNG.fix('*');
    </script>
<![endif]-->

<script type="text/javascript">
	
</script>