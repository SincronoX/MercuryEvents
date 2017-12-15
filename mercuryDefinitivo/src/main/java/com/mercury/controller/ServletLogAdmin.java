package com.mercury.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mercury.model.Amministratore;
import com.mercury.model.dao.AmministratoreImp;


public class ServletLogAdmin extends HttpServlet{

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Amministratore admin = new Amministratore();
		AmministratoreImp ai = new AmministratoreImp();
		String email =request.getParameter("emailAdmin");
		String pass =request.getParameter("pswAdmin");

		if(request.getParameter("form").equals("LoginAdmin")) {	

			boolean	esisteAdmin= ai.trovaAdmin(email, pass);

			if(esisteAdmin==true) {	

				admin.setEmailAdmin(email);
				admin.setPswAdmin(pass);

				HttpSession session=request.getSession();	    
				session.setAttribute("admin", admin); 
				response.sendRedirect("view/AreaRiservataAdmin.jsp");

				//RequestDispatcher rd = request.getRequestDispatcher("/view/AreaRiservataAdmin.jsp");
				//request.setAttribute("admin", admin);
				//rd.forward(request, response); 
			} 
			
			else if (esisteAdmin == false) {
				request.setAttribute("error", "Email e/o password errati");		
				response.sendRedirect("view/LoginAdmin.jsp");
				//RequestDispatcher rd = request.getRequestDispatcher("view/LoginAdmin.jsp");
				//rd.forward(request,  response);				
			}  
		}
		else if (request.getParameter("form").equals("Logout")) {	

			HttpSession session=request.getSession(false);

			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
			response.setDateHeader("Expires", 0); 
			response.setHeader("Pragma","no-cache");           

			session.invalidate();
			response.sendRedirect("view/HomePage.jsp");

			//return;

			//			rd = request.getRequestDispatcher("view/HomePage.jsp");
			//			rd.forward(request, response); 

		}
	}
}





