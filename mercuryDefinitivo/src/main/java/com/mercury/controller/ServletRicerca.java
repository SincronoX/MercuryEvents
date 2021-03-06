// Fabio Savelli

package com.mercury.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mercury.model.EventoPrevisto;
import com.mercury.model.TipoEvento;
import com.mercury.model.dao.ComuneImp;
import com.mercury.model.dao.MercuryImp;
import com.mercury.model.dao.TipoEventoImp;

/**
 * Servlet implementation class ServletRicerca
 */
public class ServletRicerca extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	private Calendar stringToData(String s) {
		String[] aux = s.split("-");
		int anno = Integer.parseInt(aux[0]);
		int mese = Integer.parseInt(aux[1])-1; 
		int giorno = Integer.parseInt(aux[2]);
		Calendar ret = new GregorianCalendar(anno, mese, giorno);
		return ret;
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		MercuryImp m = new MercuryImp();
		
		TipoEvento att = new TipoEvento();
		TipoEventoImp tipi = new TipoEventoImp();
		ArrayList<TipoEvento> t = new ArrayList<TipoEvento>();//tipi.getEventoCatAll();
		
		if(request.getParameter("tipo1") == null) {//teatro
			att = tipi.getTipoEventoById(1); 
			t.add(att);
		}
		if(request.getParameter("tipo2") == null) {//concerto
			att = tipi.getTipoEventoById(2);
			t.add(att);
		} 
		if(request.getParameter("tipo3") == null) {// film
			att = tipi.getTipoEventoById(3);
			t.add(att);
		}
		if(request.getParameter("tipo4") == null) { //mostra
			att = tipi.getTipoEventoById(4);
			t.add(att);
		}
		if(request.getParameter("tipo5") == null) { //altro
			att = tipi.getTipoEventoById(5);
			t.add(att);
		}
		
		if(t.size()>=tipi.getEventoCatAll().size())
			t = new ArrayList<TipoEvento>();
		String comune = 	request.getParameter("idComune");
		
		
		String data = request.getParameter("data");
		Calendar d = null;
		if(data!= null && !data.equals(""))
			d= stringToData(data);
		
		ArrayList<EventoPrevisto> ret = new ArrayList<EventoPrevisto>();
		
		try {
			ret = m.getRicerca(t, comune, d);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		HttpSession ss=request.getSession();
		ss.setAttribute("risultato", ret);
		
		//RequestDispatcher disp=request.getRequestDispatcher("/RisultatoRicerca.jsp");
		//request.setAttribute("risultatoRicerca", ret);
		//request.getSession().setAttribute("risultato", ret);
		response.sendRedirect("view/RisultatoRicerca.jsp");
		//disp.forward(request,response);
	
		
	}

}
