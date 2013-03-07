package edu.limen.limenlibrary.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import edu.limen.limenlibrary.context.LoginForm;
import edu.limen.limenlibrary.http.response.json.HomePageWithFriendjson;
import edu.limen.limenlibrary.http.response.json.LoginDataObject;
import edu.limen.limenlibrary.service.ISecurityService;
import edu.limen.limenlibrary.service.IWebServiceClientService;



@Controller
@RequestMapping("loginform.html")
public class LoginController extends BaseController implements org.springframework.web.servlet.mvc.Controller{

	@Autowired
	IWebServiceClientService webServiceClientService;
	@Autowired
	ISecurityService securityService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String showForm(Map<String, LoginForm> model) {
		LoginForm loginForm = new LoginForm();
		model.put("login", loginForm);
		return "login";
	}

	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView processForm(@Valid LoginForm loginForm, BindingResult result,
			Map<String, Object> model,
			HttpServletRequest request
			) throws Exception {
		
		String userName = loginForm.getUserName();
		String password = loginForm.getPassword();
		
		
		logger.debug(userName);
		//logger.debug(password);

		HttpClient httpclient = new DefaultHttpClient();
		
		LoginDataObject list = securityService.login(httpclient, request, userName, password);
		
		if(list == null){
			/*
			 * TODO ray: please return with error message
			 */
			return new ModelAndView("login");	 
		}
		
        // System.out.println(EntityUtils.toString(entity));
             
             
        //System.out.println(list.toString());
             
        logger.debug(list.getresult());
        logger.debug(list.getuid());
        logger.debug(list.getopenFireID());
             
        int userId = list.getuid();
             
             
        if(list.getresult() == 1){
        	logger.debug("login is ok"); 
               
            logger.debug("saving uid to session");
            

            HttpSession session = request.getSession(true);
            session.putValue("openFireID", list.getopenFireID());

            logger.debug("session openFireID = " + list.getopenFireID());
                 
            ///
            
            /*
             * TODO : 
             * 1. move the web service connection codes to Service, we should not have business logic in controller
             */
            HashMap<String,Object> paramList2 = new HashMap<String,Object>();
             
                  
         	paramList2.put("uid", userId);
         	//HttpClient httpclient2 = new DefaultHttpClient();
         	HttpResponse response2 = webServiceClientService.request(httpclient, webServiceConstant.request_type_homePageWithFriend, paramList2);
                 
         	logger.debug("StatusCode=" + response2.getStatusLine().getStatusCode());
                 
            if(response2 == null || response2.getStatusLine().getStatusCode() != 200 ){
            	logger.error("StatusCode:" + response2.getStatusLine().getStatusCode());
                return new ModelAndView("login");	
            }
                
            HttpEntity entity2 = response2.getEntity();
            if (entity2 != null) {
            	ObjectMapper objectMapper2 = new ObjectMapper();
                HomePageWithFriendjson list2 = objectMapper2.readValue(EntityUtils.toString(entity2), HomePageWithFriendjson.class); 
                	 
               /* logger.debug("//////start///////////");
                logger.debug(list2.getGroup().get(0).getGroupDetail());
                logger.debug(list2.getGroup().get(0).getGroupID());
                logger.debug(list2.getFriends().get(0).getuserName());*/
                logger.debug("//////end///////////");
                model.put("list2", list2); 
                	
                
                return new ModelAndView("loginsuccess");	
            }else{
               	 
             	 return new ModelAndView("login");	
            }

            ///

        }
        else{ 
         	 logger.debug("login is not ok"); 
             	
        }


        return new ModelAndView("login");	
	}//end of post

	@Override
	public ModelAndView handleRequest(HttpServletRequest arg0,
			HttpServletResponse arg1) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
