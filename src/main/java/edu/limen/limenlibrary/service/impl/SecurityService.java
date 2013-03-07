package edu.limen.limenlibrary.service.impl;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Service;

import edu.limen.limenlibrary.http.response.json.LoginDataObject;
import edu.limen.limenlibrary.security.AuthenticationManager;
import edu.limen.limenlibrary.service.ISecurityService;
import edu.limen.limenlibrary.service.IWebServiceClientService;

@Service
public class SecurityService extends BaseService implements ISecurityService {

	@Autowired
	protected IWebServiceClientService webServiceClientService;
	@Autowired
	protected AuthenticationManager authenticationProvider; 

	public Integer getUserId(){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    
		if(auth != null)
			return Integer.valueOf(auth.getName());
		else
			return null;
	}
	
	public LoginDataObject login(HttpServletRequest request, String username, String password){
		HttpClient httpclient = new DefaultHttpClient();
		return login(httpclient, request, username , password);
	}
	public LoginDataObject login(HttpClient httpclient, HttpServletRequest request, String username, String password){
		
		logger.info("login() begin");
		

		if(httpclient == null || username == null || password == null){
			logger.error("Missing parameter(s)");
			return null;
		}

		LoginDataObject result = null;
		
		HashMap<String,Object> paramList = new HashMap<String,Object>();
		
		paramList.put("userName", username);
		paramList.put("password", password);

		HttpResponse response = webServiceClientService.request(httpclient, webServiceConstant.request_type_login, paramList);

		logger.debug("StatusCode=" + response.getStatusLine().getStatusCode());
        
        if(response == null || response.getStatusLine().getStatusCode() != 200 ){
        	logger.error("StatusCode:" + response.getStatusLine().getStatusCode());
        	return null;	
        }
        
        HttpEntity entity = response.getEntity();
        if (entity != null) {

             ObjectMapper objectMapper = new ObjectMapper();
             objectMapper.configure(org.codehaus.jackson.map.DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
             try {
				result = objectMapper.readValue(EntityUtils.toString(entity), LoginDataObject.class);
				
				if(request != null){
					UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(result.getuid(), password);
					token.setDetails(new WebAuthenticationDetails(request));
					
					Authentication authentication = new UsernamePasswordAuthenticationToken(result.getuid(), password, authenticationProvider.AUTHORITIES);

			        logger.debug("Logging in with user id " + authentication.getPrincipal().toString());
			        SecurityContextHolder.getContext().setAuthentication(authentication);

				}

		        
			} catch (JsonParseException e) {
				logger.error("error", e);
			} catch (JsonMappingException e) {
				logger.error("error", e);
			} catch (ParseException e) {
				logger.error("error", e);
			} catch (IOException e) {
				logger.error("error", e);
			}  
        }
        logger.info("login() end");
		return result;
	}
}
