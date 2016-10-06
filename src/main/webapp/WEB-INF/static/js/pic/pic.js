/**
 * 文件上传弹出框（图片选择器）关闭时的响应函数：向后台提交数据
 */
$("#upfileModal").on("hidden.bs.modal", function(){
    $(this).removeData("bs.modal");
    findpics();//重新加载图片
});


/**
 * 删除链接
 */
function deleteImg(id, path){
    var $this = $("#"+id);
    var $wrapper =  $this.closest('.imgblock');
    var id=$wrapper.attr("data-id");
    var srcFile = $wrapper.attr("data-srcFile");
    //alert("当前图片的index："+id+",srcFile:"+srcFile);
    
    //封装参数
    var param = {};
    param.index = id;
    param.srcfile = srcFile;
    $("body").data("img_id", id);
    
    //ajax调用
    var url = path + "pic/delPic";
    $.ajax({
	     type: 'POST',
	     url:url,
	     data:param,
	     success: function(data){
					if(data.result == "ok"){
						$("#message").text("删除图片成功");
						var img_id=$("body").data("img_id");
						var imgWrapperId="img_wrapper_"+img_id;
						$("#"+imgWrapperId).remove();
						return $("#image-panel").gridly("layout");
					}
					else {
						$("#message").text("删除图片失败:" + json.message );
						return false;
					}
					return false;
				} ,
	    dataType: 'json',
	});
}

/**
 * 拖拽插件--拖拽后调用
 */
var reordered = function($elements) {//拖拽后调用
	var arr = $elements;
	if(arr.length<=1){//如果只有一张图片不用改变序号直接返回
		return false;
	}
	var param={};
	for (i = 0; i < arr.length; i++){
		var userList = new Array();
		var $wrapper=$("#"+arr[i].id);
		if(i === 0 ){
			param["piclist["+i+"].isMain"]=1;
		}else{
			param["piclist["+i+"].isMain"]=0;
		}
		param["piclist["+i+"].id"] =  $wrapper.attr("data-id");
		param["piclist["+i+"].seq"] =  i;
		param["piclist["+i+"].resType"] = $("#resType").val();
		param["piclist["+i+"].resId"] = $("#resId").val();
	}
	console.log(param);
	updateSeqs(param);
};

function showpics(pics) {
	var tpt=$("#imgTpt").html();
	var template = Handlebars.compile(tpt);
	var html= template(pics);	
	$("#image-panel").html(html)
	$('#image-panel').gridly({
	      callbacks: {reordered: reordered}
	});
}

jQuery(function($){
	//查询图片并且显示出来
	findpics();
});
