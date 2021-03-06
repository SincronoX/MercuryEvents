package com.mercury.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mercury.model.Ente;
import com.mercury.model.dao.EnteImp;

/**
 * Servlet implementation class ServletLogEnte
 */
public class ServletLogEnte extends HttpServlet {
	private static final long serialVersionUID = 1L;
       


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String pagina = request.getParameter("log");
		RequestDispatcher req=null;
		Ente ente = new Ente();
		EnteImp enteimp = new EnteImp();
		if(pagina.equals("login")) {
			
			String email = request.getParameter("emailEnte");
			String psw = request.getParameter("pswEnte");
			
			boolean esisteEnte = enteimp.controlloLoginEnte(email, psw);
			if (esisteEnte) {
				/*HttpSession session = request.getSession(true);	    
				session.setAttribute("currentSessionUser",ente); */
	
				HttpSession ss = request.getSession();	    
				//session.setAttribute("currentSessionUser",ente); 
				//response.sendRedirect("view/AreaRiservataEnte.jsp");

				ente = enteimp.getEnteByEmail(email);

				// req=request.getRequestDispatcher("/view/AreaRiservataEnte.jsp");	
				
				ss.setAttribute("ente", ente);
				// req.forward(request, response);    
				response.sendRedirect("view/AreaRiservataEnte.jsp");
				return;
			}
	
			else 
				response.sendRedirect("view/LoginEnte.jsp");
				
		}
		if(pagina.equals("Logout")) {
			HttpSession session = request.getSession(false);
	        if(session!=null){
	            session.invalidate();
	            session=null;
	        }
			response.sendRedirect("view/HomePage.jsp");
		}
		//doGet(request, response);
	}

}