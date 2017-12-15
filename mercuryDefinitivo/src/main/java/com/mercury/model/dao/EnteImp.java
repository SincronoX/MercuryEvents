package com.mercury.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;

import com.mercury.model.dao.DAO;
import com.mercury.model.Ente;
import com.mercury.model.EventoPrevisto;
import com.mercury.model.dao.MercuryImp;

public class EnteImp implements EnteUtil {
	
	public Calendar stringToDate(String s) {
		String[] aux = s.split(" - ");
		int anno = Integer.parseInt(aux[0]);
		int mese = Integer.parseInt(aux[1]) - 1; 
		int giorno = Integer.parseInt(aux[2]);
		Calendar ret = new GregorianCalendar(anno, mese, giorno);
		return ret;
	}
	
	public ArrayList<EventoPrevisto> getEventiByEnte (String emailEnte){  //emailEnte verr� definito in servlet 
		int idEvento=0;
		String nomeEvento = null;
		String descrizione = null;
		Calendar dataInizio = null;
		Calendar dataFine = null;
		EventoPrevisto e = null;
		ArrayList<EventoPrevisto> eventi = new ArrayList<EventoPrevisto>();
		Connection conn=DAO.getConnection();
		String query="select * from eventoprevisto join ente on eventoprevisto.idEnte = ente.idEnte where emailEnte='"+emailEnte+"'";
		PreparedStatement psEventi=null;
		try {
			psEventi = conn.prepareStatement(query);
			ResultSet rst=psEventi.executeQuery();
			while(rst.next()) {
				e = new EventoPrevisto();
				idEvento = rst.getInt("idEvento");
				nomeEvento = rst.getString("nomeEvento");
				descrizione = rst.getString("descrizione");
				dataInizio = stringToDate(rst.getString("dataInizio"));
				dataFine = stringToDate(rst.getString("dataFine"));
				int idTipoEvento = rst.getInt("idTipoEvento");
				String idComune = rst.getString("idComune");
				
				e.setIdEvento(idEvento);
				e.setNomeEvento(nomeEvento);
				e.setDescEvento(descrizione);
				e.setDataInizio(dataInizio);	
				e.setDataFine(dataFine);
				e.setIdTipoEvento(idTipoEvento);
				e.setIdComune(idComune);
				eventi.add(e);
			}
		}
		catch(SQLException exc){
			exc.printStackTrace();
		}
		
		return eventi;
	}
	
