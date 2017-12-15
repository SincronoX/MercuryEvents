package com.mercury.model.dao;
import com.mercury.model.dao.DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.URLName;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.mercury.model.Amministratore;
import com.mercury.model.Ente;
import com.mercury.model.EventoPrevisto;


public class AmministratoreImp  implements AmministratoreUtil {
	protected String host = "smtp.sincrono.it";
	protected String mittente = "corso.java@sincrono.it(MercuryEvents)";
	private final String user="corso.java@sincrono.it";
	private final String psw ="c0rs0.java";


	public boolean trovaAdmin(String email , String psw){
		Connection conn = DAO.getConnection();		
		String query="select * from mercury.amministratore a where a.emailAdmin = '"+email+ "' and a.pswAdmin = '"+psw+"';" ;
		ResultSet rs;
		try {
			rs = DAO.execute_Query(conn, query);
			if(rs.first()==true) { 
				return true ;
			}	
		}catch(SQLException e) { }
		return false ;
	}
	
	public void setStatusEnteNelDB(int id, String newStatus){
		Connection conn = DAO.getConnection();		
		String query="update mercury.ente set status='"+newStatus+"' where idEnte="+id+";" ;
		try {
			DAO.execute_Update(conn, query);	
		}
		catch(SQLException e) { 
			e.printStackTrace();
		}		
	}
	
	public void InvioMailDeclinaEnte(Ente en) {

		String dest = en.getEmailEnte();
		String oggetto = "Ci dispiace, la sua richiesta non e' stata accettata ";
		String testo1 = "L'amministrtore ha deciso di rifiutare la registrazione del tuo ente " +en.getNomeEnte() ;
		String testo2 = ". Non ti è permesso accedere all'area riservata ente, per chiarimenti puoi rivolgerti al" ;
		String testo3 =	 "servizio clienti 006100200" ;
		String testo = testo1+testo2+testo3 ;
	
		Properties p = System.getProperties();
			
		p.setProperty("mail.smtp.host", this.host);
		p.put("mail.smtp.host", this.host);
		p.put("mail.debug", "true");
		p.put("mail.smtp.auth", "true"); 
		     
		    Session sessione = Session.getDefaultInstance(p, new SmtpAutenticazione(user, psw) );
		    sessione.setPasswordAuthentication(new URLName("smtp", host, 25, "INBOX", user, psw), new PasswordAuthentication(user, psw));
		     
		    MimeMessage mail = new MimeMessage(sessione);
		    setStatusEnteNelDB(en.getIdEnte(),"declinato");
	     try {
	    	mail.setFrom(new InternetAddress(mittente));
	    	mail.addRecipients(Message.RecipientType.TO, dest);
	    	 	
	    	mail.setSubject(oggetto);
	    	mail.setText(testo);
	    	Transport tr = sessione.getTransport("smtp");
			tr.connect(host, user, psw);
	    	Transport.send(mail, mail.getAllRecipients());
	     }
	     catch(Exception e) {
	    	 	e.printStackTrace();
	     }
	}

