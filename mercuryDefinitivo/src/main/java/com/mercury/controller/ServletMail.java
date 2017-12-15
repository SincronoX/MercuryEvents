package com.mercury.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mercury.model.Ente;
import com.mercury.model.Utente;
import com.mercury.model.dao.EnteImp;
import com.mercury.model.dao.UtenteImp;


public class ServletMail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		RequestDispatcher disp;
		Utente u ;	
		HttpSession ss=request.getSession();
		String messaggio=null;
		UtenteImp ui = new UtenteImp();
		u=new Utente();
		u.setEmailUtente(request.getParameter("email"));	
		u.setIdCadenza(Integer.parseInt(request.getParameter("cadenza")));
		u.setIdComune(request.getParameter("idComune"));
		boolean trovato = ui.trovaUtente(u.getEmailUtente());
			
		if(trovato==true){	
			ss.setAttribute("messaggio", "La tua email e' gia' stata inserita!");
			response.sendRedirect("view/Newsletter.jsp");
		} 
		else{
			try {

				ArrayList <Integer> lista = new ArrayList<Integer>();		
				for(int i = 1 ; i<=5 ; i++) {
					if(request.getParameter("tipo"+i)!=null)
						lista.add(Integer.parseInt(request.getParameter("tipo"+i)));
				}
				ui.addUtente(u.getEmailUtente(), u.getIdCadenza(), u.getIdComune(), lista);
				response.sendRedirect("view/HomePage.jsp");			
			} 
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