	public boolean trovaEnte (Ente en) {
		boolean trovato = false;
		Connection conn=DAO.getConnection();
		String nome = en.getNomeEnte();
		String email = en.getEmailEnte();
		String query="select * from mercury.ente where nomeEnte = '"+nome+"' or emailEnte = '"+email+"'";
		Statement psTrovaEnte=null;
		try {
			psTrovaEnte = conn.createStatement();
			ResultSet rst=psTrovaEnte.executeQuery(query);
			if(rst.first()) {
				trovato = true;
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return trovato;
	}
	
	public void addEnte(Ente en) {
		final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		StringBuilder builder = new StringBuilder();
		for ( int i = 0 ; i < 8 ; i++) {
			int character = (int)(Math.random()*ALPHA_NUMERIC_STRING.length());
			builder.append(ALPHA_NUMERIC_STRING.charAt(character));
		}
		String pass = builder.toString();
		Connection conn=DAO.getConnection();
		String nome = en.getNomeEnte().replaceAll("'", "\\\\'");
		String email= en.getEmailEnte().replaceAll("'", "\\\\'");
		
		String queryAddEnte="insert into mercury.ente (nomeEnte,emailEnte,pswEnte,status,nBan) values ('"+nome+"','"+email+"','"+pass+"','attesa',0)";
		Statement psAddEnte=null;
		try {
			psAddEnte = conn.createStatement();
			psAddEnte.executeUpdate(queryAddEnte);
			}
		catch(SQLException exc){
			exc.printStackTrace();
		}
	}
	
	public void inserisciEvento (EventoPrevisto e, int idEnte) {
		Connection conn = DAO.getConnection();
		MercuryImp m = new MercuryImp();
		String nomeEvento= e.getNomeEvento().replaceAll("'", "\\\\'");
		String dataInizio= m.dateToString(e.getDataInizio()).replaceAll("'", "\\\\'");
		String dataFine= m.dateToString(e.getDataFine()).replaceAll("'", "\\\\'");
		String descEvento= e.getDescEvento().replaceAll("'", "\\\\'");
		int TipoEvento= e.getIdTipoEvento();		
		String idComune= e.getIdComune().replaceAll("'", "\\\\'");
		String queryAddEvento = "insert into mercury.eventoprevisto (nomeEvento, dataInizio,dataFine,descrizione,checked, idEnte, idTipoEvento, idComune) values ('"+nomeEvento+"','"+dataInizio+"','"+dataFine+"','"+descEvento+"',0,"+idEnte+","+TipoEvento+",'"+idComune+"')";
		Statement psAddEvento = null;
		try {
			psAddEvento = conn.createStatement();		
			psAddEvento.executeUpdate(queryAddEvento);
		}
		catch(SQLException exc){
			exc.printStackTrace();
		}
		
	}
	public void modificaEvento (EventoPrevisto e) {
		Connection conn = DAO.getConnection();
		MercuryImp m = new MercuryImp();
		String nomeEvento = e.getNomeEvento().replaceAll("'", "\\\\'");
		String dataInizio = m.dateToString(e.getDataInizio()).replaceAll("'", "\\\\'");
		String dataFine = m.dateToString(e.getDataFine()).replaceAll("'", "\\\\'");
		String descEvento = e.getDescEvento().replaceAll("'", "\\\\'");
		int tipoEvento = e.getIdTipoEvento();
		String idComune = e.getIdComune().replaceAll("'", "\\\\'");
		int idEvento = e.getIdEvento();
		String queryModificaEvento = "update mercury.eventoprevisto set nomeEvento = '"+nomeEvento+"' , dataInizio = '"+dataInizio+"' , dataFine = '"+dataFine+"' , descrizione = '"+descEvento+"' , checked = 0, idTipoEvento = "+tipoEvento+", idComune = '"+idComune+"' where idEvento = "+idEvento;
				
		PreparedStatement psModificaEvento = null;
		try {
			psModificaEvento = conn.prepareStatement(queryModificaEvento);		
			psModificaEvento.executeUpdate();
		}
		catch(SQLException exc) {
			exc.printStackTrace();
		}
	}
	
	public void eliminaEvento(EventoPrevisto e) {
		
		Connection conn = DAO.getConnection();
		MercuryImp m = new MercuryImp();
		EventoPrevisto ep = new EventoPrevisto();
		
		String queryCopiaEvento = "select * from eventoprevisto where idEvento = "+e.getIdEvento();
		String queryAddEvento = "insert into eventonascosto (nomeEvento,dataInizio,dataFine,descrizione,checked, idEnte, idTipoEvento, idComune) values (";
		String queryEliminaEvento = "Delete from eventoprevisto where idEvento = "+e.getIdEvento();
	
		PreparedStatement psCopiaEvento = null;
		PreparedStatement psAddEvento = null;
		PreparedStatement psEliminaEvento = null;
		
		try {
			psCopiaEvento = conn.prepareStatement(queryCopiaEvento);
			psAddEvento = conn.prepareStatement(queryAddEvento);
			psEliminaEvento = conn.prepareStatement(queryEliminaEvento);
			ResultSet rst=psCopiaEvento.executeQuery();
			
			if(rst.first()) {
				ep.setIdEnte(rst.getInt("idEnte"));
				ep.setNomeEvento(rst.getString("nomeEvento"));
				ep.setDataInizio(m.stringToDate(rst.getString("dataInizio")));
				ep.setDataFine(m.stringToDate(rst.getString("dataFine")));
				ep.setDescEvento(rst.getString("descrizione"));
				ep.setCheck(rst.getBoolean("checked"));
				ep.setIdComune(rst.getString("idComune"));
				ep.setIdTipoEvento(rst.getInt("idTipoEvento"));
				queryAddEvento += ("'"+ep.getNomeEvento().replaceAll("'", "\\\\'")+"', ");
				queryAddEvento += ("'"+m.dateToString(ep.getDataInizio()).replaceAll("'", "\\\\'")+"', ");
				queryAddEvento += ("'"+m.dateToString(ep.getDataFine()).replaceAll("'", "\\\\'")+"', ");
				queryAddEvento += ("'"+ep.getDescEvento().replaceAll("'", "\\\\'")+"', ");
				queryAddEvento += (1+", ");
				queryAddEvento += (ep.getIdEnte()+", ");
				queryAddEvento += (ep.getIdTipoEvento()+", ");
				queryAddEvento += ("'"+ep.getIdComune().replaceAll("'", "\\\\'")+"')");
				psAddEvento = conn.prepareStatement(queryAddEvento);
				psAddEvento.executeUpdate();
				psEliminaEvento.executeUpdate();
			}
		}
		catch(SQLException exc) {
			exc.printStackTrace();
		}
		
	}   
	
	public Ente getEnteById(int id) {
		Ente e = new Ente();
		Connection conn=DAO.getConnection();
		String query="select * from mercury.ente where idEnte="+id; 
		PreparedStatement psId=null;
		try {
			psId = conn.prepareStatement(query);
			ResultSet rst=psId.executeQuery();
			if(rst.first()) {
				e.setIdEnte(rst.getInt("idEnte"));
				e.setNomeEnte(rst.getString("nomeEnte"));
				e.setEmailEnte(rst.getString("emailEnte"));
				e.setPswEnte(rst.getString("pswEnte"));
				e.setStatus(rst.getString("status"));
				e.setnBan(rst.getInt("nBan"));
			}
		}
		catch(SQLException exc){
			exc.printStackTrace();
		}
						
		return e;
		
	}
	
	public ArrayList<Ente> getEntiInAttesa(){
		ArrayList<Ente> enti = new ArrayList<Ente>();
		Ente e= null;
		Connection conn=DAO.getConnection();
		String query="select * from ente where status='attesa'";
		PreparedStatement psEntiInAttesa=null;
		try {
			psEntiInAttesa = conn.prepareStatement(query);
			ResultSet rst=psEntiInAttesa.executeQuery();
			while(rst.next()) {
				e = new Ente();
				e.setIdEnte(rst.getInt("idEnte"));
				e.setNomeEnte(rst.getString("nomeEnte"));
				e.setEmailEnte(rst.getString("emailEnte"));
				e.setPswEnte(rst.getString("pswEnte"));
				e.setStatus(rst.getString("status"));
				e.setnBan(rst.getInt("nBan"));
				enti.add(e);
			}
		}
		catch(SQLException exc){
			exc.printStackTrace();
		}
		return enti;
	}
		
	public boolean controlloLoginEnte (String email, String psw) {
		boolean trovato = false;
		Connection conn=DAO.getConnection();
		String query="select * from mercury.ente where emailEnte = '"+email+"' and pswEnte = '"+psw+"' and status = 'attivo'";
		PreparedStatement psControlloLoginEnte=null;
		try {
			psControlloLoginEnte = conn.prepareStatement(query);
			ResultSet rst=psControlloLoginEnte.executeQuery();
			if(rst.first()) {
				trovato = true;
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}		
		return trovato;
	}
	public Ente getEnteByEmail(String email) {
	Ente e = new Ente();
	Connection conn=DAO.getConnection();
	String query="select * from mercury.ente where emailEnte='"+email+"'";
	PreparedStatement psEm=null;
	try {
		psEm = conn.prepareStatement(query);
		ResultSet rst=psEm.executeQuery();
		if(rst.first()) {
			e.setIdEnte(rst.getInt("idEnte"));
			e.setNomeEnte(rst.getString("nomeEnte"));
			e.setEmailEnte(rst.getString("emailEnte"));
			e.setPswEnte(rst.getString("pswEnte"));
			e.setStatus(rst.getString("status"));
			e.setnBan(rst.getInt("nBan"));
		}
	}
	catch(SQLException exc)
	{
		exc.printStackTrace();
	}
					
	return e;
	
	}
		
		
	}

	
	
	



