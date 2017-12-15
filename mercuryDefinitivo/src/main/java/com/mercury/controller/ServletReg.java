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

public class ServletReg extends HttpServlet {
	private static final long serialVersionUID = 1L;
      	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher disp;
		 Ente ente ;
		 
		 if(request.getParameter("form").equals("registrazioneEnte")) //campo hidden di RegistrazioneEnte.jsp
		{	
			HttpSession ss = request.getSession();
			
			String messaggio=null;
			EnteImp ei = new EnteImp();
			ente=new Ente();
			ente.setNomeEnte(request.getParameter("nomeEnte"));
			ente.setEmailEnte(request.getParameter("emailEnte"));
			boolean trovato = ei.trovaEnte(ente);
			if(trovato==true)
			{	
				messaggio = "Impossibile registrarti, il nome"+ "<br />" + "o l'email sono gia' presenti nel database";
				//disp=request.getRequestDispatcher("view/RegistrazioneEnte.jsp");	
				ss.setAttribute("giaEsiste", messaggio);
				//disp.forward(request, response);
				response.sendRedirect("view/RegistrazioneEnte.jsp");
				
			} 
			else 
			{
				messaggio= "richiesta di registrazione effettuata,<br> attendi email di conferma"; // alert!!
				ei.addEnte(ente);
				ss.setAttribute("giaEsiste", messaggio);
				response.sendRedirect("view/RegistrazioneEnte.jsp");
			}
		
	}

}
}

