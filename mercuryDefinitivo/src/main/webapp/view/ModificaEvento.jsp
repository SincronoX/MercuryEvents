<%@page import="com.mercury.model.dao.MercuryImp"%>
<%@page import="com.mercury.model.EventoPrevisto"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.mercury.model.dao.TipoEventoImp"%>
<%@ page import="com.mercury.model.dao.ComuneImp"%>
<%@ page import="com.mercury.model.TipoEvento"%>
<%@ page import="com.mercury.model.Ente"%>

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
<title>Mercury Events</title>

<script src="http://code.jquery.com/jquery-1.11.1.js"
	type="text/javascript"></script>
<script type="text/javascript" src="./js/controlloDate.js"></script>
<script type="text/javascript" src="../js/newsletter.js"></script>

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
<link rel="stylesheet" href="../css/main.css" />
<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->

</head>
<body class="contact">
	<div id="page-wrapper">

		<!-- Header -->
		<header id="header">
			<h1 id="logo">
				<a href="view/HomePage.jsp">Mercury Events</a>
			</h1>
			<nav id="nav">
				<ul>
					<li class="current"><a href="view/HomePage.jsp">Welcome</a></li>
					<li class="submenu"><a href="#">Link Utili</a>
						<ul>
							<li><a href="view/HomePage.jsp">Home</a></li>
							<li><a onclick="location.href='Newsletter.jsp'">Newsletter</a></li>
							<li><a onclick="location.href='RisultatoRicerca.jsp'">Eventi</a></li>
						</ul></li>
					<li><a href="javascript:history.back()" class="button special">Area Riservata</a></li>
				</ul>
			</nav>
		</header>

		<!-- Main -->
		<article id="main">

			<header class="special container">
				<span class="icon fa-laptop"></span>
				<h2>
					<%
							ComuneImp ci = new ComuneImp();	
							MercuryImp m = new MercuryImp();
							TipoEventoImp ei = new TipoEventoImp();
							
							Ente e = (Ente)session.getAttribute("ente");
							EventoPrevisto ep = (EventoPrevisto)session.getAttribute("evPrev");
							ArrayList<TipoEvento> catEvento =  ei.getEventoCatAll();
							
							ArrayList<String> luogo = ci.getInfoByComune(ep.getIdComune());
							session.setAttribute("eventoMod", ep);
							
							out.print(e.getNomeEnte()+" ");
						%>
					modifica qui il tuo evento!
				</h2>

			</header>

			<!-- One -->
			<section class="wrapper style4 special container 55%">

				<!-- Content -->
				<div class="content">
					<form action="../ServletEnte" method="post"
						onsubmit="return controlloBello(this);">
						<div class="row 50%">
							<div class="6u 12u(mobile)">
								<input type="text" name="nomeEvento" placeholder="Nome Evento"
									value="<%out.print(ep.getNomeEvento());%>">
							</div>
						</div>
						<div class="row 50%">
							<div class="12u">
								<textarea type="message" name="descEvento"
									placeholder="Descrizione" rows="7"><%out.print(ep.getDescEvento());%>
								</textarea>
							</div>
						</div>
						<br>
						<div class="10u">
							Seleziona regione: <select id="regioni" name="regioni">
								<option label="<% out.print(luogo.get(1)); %>"
									value="<% out.print(luogo.get(0)); %>" selected="selected" />
								<c:forEach var="r" items="${rs.rows }">
									<option value=<c:out value="${r.idRegione}" /> />
									<c:out value="${r.nomeRegione}" />
								</c:forEach>
							</select><br> Seleziona provincia: <select id="province"
								name="province">
								<option label="<% out.print(luogo.get(3)); %>"
									value="<% out.print(luogo.get(2)); %>" selected="selected" />
							</select><br> Seleziona comune: <select id="comuni" name="idComune">
								<option label="<% out.print(luogo.get(5)); %>"
									value="<% out.print(luogo.get(4)); %>" selected="selected" />
							</select><br>
							<br>
							<br> <span style="margin-right: 2em">Data inizio:<input
								type="Date" name="dataInizio"
								value="<%out.print(m.dateToString2(ep.getDataInizio()));%>" /></span>
							Data fine: <input type="Date" name="dataFine"
								value="<%out.print(m.dateToString2(ep.getDataFine()));%>" /><br>
							</span><br>
						</div>
				</div>
				<br>

				<div>
					Selezionare il tipo di evento: <select name='tipoEvento'>
						<% 
						for(int i = 0; i< catEvento.size(); i++){
							String elemento = "<option value='"+catEvento.get(i).getIdTipoEvento()+"'";
							if(i==ep.getIdTipoEvento()-1){
								elemento += "selected='selected'";
							}
							elemento += ">"+catEvento.get(i).getCatEvento()+"</option>";
							out.print(elemento);
						}%>
					</select>
				</div>
				<br>


				<dir>
					<input type="hidden" name="modEv" value="Invia">
					<input type="submit" value="modifica">
					<br>
					<br>
				</dir>
	</div>
	<input type="hidden" name="insEv"
		value="<% out.print(e.getEmailEnte()); %>">

	</form>
	</div>

	</section>

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
	<script src="../js/jquery.min.js"></script>
	<script src="../js/jquery.dropotron.min.js"></script>
	<script src="../js/jquery.scrolly.min.js"></script>
	<script src="../js/jquery.scrollgress.min.js"></script>
	<script src="../js/skel.min.js"></script>
	<script src="../js/util.js"></script>
	<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
	<script src="../js/main.js"></script>

</body>
</html>