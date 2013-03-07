package edu.limen.limenlibrary.service;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.client.HttpClient;

import edu.limen.limenlibrary.http.response.json.LoginDataObject;


public interface ISecurityService  extends IBaseService{

	public LoginDataObject login(HttpServletRequest req, String username, String password);
	public LoginDataObject login(HttpClient httpclient, HttpServletRequest req, String username, String password);
	public Integer getUserId();
}
