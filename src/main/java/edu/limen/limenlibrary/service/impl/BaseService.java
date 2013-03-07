package edu.limen.limenlibrary.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import edu.limen.limenlibrary.constant.AppConstant;
import edu.limen.limenlibrary.constant.WebServiceConstant;
import edu.limen.limenlibrary.context.AppContext;
import edu.limen.limenlibrary.service.IBaseService;


public class BaseService implements IBaseService {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	protected AppContext appContext;
	@Autowired
	protected AppConstant appConstant;
	@Autowired
	protected WebServiceConstant webServiceConstant;

}
