<%@page import="com.mercury.model.dao.MercuryImp"%>
<%@page import="com.mercury.model.dao.EventoPrevistoImp"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.mercury.model.dao.TipoEventoImp"%>
<%@ page import="com.mercury.model.dao.ComuneImp"%>
<%@ page import="com.mercury.model.TipoEvento"%>
<%@ page import="com.mercury.model.Ente"%>
<%@ page import="com.mercury.model.EventoPrevisto"%>
<!DOCTYPE HTML>
<!--
	Twenty by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<sql:query var="rs" dataSource="jdbc/mercury">
	SELECT idRegione,nomeRegione from mercury.regione 
</sql:query>
<html>
<head>
<%
		EventoPrevistoImp ei = new EventoPrevistoImp();
		MercuryImp m = new MercuryImp();
		ComuneImp ci= new ComuneImp();
		ArrayList<EventoPrevisto> risultato = (ArrayList<EventoPrevisto>)session.getAttribute("risultato");

		if(risultato==null){
			risultato =  ei.getAllEventiPrevisti();
		}
		else{
	
			session.invalidate();
		}		
	
	%>


<title>Mercury Events</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
<link rel="stylesheet" href="..//css/main.css" />
<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->

<script src="http://code.jquery.com/jquery-1.11.1.js"
	type="text/javascript"></script>
<script type="text/javascript" src="..//..//js/newsletter.js"></script>
</head>
<body class="index">
	<div id="page-wrapper">

		<!-- Header -->
		<header id="header" class="alt">
			<h1 id="logo">Mercury Events</h1>
			<nav id="nav">
				<ul>
					<li class="current"><a href="HomePage.jsp">Welcome</a></li>
					<li class="submenu"><a href="#">Link Utili</a>
						<ul>
							<li><a href="HomePage.jsp">Home</a></li>
							<li><a href="Newsletter.jsp">Newsletter</a></li>
							<li><a href="RisultatoRicerca.jsp">Eventi</a></li>

						</ul></li>
					<li><a href="LoginEnte.jsp" class="button special">Area
							Riservata</a></li>
				</ul>
			</nav>
		</header>

		<!-- Banner -->
		<section id="banner">

			<!--
						".inner" is set up as an inline-block so it automatically expands
						in both directions to fit whatever's inside it. This means it won't
						automatically wrap lines, so be sure to use line breaks where
						appropriate (<br />).
					-->
			<div class="inner">

				<form action="../ServletRicerca" method="post">
					<h1>Cerca l'evento più vicino a te</h1>

					<div class="row 50%">

						<div class="12u">
							Seleziona regione: <select id="regioni" name="idRegioni">
								<option label="Selezionare" selected="selected" />
								<c:forEach var="r" items="${rs.rows }">
									<option value=<c:out value="${r.idRegione}" /> />
									<c:out value="${r.nomeRegione}" />
								</c:forEach>
							</select><br> Seleziona provincia: <select id="province"
								name="province">
								<option label="-----" selected="selected" />
							</select><br> Seleziona comune: <select id="comuni" name="idComune">
								<option label="-----" selected="selected" />
							</select>


						</div>
						<br> <br>
						<br>
						<center>
							Inserisci data: <input type="Date" name="data" />
						</center>
						<br>
					</div>

					<div>

						<input type="checkbox" name="tipo1" value="Concerto">Concerto
						<input type="checkbox" name="tipo2" value="Film">Film  
						<input type="checkbox" name="tipo3" value="Teatro">Teatro
						<input type="checkbox" name="tipo4" value="Mostra">Mostra
						<input type="checkbox" name="tipo5" value="Altro">Altro

					</div>
					<br>
					<div>
						<input type="submit" class="button special" value="cerca">
					</div>
			</div>
			<div class="row"></div>
			</form>
	</div>

	</section>

	<!-- Main -->
	<article id="main">
		<!-- Prima -->
		<section class="wrapper style3 container special">

			<header class="major">
				<h2>
					<strong>Risultato ricerca</strong>
				</h2>
			</header>

			<%
							
							for(int i = 0; i < risultato.size(); i++) { //lista degli eventi dell'ente
								if((i%3)==0) out.print("<div class='row'>"); 
								
								out.print("<div class='4u 12u(narrower)'>");	
								out.print("<section><header><h3>"+risultato.get(i).getNomeEvento()+"</h3></header><p>");
								out.print(risultato.get(i).getDescEvento()+"<br>");
								out.print("Data inizio: ");
								out.print(m.dateToString(risultato.get(i).getDataInizio())+"<br>");
								out.print("Data fine: ");
								out.print(m.dateToString(risultato.get(i).getDataFine())+"<br><br>");
								out.print(ci.getComuneById(risultato.get(i).getIdComune()).getNomeComune()+"<br>");
								out.print("</p></section>");
								
								out.print("<br></div>");
								
								if((i%3)==2) out.print("</div><br>");	
								
							}
							%>
		
	</article>


	<!-- Footer -->
	<footer id="footer">


		<ul class="copyright">
			<li>&copy; Sincrono</li>
			<li>Design: Mercury</a></li>
		</ul>

	</footer>

	</div>

	<!-- Scripts -->
	<script src="..//js/jquery.min.js"></script>
	<script src="..//js/jquery.dropotron.min.js"></script>
	<script src="..//js/jquery.scrolly.min.js"></script>
	<script src="..//js/jquery.scrollgress.min.js"></script>
	<script src="..//js/skel.min.js"></script>
	<script src="..//js/util.js"></script>
	<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
	<script src="..//js/main.js"></script>

</body>
</html>