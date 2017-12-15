package com.mercury.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mercury.model.Ente;
import com.mercury.model.EventoPrevisto;
import com.mercury.model.dao.EnteImp;

/**
 * Servlet implementation class ServletEnte
 */
public class ServletEnte extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public ServletEnte() {
		super(); 
	}
   
	public Calendar stringToDate(String s) {
		String[] aux = s.split("-");
		int anno = Integer.parseInt(aux[0]);
		int mese = Integer.parseInt(aux[1]) - 1; 
		int giorno = Integer.parseInt(aux[2]);
		Calendar ret = new GregorianCalendar(anno, mese, giorno);
		return ret;
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String tipoForm = request.getParameter("modEv");
		RequestDispatcher req=null;
		try{	    		
			EnteImp enteimp = new EnteImp();
			
			if(tipoForm.equals("Aggiungi")) {
				String email = request.getParameter("email");
				Ente e = new Ente();
				e = enteimp.getEnteByEmail(email);
				// req=request.getRequestDispatcher("view/InserisciEvento.jsp");
				request.setAttribute("ente", e);
				// req.forward(request, response);
				response.sendRedirect("view/InserisciEvento.jsp");

			}
			
			
			if(tipoForm.equals("Modifica")) {	
				String email = request.getParameter("email");
				Ente e = new Ente();
				e = enteimp.getEnteByEmail(email);
				HttpSession ss=request.getSession();
				int numEvento =  Integer.parseInt(request.getParameter("numEv"));
				EventoPrevisto ep = (EventoPrevisto)ss.getAttribute("eventi" + numEvento);
				ss.setAttribute("evPrev", ep);
				// req=request.getRequestDispatcher("view/ModificaEvento.jsp");
				ss.setAttribute("ente", e);
				// req.forward(request, response);
				response.sendRedirect("view/ModificaEvento.jsp");
			}
			
			
			if(tipoForm.equals("Cancella")) {
				HttpSession ss=request.getSession();
				int numEvento =  Integer.parseInt(request.getParameter("numEv"));
				EventoPrevisto ep = (EventoPrevisto)ss.getAttribute("eventi" + numEvento);
				
				enteimp.eliminaEvento(ep);

				String email = request.getParameter("email");
				Ente e = new Ente();
				e = enteimp.getEnteByEmail(email);
				
				// req=request.getRequestDispatcher("view/AreaRiservataEnte.jsp");
				request.setAttribute("ente", e);
				response.sendRedirect("view/AreaRiservataEnte.jsp");
				// req.forward(request, response);
			}
			
			
			if(tipoForm.equals("Inserisci")) {
				String emailEnte= request.getParameter("insEv");
				EventoPrevisto e = new EventoPrevisto(); 
				Ente ente = enteimp.getEnteByEmail(emailEnte);
				
				Calendar dInizio = stringToDate(request.getParameter("dataInizio"));
				Calendar dFine   = stringToDate(request.getParameter("dataFine"));
								
				e.setNomeEvento(request.getParameter("nomeEvento"));
				e.setDescEvento(request.getParameter("descEvento"));
				e.setDataInizio(dInizio);	
				e.setDataFine(dFine);
				e.setIdTipoEvento(Integer.parseInt(request.getParameter("tipoEvento")));
				e.setIdComune(request.getParameter("idComune"));
				e.setCheck(false);
				e.setIdEnte(ente.getIdEnte());
				 
				enteimp.inserisciEvento(e, enteimp.getEnteByEmail(emailEnte).getIdEnte());
				HttpSession ss=request.getSession();

				// req=request.getRequestDispatcher("view/AreaRiservataEnte.jsp");
				ss.setAttribute("ente", ente);
				response.sendRedirect("view/AreaRiservataEnte.jsp");

				// req.forward(request, response);				
			}
			
			
			if(tipoForm.equals("Invia")) {	
				HttpSession ss=request.getSession();
				EventoPrevisto e = (EventoPrevisto) ss.getAttribute("eventoMod");
				String emailEnte= request.getParameter("insEv");
				Ente ente = enteimp.getEnteByEmail(emailEnte);
								
				e.setIdComune(request.getParameter("idComune"));
				e.setDescEvento(request.getParameter("descEvento"));
				e.setDataFine(stringToDate(request.getParameter("dataFine")));
				e.setDataInizio(stringToDate(request.getParameter("dataInizio")));
				e.setNomeEvento(request.getParameter("nomeEvento"));
				e.setIdTipoEvento(Integer.parseInt(request.getParameter("tipoEvento")));
				
				
				enteimp.modificaEvento(e);

				//req=request.getRequestDispatcher("view/AreaRiservataEnte.jsp");

				ss.setAttribute("ente", ente);
				response.sendRedirect("view/AreaRiservataEnte.jsp");

				//req.forward(request, response);				
			}
		} 

		catch (Throwable theException){
			theException.printStackTrace(); 
		}
	}
}


