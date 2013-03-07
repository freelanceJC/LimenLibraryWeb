package edu.limen.limenlibrary.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import edu.limen.limenlibrary.constant.AppConstant;
import edu.limen.limenlibrary.service.IHelloService;


@Controller
public class HelloController extends BaseController implements org.springframework.web.servlet.mvc.Controller{

	protected final Log logger = LogFactory.getLog(getClass());
	
	
	
	@RequestMapping(value = "/helloworld")
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        logger.info("handleRequest() begin");

        HashMap<String, String> data = new HashMap<String, String>();
        
        data.put("string1", appContext.getTestStr());
        
        
        
        logger.debug("debug log here");
        
        logger.info("handleRequest() end");
        return new ModelAndView("hello", "data", data);
    }
}
