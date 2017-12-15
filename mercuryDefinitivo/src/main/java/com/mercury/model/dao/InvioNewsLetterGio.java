package com.mercury.model.dao;

import java.sql.SQLException;
import java.util.Date;


public class InvioNewsLetterGio extends Thread implements Runnable{

	Date now;
	
	public InvioNewsLetterGio () {
		super();
	}
	
	public void run () {
		while (true) { 
			SendMail s = new SendMail();
			try {
				s.sendEmail(1);
				Thread.sleep(86400000);
			}
			catch (InterruptedException e) {
				e.printStackTrace();
			}
			catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	}
}
