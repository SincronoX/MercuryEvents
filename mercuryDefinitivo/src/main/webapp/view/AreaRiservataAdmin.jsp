<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.io.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="com.mercury.model.EventoPrevisto"%>
<%@ page import="com.mercury.model.Amministratore"%>
<%@ page import="com.mercury.model.Ente"%>
<%@ page import="com.mercury.model.dao.EnteImp"%>
<%@ page import="com.mercury.model.dao.MercuryImp"%>
<!DOCTYPE HTML>
<!--
	Twenty by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>Mercury Events</title>

<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<META Http-Equiv="Expires" Content="0">

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
<link rel="stylesheet" href="..//css/main.css" />
<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
</head>
<body class="index">

	<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	if (session.getAttribute("admin") == null){
		response.sendRedirect("LoginAdmin.jsp");
		return;
	}
	%>

	<%
		MercuryImp m = new MercuryImp();
		EnteImp ei = new EnteImp();

		ArrayList<EventoPrevisto> eventiNotCheck = m.getEventiNotCheck();

		ArrayList<Ente> entiInAttesa = ei.getEntiInAttesa();

		Amministratore a = (Amministratore) session.getAttribute("admin");
	%>




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
					<h4>
						Benvenuto, <% out.print(a.getEmailAdmin()); %>
					</h4>

					<form action="../ServletLogAdmin" method="post">
						<input type="submit" name="log" value="Logout"> <input
							type="hidden" name="form" value="Logout">
					</form>
					<br>

					<h3>
						<strong>Accetta Nuovo Evento</strong>
					</h3>
					<hr>
					<%
						for (int i = 0; i < eventiNotCheck.size(); i++) { //lista degli eventi da checkare
							if ((i % 3) == 0)
								out.print("<div class='row'>");
							out.print("<div class='4u 12u(narrower)'>");
							out.print("<p>");
							out.print("<form action='../ServletAdmin' method='post'>");
							out.print("<section><header><h3>" + eventiNotCheck.get(i).getNomeEvento() + "</h3></header><p>");
							out.print(eventiNotCheck.get(i).getDescEvento());
							out.print("<br />");
							out.print(m.stringToString(m.dateToString(eventiNotCheck.get(i).getDataInizio())));
							out.print("<br />");
							out.print(m.stringToString(m.dateToString(eventiNotCheck.get(i).getDataFine())));
							out.print("<br />");
							session.setAttribute("evento" + i, eventiNotCheck.get(i));
							session.setAttribute("check", eventiNotCheck.get(i).isCheck());
							out.print("</p><footer>");
							out.print(
									"<ul class='buttons'><li><input type='submit' class='button small1' value='Accetta' name ='checkOK'></li>");
							out.print("<li><input type='submit' class='button small2' value='Ban' name='checkOK'></li>");
							out.print("<input  type='hidden' name='pagina' value='eventi'>");
							out.print("<input  type='hidden' name='ammin' value='"+a.getEmailAdmin()+"'>");
							out.print("<input  type='hidden' name='numEv' value='" + i + "'></footer></form>");

							out.print("</section>");
							out.print("<br></div>");
							if ((i % 3) == 2 || i == eventiNotCheck.size() - 1)
								out.print("</div><br>");

						}
					%>


				</section>
			</div>


		</section>
	</div>
	<br>


	<div class="inner">
		<article id="main">

			<section class="wrapper style3 container special">

				<h3>
					<strong>Accetta Nuovo ente</strong>
				</h3>
				<br>

				<%
					for (int i = 0; i < entiInAttesa.size(); i++) {
						if ((i % 3) == 0)
							out.print("<div class='row'>");
						out.print("<div class='4u 12u(narrower)'>");
						out.print("<p>");
						out.print("<form action='../ServletAdmin' method='post'>");
						out.print("<section><header><h3>" + entiInAttesa.get(i).getNomeEnte() + "</h3></header><p>");

						out.print(entiInAttesa.get(i).getEmailEnte());
						out.print("<br>");

						session.setAttribute("enteInAttesa" + i, entiInAttesa.get(i));
						out.print("</p><footer>");
						out.print("<ul class='buttons'><li><input type='submit' class='button small1' value='Accetta' name='enteOK'>");
						out.print("<li><input type='submit' class='button small2' value='Rifiuta' name='enteOK'");
						out.print("<input type='hidden' name='eia' value='enti'><input  type='hidden' name='pagina' value='enti'>");
						out.print("<input  type='hidden' name='entInAtt' value='" + i + "'>");
						out.print("<input  type='hidden' name='ammin' value='"+a.getEmailAdmin()+"'>");
						out.print("</footer></form>");
						out.print("</section>");
						out.print("<br></div>");
						if ((i % 3) == 2 || i == entiInAttesa.size() - 1)
							out.print("</div><br>");
					}
				%>


			</section>
		</article>
	</div>



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