<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/common/domain.jsp" flush="true"/> 
<html>
<style>
.error-tip {
display: inline-block;
margin-left: 10px;
color: #F71717;
background: #FFEBEB;
border: 1px solid #ffbdbe;
padding: 4px;
border-radius: 3px;
display:none;
}
</style>
	
				
					<c:set var="currentNet" value="重庆电信"/>
        			<c:set var="url" value="${putong_cq_dianxin_url}"/>
        			<c:set var="result" value="putong_tj_yidong"/>
        			<form id="form1" class="base-form" action="">
						<h2 class="base-form-title">重庆电信：</h2>
						
						  <input type="hidden" name="${result}_hidden" id="${result}_hidden" value="false"/>
						
						<div class="base-fieldset clearfix">
							<span class="base-fieldset-title">
								<label>手机号</label>
							</span>
							<span class="base-form-phone">
								${phone}
								<input type="hidden" name="phone" id="${result}phone"  value="${phone}" />
							</span>
						</div>
						<div style="padding-left: 120px">
							<label id="${result}_message" class="error-tip" >密码错误，请重新填写</label>
							<label id="${result}password_tip" class="error-tip" >请输入密码</label>
						</div>
						<div class="base-fieldset login-fieldset clearfix">
							<span class="base-fieldset-title login-fieldset-title">
								<label>服务密码</label>
							</span>
							<input class="base-fieldset-input w173" name="password" id="${result}password" size="30" type="password"/>
							<a class="base-forgetpwd" href="http://service.tj.10086.cn/app?service=page/personalinfo.RegistrarPwdOperation&listener=initPage" target="_blank">忘记密码</a>
						</div>
						<div style="padding-left: 120px">
						<label id="${result}authcode_tip" class="error-tip" >请输入验证码</label>
						<label id="${result}authcode_message" class="error-tip" >验证码错误</label>
						</div>
						<div class="base-fieldset clearfix">
							<span class="base-fieldset-title">
								<label>验证码</label>
							</span>
							
							<input class="base-fieldset-input w173" name="authCode" id="${result}authCode" type="text"/>
		  					<label class="base-form-checkimglab">
							<img  onclick="getAuth()" src="<c:if test="${url ne 'none'}">${imgPath}${url}</c:if>" id="${result}authcode_img" style="height:30px;width:60px;position: relative;top: 8px;"/>
						
		  					</label>
		  					<label class="base-form-changelab">
		  						看不清？<a class="" href="javascript:getAuth();">换一张</a>
		  					</label>
						</div>
						<div class="base-fieldset base-form-submit">
							<input id="lastBtn"  type="button" value="上一步" class="base-btn w120" trigger="base-btn-hover"/>
							<input id="saveBtn" type="button" value="下一步" class="base-btn w120 base-nextstep" onclick="checkField();return false;" trigger="base-btn-hover"/>
						</div>
						<p class="base-from-console">
							<span class="base-from-wrd" id="${result}message" style="display:none;"></span>
						</p>
					</form>
					
					</div>
        			
        			
        			
        			
<script type="text/javascript">




$(document).ready(function(){
	getInitAuth("/${ctx}/dx/cq/first.html");
});
function getAuth(){
	getInitAuth("/${ctx}/dx/cq/image.html");
}

function getInitAuth(requesturl){
	var phone = ${result}("phone").val();
	var t = new Date().getTime();
	if(phone!=''){
		$.ajax({
	   	 	 type:'post',
      		 data:{"loginName":phone,"t":t},
	     	 url:requesturl,
	         success : function(data) {
	         		if(data.state){
	         			 window.location.href="/${ctx}/entranceEmail.html";  	
	         		}else{
	         			var url = data.url;
	         		
	    	 	   	    if(url != 'none'){		
	    	 			 ${result}("authcode_img").attr("src",'${imgPath}'+url+"?l="+new Date().getTime());
	    		   	    }
	         		}
	    	    },
  		      error:function(){	  }
	  	   });
	}
}
function checkField(){ 
	var mess = ${result}("message");
	mess.text("正在努力登录中，请稍等……");
	mess.show(500,firstSubmit);
}

function firstSubmit(){
	var vertifyUrl='/${ctx}/dx/cq/login.html?t='+new Date().getTime();
	var phoneValue = ${result}("phone").val();
    var passwordValue = ${result}("password").val();
    var authCode =${result}("authCode").val();
    
    ${result}("password_tip").hide();
    ${result}("authcode_tip").hide();
    ${result}("authcode_message").hide();
   // ${result}("message").text("");
    if(passwordValue==''||passwordValue== undefined){
   	    ${result}("password_tip").show();
    	return false;
    }
    if(!${result}("authimg").css("display")){
      if (authCode==''||authCode== undefined){
    	 ${result}("authcode_tip").show();
    	return false;
    	}
    }
  	$("#saveBtn").attr('disabled','disabled'); 
	$.ajax({
	     type:'post',
       	 async:true,                                                            
	     url:vertifyUrl,
	     data:{"loginName":phoneValue,password:passwordValue,"authcode":authCode},
	     success : function(data) {
			   if(data.state){
		    		 window.location.href="/${ctx}/entranceEmail.html";  

		    			
		    		 
				}else{
					if(data.url!='none'){
						${result}("authimg").show(); 	
	    	 		 	${result}("authcode_img").attr("src",'${imgPath}'+data.url+"?l="+new Date().getTime());
					}
					${result}("message").text(data.msg);
				}
				$("#saveBtn").removeAttr("disabled");
	    	},
	    	 error:function(){
	    		 ${result}("message").text("系统错误,请刷新页面重试!");
	    		$("#saveBtn").removeAttr("disabled");
	    	 }
	     });
}
function ${result}(id){
	var result = "${result}";
	return $("#"+result+id);
}







	
</script>
</html>