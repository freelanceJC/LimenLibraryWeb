package edu.limen.limenlibrary.service.impl;

import org.springframework.transaction.annotation.Transactional;

import edu.limen.limenlibrary.service.IHelloService;

public class HelloService implements IHelloService {

	@Override
	@Transactional
	public String getHello() {
		// TODO Auto-generated method stub
		return "hello 3";
	}

}