	public void InvioMailAbilitaEnte(Ente en) {
		
		setStatusEnteNelDB(en.getIdEnte(),"attivo");
		String dest = en.getEmailEnte();
		String oggetto = "mail di conferma per accedere all'area riservata Ente al sito www.mercury.it";
		String testo1 = "l'admin ha confermato la registrazione dell'ente" +en.getNomeEnte();
		String testo2 = " , puoi accedere al sito con le seguenti credenziali : ";
		String testo3 = " email : "+en.getEmailEnte()+ " password : "+ en.getPswEnte() ;
		String testo4 = "  . La avvertiamo che all'inserimento di eventi giudicati inopportuni ricevera' un email di cancellazione ";
		String testo5 = "evento ed un avvertimento. dopo 3 avvertimenti il suo ente non potra' piu accedere nella propria area riservata "  ;
		String testo = testo1+testo2+testo3+testo4+testo5 ;
	
		Properties p = System.getProperties();
			
		p.setProperty("mail.smtp.host", this.host);
		p.put("mail.smtp.host", this.host);
		p.put("mail.debug", "true");
		p.put("mail.smtp.auth", "true"); 
		     
		Session sessione = Session.getDefaultInstance(p, new SmtpAutenticazione(user, psw) );
		sessione.setPasswordAuthentication(new URLName("smtp", host, 25, "INBOX", user, psw), new PasswordAuthentication(user, psw));
		     
		MimeMessage mail = new MimeMessage(sessione);
		en.setStatus("attivo");
	    try {
	    	mail.setFrom(new InternetAddress(mittente));
	    	mail.addRecipients(Message.RecipientType.TO, dest);
	    	 	
	    	mail.setSubject(oggetto);
	    	mail.setText(testo);
	    	Transport tr = sessione.getTransport("smtp");
			tr.connect(host, user, psw);
	    	Transport.send(mail, mail.getAllRecipients());
	     }catch(Exception e) {
	    	e.printStackTrace();
	     }
	}

	public void setBanDB(Ente en) {
		Connection conn = DAO.getConnection();		
		int idEnte = en.getIdEnte();
		int nBan = en.getnBan();
		String query = "update mercury.ente set nBan="+nBan+" where idEnte="+idEnte+";";
		try {
			DAO.execute_Update(conn, query);	
		}catch(SQLException e) { 
			e.printStackTrace();
		}		
	}

	public void mailBanEvento(Ente en) {
		setBanDB(en);
		
		String dest = en.getEmailEnte();
		String oggetto = "mail Ban Evento";
		String testo1 = "l'admin ha individuato un evento non adatto ad essere inserito, l'evento è stato cancellato! "  ;
		String testo2 = "questo e' il "+en.getnBan()+"° avvertimento, ti ricordiamo che al 3° ban causato da un evento irregolare verra bannato il tuo ente " ;
		String testo = testo1+testo2;
		
		Properties p = System.getProperties();
			
		p.setProperty("mail.smtp.host", this.host);
		p.put("mail.smtp.host", this.host);
		p.put("mail.debug", "true");
		p.put("mail.smtp.auth", "true"); 
		     
		Session sessione = Session.getDefaultInstance(p, new SmtpAutenticazione(user, psw) );
		sessione.setPasswordAuthentication(new URLName("smtp", host, 25, "INBOX", user, psw), new PasswordAuthentication(user, psw));
		     
		MimeMessage mail = new MimeMessage(sessione);
		    
	    try {
	    	mail.setFrom(new InternetAddress(mittente));
	    	mail.addRecipients(Message.RecipientType.TO, dest);
	    	 	
	    	mail.setSubject(oggetto);
	    	mail.setText(testo);
	    	Transport tr = sessione.getTransport("smtp");
			tr.connect(host, user, psw);
	    	Transport.send(mail, mail.getAllRecipients());
	     }
	    catch(Exception e) {
	    	e.printStackTrace();
	     }
	}

	public void mailBanEnte(Ente en) {

		setStatusEnteNelDB(en.getIdEnte(), "bannato");
		String dest = en.getEmailEnte();
		String oggetto = "mail Ban Ente";
		String testo1 = "l'admin ha individuato un evento non adatto ad essere inserito, l'evento è stato cancellato! "  ;
		String testo2 = "questo e' il "+en.getnBan()+"° avvertimento, come ripetuto il tuo ente verra' eliminato " ;
		String testo = testo1+testo2;
		
		Properties p = System.getProperties();
			
		p.setProperty("mail.smtp.host", this.host);
		p.put("mail.smtp.host", this.host);
		p.put("mail.debug", "true");
		p.put("mail.smtp.auth", "true"); 
		     
		Session sessione = Session.getDefaultInstance(p, new SmtpAutenticazione(user, psw) );
		sessione.setPasswordAuthentication(new URLName("smtp", host, 25, "INBOX", user, psw), new PasswordAuthentication(user, psw));
		   
		MimeMessage mail = new MimeMessage(sessione);
		    
	     try {
	    	mail.setFrom(new InternetAddress(mittente));
	    	mail.addRecipients(Message.RecipientType.TO, dest);
	    	 	
	    	mail.setSubject(oggetto);
	    	mail.setText(testo);
	    	Transport tr = sessione.getTransport("smtp");
			tr.connect(host, user, psw);
	    	Transport.send(mail, mail.getAllRecipients());
	     }
	     catch(Exception e) {
	    	e.printStackTrace();
	     }
	}
	
