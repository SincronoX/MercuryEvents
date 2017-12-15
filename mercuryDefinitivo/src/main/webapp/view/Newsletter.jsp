<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.mercury.model.dao.TipoEventoImp"%>
<%@ page import="com.mercury.model.TipoEvento"%>
<%@ page import="com.mercury.model.Ente"%>

<!DOCTYPE HTML>
<!--
	Twenty by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<sql:query var="rs" dataSource="jdbc/mercury">
	SELECT idRegione,nomeRegione from mercury.regione 
</sql:query>
<head>
<title>Mercury Events</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
<link rel="stylesheet" href="..//css/main.css" />
<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->

<script type="text/javascript">
			
		function controlloNewsLetter(form){
			
			if(form.email.value==""){
				alert("Inserisci email!");
				return false;
			}
			if(form.cadenza.value=="nonselezionato"){
				alert("Inserisci la cadenza!");
				return false;
			}
			if(form.idComune.value=="nonselezionato"){
				alert("Inserisci il comune!");
				return false;
			}
			if(!(form.tipo1.checked || form.tipo2.checked || form.tipo3.checked || form.tipo4.checked || form.tipo5.checked)){
				alert("Seleziona almeno una categoria!");
				return false;
			}
			return true;
		}
		
		</script>
</head>
<body class="contact">
	<div id="page-wrapper">

		<!-- Header -->
		<header id="header">
			<h1 id="logo">
				<a href="HomePage.jsp">Mercury Events</a>
			</h1>
			<nav id="nav">
				<ul>
					<li class="current"><a href="HomePage.jsp">Welcome</a></li>
					<li class="submenu"><a href="#">Link Utili</a>
						<ul>
							<li><a href="HomePage.jsp">Home</a></li>
							<li><a onclick="location.href='Newsletter.jsp'">Newsletter</a></li>
							<li><a onclick="location.href='RisultatoRicerca.jsp'">Eventi</a></li>
						</ul></li>
					<li><a href="LoginEnte.jsp" class="button special">Area
							Riservata</a></li>
				</ul>
			</nav>
		</header>

		<!-- Main -->
		<article id="main">

			<header class="special container">
				<span class="icon fa-envelope"></span>
				<h2>Iscriviti alla nostra Newsletter</h2>
				<p>Così rimarrai sempre aggiornato.</p>
				<%
						String msg = (String)session.getAttribute("messaggio");
						if(msg!=null){
							out.print("<br>"+msg);
							session.invalidate();
						}
						%>

			</header>

			<!-- One -->
			<section class="wrapper style4 special container 75%">

				<!-- Content -->
				<div class="content">
					<form action="../ServletMail" method="post"
						onsubmit="return controlloNewsLetter(this);">
						<div class="row 50%">
							<div class="12u">
								<input type="text" name="email" placeholder="Email" />
							</div>
						</div>
						<br> <br>
						<div>
							<input type="checkbox" name="tipo1" value="3">Teatro <input
								type="checkbox" name="tipo2" value="1">Concerto <input
								type="checkbox" name="tipo3" value="2">Film <input
								type="checkbox" name="tipo4" value="4">Mostra <input
								type="checkbox" name="tipo5" value="5">Altro
						</div>
						<br> <br>
						<div>
							Seleziona regione: <select id="regioni" name="regioni">
								<option label="Selezionare" selected="selected" />
								<c:forEach var="r" items="${rs.rows }">
									<option value=<c:out value="${r.idRegione}" /> />
									<c:out value="${r.nomeRegione}" />
								</c:forEach>
							</select> <br> <br> Seleziona provincia: <select id="province"
								name="province">
								<option label="-----" selected="selected" />
							</select> <br> <br> Seleziona comune: <select id="comuni"
								name="idComune">
								<option value="nonselezionato" label="-----" selected="selected" />
							</select> <br> <br> Seleziona Cadenza Email: <select type="data"
								name='cadenza' placeholder="Seleziona cadenza">
								<option value="nonselezionato">------</option>
								<option value="1">Giornaliera</option>
								<option value="2">Settimanale</option>
								<option value="3">Mensile</option>
							</select>
						</div>
						<br>
						<button href="#" class="button special">Iscriviti</button>
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
	<script src="..//js/jquery.min.js"></script>
	<script src="..//js/jquery.dropotron.min.js"></script>
	<script src="..//js/jquery.scrolly.min.js"></script>
	<script src="..//js/jquery.scrollgress.min.js"></script>
	<script src="..//js/skel.min.js"></script>
	<script src="..//js/util.js"></script>
	<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
	<script src="..//js/main.js"></script>
	<script type="text/javascript" src="..//..//js/newsletter.js"></script>

</body>
</html>