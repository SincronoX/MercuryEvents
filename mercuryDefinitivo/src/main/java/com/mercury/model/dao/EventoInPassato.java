// Fabio Savelli

package com.mercury.model.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class EventoInPassato  extends Thread implements Runnable{
		
	Connection conn=null;
	
	public EventoInPassato() {
		super();
	}

	public void run() {
		while(true) {
			DateFormat dateFormat = new SimpleDateFormat("yyyy - MM - dd");
			Calendar cal = Calendar.getInstance();
			
			if(conn==null) conn=DAO.getConnection();
						
	        try {
				Statement st1 = conn.createStatement();
				Statement st2 = conn.createStatement();
				Statement st3 = conn.createStatement();
				String query="SELECT * FROM mercury.eventoprevisto where dataFine < '"+dateFormat.format(cal.getTime())+"'";
		        ResultSet rs1 = st1.executeQuery(query); 
		        while(rs1.next()) {
		        	String query2 = "INSERT INTO mercury.eventopassato (nomeEvento, dataInizio, dataFine, descrizione, checked, idEnte, idTipoEvento, idComune) values (";
		        	query2 += ("'"+rs1.getString("nomeEvento")+"', ");
		        	query2 += ("'"+rs1.getString("dataInizio")+"', ");
		        	query2 += ("'"+rs1.getString("dataFine")+"', ");
		        	query2 += ("'"+rs1.getString("descrizione")+"', ");
		        	query2 += (rs1.getInt("checked")+", ");
		        	query2 += (rs1.getInt("idEnte")+", ");
		        	query2 += (rs1.getInt("idTipoEvento")+", ");
		        	query2 += ("'"+rs1.getString("idComune")+"')");
		        			        	
		        	st2.executeUpdate(query2);
		        }
		        
		        String query3 = "DELETE FROM mercury.eventoprevisto where dataFine < '"+dateFormat.format(cal.getTime())+"'";
		        st3.executeUpdate(query3);
	        } 
	        catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	}
}