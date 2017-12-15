<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ page import="com.mercury.model.dao.MercuryImp"%>
<%@ page import="com.mercury.model.Ente"%>
<%@ page import="com.mercury.model.dao.EnteImp"%>
<%@ page import="com.mercury.model.EventoPrevisto"%>
<!DOCTYPE HTML>

<!--
	Twenty by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>

<% 
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	if (session.getAttribute("ente") == null){
		response.sendRedirect("LoginEnte.jsp");
		return;
	}
	MercuryImp m = new MercuryImp(); 
	ArrayList<EventoPrevisto> myEvents = new ArrayList<EventoPrevisto>();
	Ente e = (Ente)session.getAttribute("ente"); 
	String mailEnte = (String)e.getEmailEnte();
	EnteImp ei = new EnteImp();
	myEvents = ei.getEventiByEnte(mailEnte);
%>

<title>Mercury Events</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
<link rel="stylesheet" href="..//css/main.css" />
<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
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
					<li><a href="#" class="button special">Area Riservata</a></li>
				</ul>
			</nav>
		</header>

		<!-- Banner -->
		<section id="banner">

			<div class="inner">

				<section class="wrapper style1 container special">

					<h3>
						<strong>Gestisci i tuoi eventi</strong>
					</h3>
					<hr>

					<br>
					<%
							for(int i = 0; i < myEvents.size(); i++) { //lista degli eventi dell'ente
								if((i%3)==0) out.print("<div class='row'>"); 
								out.print("<div class='4u 12u(narrower)'>");
								out.print("<form action='../ServletEnte' method='post'>");	
								out.print("<section><header><h3>"+myEvents.get(i).getNomeEvento()+"</h3></header><p>");
								out.print(myEvents.get(i).getDescEvento()+"<br>");
								out.print("Data inizio: ");
								out.print(m.stringToString(m.dateToString(myEvents.get(i).getDataInizio()))+"<br>");
								out.print("Data fine: ");
								out.print(m.stringToString(m.dateToString(myEvents.get(i).getDataFine()))+"<br>");
								out.print("</p><footer>");
								out.print("<ul class='buttons'><li><input type='submit' value='Modifica' name='modEv' class='button small1'></li>");
								out.print("<li><input type='submit' value='Cancella' name='modEv' class='button small2'></li></ul>");
								out.print("</footer></section>");
								
								session.setAttribute("eventi" + i, myEvents.get(i));
								out.print("<input  type='hidden' name='numEv' value='"+i+"'>");
								out.print("<input type='hidden' value='"+e.getEmailEnte()+"' name='email'>");
								out.print("</form>");
								out.print("<br></div>");
								if((i%3)==2 || i==myEvents.size()-1) out.print("</div><br>");	
								
							}
							%>
					<br> <br>
					<ul class="buttons vertical" style="float: right; margin-left:0.5em; color: #d96c68;">
						<form action="../ServletLogEnte" method="post">
							<input type="submit" value="Logout" name="log" class="">
						</form>
					</ul>
					<ul class="buttons vertical" style="float: right;">
						<form action="../ServletEnte" method="post">
							<input type="hidden" value="<% out.print(e.getEmailEnte()); %>" name="email"> 
							<input type="submit" value="Aggiungi" name="modEv" class="">
						</form>
					</ul>					
				</section>

			</div>

		</section>
		<br>

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