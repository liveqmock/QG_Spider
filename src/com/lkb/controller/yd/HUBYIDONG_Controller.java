package com.lkb.controller.yd;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lkb.bean.client.Login;
import com.lkb.controller.Mobile_Controller;
import com.lkb.thirdUtil.yd.HUBYidong;
/**
 * 湖北移动
 * @author jzr
 *
 */
@Controller
public class HUBYIDONG_Controller extends Mobile_Controller{
	@RequestMapping(value = "/hub_yidong_sendCard", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getmsg(HttpServletRequest request,Login login) {
		return sendPhoneDynamicsCode(new HUBYidong(login,getCurrentUser(request)));
	}
	
	@RequestMapping(value = "/dongtai_hub_yidong_vertifyLogin", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dongtai_vertifyLogin(HttpServletRequest request,Login login) {
		return checkPhoneDynamicsCode(new HUBYidong(login,getCurrentUser(request)));
	}
	
	@RequestMapping(value = "/fuwu_hub_yidong_vertifyLogin", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> putong_vertifyLogin(HttpServletRequest request,Login login) {
		return login(new HUBYidong(login,getCurrentUser(request)));
	}

	@RequestMapping(value = "/putonghubydFirst", method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> putongFirst(HttpServletRequest request,Login login) {
		return putongFirst(new HUBYidong(login,getCurrentUser(request)));
	}
}