	public void eventoChecksuDB(int idEvento){
		
		Connection conn = DAO.getConnection();		
		String query="update mercury.eventoPrevisto set checked= 1 where idEvento= "+idEvento  ;
		try {
			DAO.execute_Update(conn, query);	
		}
		catch(SQLException e) { 
			e.printStackTrace();
		}		
	}
	
	public void checkEvento(EventoPrevisto ep , boolean ok) { //ban evento!
		eventoChecksuDB(ep.getIdEvento());		
		if(!ok) { //se l'evento va bene niente, altrimenti entra nell'if
						
			int idEnte = ep.getIdEnte(); // mi serve per avere i dati di ente
			EnteImp x  = new EnteImp();
			Ente ente  = new Ente();
						
			ente = x.getEnteById(idEnte);			
			int numeroban = ente.getnBan();
			
			if(numeroban==2) {				//ente bannato per 3 ban su eventi
				ente.setStatus("bannato");
				setStatusEnteNelDB(ente.getIdEnte(),"bannato");
				mailBanEnte(ente);
			}
			else {
				x.eliminaEvento(ep);
				numeroban++;
				ente.setnBan(numeroban);
				mailBanEvento(ente);
			}	
		}
	}
	
	public Amministratore getAdminByEmail(String email) {
		
		Connection conn = DAO.getConnection();		
		String query="select * from mercury.amministratore a where a.emailAdmin = '"+email+"' ;" ;
		ResultSet rs;
		Amministratore am = new Amministratore();
		try {
			rs = DAO.execute_Query(conn, query );
			if(rs.first()==true) { 
				am.setEmailAdmin(rs.getString("emailAdmin"));
				am.setPswAdmin(rs.getString("pswAdmin"));
				am.setIdAdmin(rs.getInt("idAdmin"));
			}	
		}catch(SQLException e) { }
		
		return am;
	}
	
	

	public Amministratore getAdminById(int id) {

		Connection conn = DAO.getConnection();		
		String query="select * from mercury.amministratore a where a.idAdmin = "+ id +" ;" ;
		ResultSet rs;
		Amministratore am = new Amministratore();
		am.setIdAdmin(id);
		try {
			rs = DAO.execute_Query(conn, query );
			if(rs.first()==true) { 
				am.setEmailAdmin(rs.getString("emailAdmin"));
				am.setPswAdmin(rs.getString("pswAdmin"));
			}	
		}catch(SQLException e) { }

		return am;
	}


}




















/*Connection conn=null;

public AmministratoreImp() {
	super();
	conn=DAO.getConnection();
}

public int getId(String email, String password) throws SQLException{
    if(conn==null) conn=DAO.getConnection();
    Statement st = conn.createStatement();
    int id=0;

    ResultSet rs = st.executeQuery("select idAdmin from amministratore where emailAdmin='"+email+"' and pswAdmin='"+password+"'");

    if(!rs.first()) {
    	return -1;
    }
    id=Integer.parseInt(rs.getString("idAdmin"));
    return id;
}

public String getEmailAdmin(int idAdmin) throws SQLException{
    if(conn==null) conn=(Connection) DAO.getConnection();
    Statement st = conn.createStatement();
    String email = "";

    ResultSet rs = st.executeQuery("select emailAdmin from amministratore where idAdmin="+idAdmin);
    try {
    	rs.first();
    	email=rs.getString("email");
    }catch(SQLException e) {
    	return "";
    }
    return email;
}
 */


