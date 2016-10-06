package com.gmzj.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gmzj.entity.Page;
import com.gmzj.entity.Pic;
import com.gmzj.entity.PicExample;
import com.gmzj.entity.PicExample.Criteria;
import com.gmzj.entity.vo.PicListWebRequest;
import com.gmzj.service.PicService;
import com.gmzj.util.Const;
import com.gmzj.util.FileUpload;
import com.gmzj.util.JsonResult;
import com.gmzj.util.UuidUtil;


@Controller
@Scope("prototype")
@RequestMapping("pic/")
public class PicController extends BaseController{
	
static Logger logger = LoggerFactory.getLogger(PicController.class);
	
	@Autowired
	private PicService picService;

	@RequestMapping(value="picPage")
	public String  openPicPage(@RequestParam("resId") String resId, @RequestParam("resName") String resName,
			@RequestParam("resType") String resType, Model model) throws UnsupportedEncodingException {   
		model.addAttribute("resId", resId);
		//处理中文乱码
		model.addAttribute("resName", resName);
		model.addAttribute("resType", resType);
		return "pic/pic";
    }

	/**
	 * 分页查询图片信息
	 * @param req
	 * @return
	 */
	@RequestMapping(value="findPic", method = RequestMethod.POST)
	@ResponseBody
	public Object ajaxfindPic(Page page, Pic pic) {
		page.setParm(pic);
		List<Pic> list = null;
		try {
			list = picService.listPage(page);
		}catch(Exception e) {
			logger.error("分页查询图片失败", e);
			JsonResult.jsonError(e.getMessage());
		}
		return JsonResult.jsonData(list);
    }
	
	@RequestMapping(value="addPage")
	public String  openAddPage( Model model) throws UnsupportedEncodingException {   
		return "pic/add";
    }
	
	/**
	 * 新图片信息
	 * @param pic
	 * @return
	 */
	@RequestMapping(value="addPic", method = RequestMethod.POST)
	@ResponseBody
	public Object ajaxAddPic(Pic pic, @RequestParam(value = "files", required = true) MultipartFile[] files) {  
		StringBuffer path = new StringBuffer();
		path.append(pic.getResType()).append("/");
		path.append(pic.getResId()).append("/");
		logger.debug("图片path:{}", path.toString());
		try{
			for(MultipartFile file:files){
				if(!file.isEmpty()){
					String fileurl = resourceConvertURL(file, pic.getResType(), pic.getResId());
					PicExample example = new PicExample();
					Criteria criteria = example.createCriteria();
					criteria.andResTypeEqualTo(pic.getResType());
					criteria.andResIdEqualTo(pic.getResId());
					List<Pic> list = picService.findPics(example);
					if(CollectionUtils.isEmpty(list)){
						pic.setIsMain(true);	
					}else{
						pic.setIsMain(false);	
					}
					pic.setImgUrl(fileurl);
					picService.insert(pic);
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return JsonResult.jsonError("新增失败:" + e.getMessage());
		}
		return  JsonResult.jsonOk();
    }


	/**
	 * 资源快照图片上传
	 * @param pic
	 * @return
	 */
	@RequestMapping(value="addPic4CKEditor", method = RequestMethod.POST)
	@ResponseBody
	public void ajaxAddPic4CKEditor(Pic pic, @RequestParam("upload") MultipartFile file,
			HttpServletRequest request,HttpServletResponse response) {
		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("X-Frame-Options", "SAMEORIGIN");
		
		String fileurl = resourceConvertURL(file, pic.getResType(), pic.getResId());
		logger.debug("快照图片上传srcfile{}", fileurl);
		String CKEditorFuncNum = request.getParameter("CKEditorFuncNum");
		PrintWriter out = null;
		String s = "<script type=\"text/javascript\">window.parent.CKEDITOR.tools.callFunction("+CKEditorFuncNum+", '"+fileurl+"');</script>";
		try {
			out = response.getWriter();
			out.print(s);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			out.print(s);
			out.flush();
		}
	}
	
	/**
	 * 新图片信息
	 * @param pic
	 * @return
	 */
	@RequestMapping(value="addLinePic", method = RequestMethod.POST)
	public void uploadFile(Pic pic, @RequestParam("upload") 
			MultipartFile file,
			HttpServletRequest request,
			HttpServletResponse response) {  
		logger.debug("当前新增图片对象 {}", file);

		StringBuffer path = new StringBuffer();
		path.append("/").append("line").append("/");
		logger.debug("图片path{}", path.toString());

		String fileurl = resourceConvertURL(file, pic.getResType(), pic.getResId());
		logger.debug("图片srcfile{}", fileurl);

		response.setContentType("text/html;charset=UTF-8");
		//      response.setHeader("X-Frame-Options", "SAMEORIGIN");
		String CKEditorFuncNum = request.getParameter("CKEditorFuncNum");
		PrintWriter out;
		String s = "<script type=\"text/javascript\">window.parent.CKEDITOR.tools.callFunction("+CKEditorFuncNum+", '"+fileurl+"');</script>";
		try {
			out = response.getWriter();
			out.print(s);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 删除图片信息
	 * @param scenic
	 * @return
	 */
	@RequestMapping(value="delPic", method = RequestMethod.POST)
	@ResponseBody
	public Object ajaxdelPic(@RequestParam(value = "index") int id, String srcfile) {  
		try{
			//picService.delete(id);
		}
		catch(Exception e){
			return JsonResult.jsonError("删除失败");
		}
		// 尝试删除资源服务器的资源
		return JsonResult.jsonOk();
    }
	
	/**
	 * 修改图片的显示顺序
	 */
	@RequestMapping(value="updateSeqs", method = RequestMethod.POST)
	@ResponseBody
	public Object updatePicsSeq(PicListWebRequest req)
	{
		try {
			picService.updateSeqs(req.getPiclist());
		} catch (Exception e) {
			return JsonResult.jsonError(e.getMessage());
		}
		return JsonResult.jsonOk();
	}
	
	/**
	 * 上传文件
	 * @param file
	 * @param type
	 * @param resId
	 * @return
	 */
	private String resourceConvertURL(MultipartFile file, String type, int resId){
		String  ffile = type + "/" + resId, fileName = "";
		if (null != file && !file.isEmpty()) {
			String filePath = Const.FILEPATHIMG + ffile;		//文件上传路径
			fileName = FileUpload.fileUp(file, filePath, UuidUtil.get32UUID());				//执行上传
		}else{
			System.out.println("上传失败");
		}
		return ffile + "/" + fileName;
	}
}
