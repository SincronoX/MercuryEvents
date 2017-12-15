package com.mercury.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mercury.model.Amministratore;
import com.mercury.model.Ente;
import com.mercury.model.EventoPrevisto;
import com.mercury.model.dao.AmministratoreImp;
import com.mercury.model.dao.EnteImp;
import com.mercury.model.dao.MercuryImp;

public class ServletAdmin extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		Ente ente = null;
		AmministratoreImp ai = new AmministratoreImp();
		EventoPrevisto ep = null;
		RequestDispatcher disp = null;
		HttpSession session = request.getSession();


		if(request.getParameter("pagina").equals("enti")) {
			String cheDevoFare = request.getParameter("enteOK");
			int numEnte = Integer.parseInt(request.getParameter("entInAtt"));

			if(cheDevoFare.equals("Accetta")) {

				ente=(Ente)session.getAttribute("enteInAttesa"+numEnte);
				
				ai.InvioMailAbilitaEnte(ente);
				
				Amministratore a = new Amministratore();
				a = ai.getAdminByEmail(request.getParameter("ammin"));

				//disp=request.getRequestDispatcher("AreaRiservataAdmin.jsp");	
				session.setAttribute("admin", a); 
				//disp.forward(request, response);
				response.sendRedirect("view/AreaRiservataAdmin.jsp");
			} 
			else if (cheDevoFare.equals("Rifiuta")) {
				ente=(Ente)session.getAttribute("enteInAttesa"+numEnte);
				
				ai.InvioMailDeclinaEnte(ente);

				Amministratore a = new Amministratore();
				a = ai.getAdminByEmail(request.getParameter("ammin"));

				//disp=request.getRequestDispatcher("AreaRiservataAdmin.jsp");	
				
				session.setAttribute("admin", a); 
				response.sendRedirect("view/AreaRiservataAdmin.jsp");

			}

		} 

		else if(request.getParameter("pagina").equals("eventi")) {
			String cheDevoFare = request.getParameter("checkOK");
			int numEv = Integer.parseInt(request.getParameter("numEv"));

			if(cheDevoFare.equals("Accetta")) {
				ep=(EventoPrevisto)session.getAttribute("evento" +numEv);

				boolean ok= true;
				ai.checkEvento(ep, ok);

				Amministratore a = new Amministratore();
				a = ai.getAdminByEmail(request.getParameter("ammin"));

				//disp=request.getRequestDispatcher("view/AreaRiservataAdmin.jsp");	
				session.setAttribute("admin", a); 
				//disp.forward(request, response);
				response.sendRedirect("view/AreaRiservataAdmin.jsp");
			}
			else if (cheDevoFare.equals("Ban")) {
				ep=(EventoPrevisto)session.getAttribute("evento" +numEv);
				boolean ok= false;
				ai.checkEvento(ep, ok);

				Amministratore a = new Amministratore();
				a = ai.getAdminByEmail(request.getParameter("ammin"));
				//request.setAttribute("admin", a); 
				session.setAttribute("admin", a); 
				response.sendRedirect("view/AreaRiservataAdmin.jsp");

//				disp=request.getRequestDispatcher("view/AreaRiservataAdmin.jsp");	
//				disp.forward(request, response);
			}
		}
	} 		
}
