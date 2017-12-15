<%@page import="com.mercury.model.dao.MercuryImp"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
 	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%> 

<%@ page import="com.mercury.model.EventoPrevisto"%>



<!DOCTYPE HTML>
<!--
	Twenty by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
	
 		<sql:query var="concerto" dataSource="jdbc/mercury"> 
 		select eventoPrevisto.nomeEvento,eventoPrevisto.dataInizio, eventoPrevisto.dataFine, eventoPrevisto.descrizione, comune.nomeComune from mercury.eventoPrevisto, mercury.comune where eventoPrevisto.idComune = comune.idComune and eventoPrevisto.idTipoEvento = 1 order by eventoPrevisto.dataInizio limit 1
		</sql:query>
		<sql:query var="film" dataSource="jdbc/mercury">
		select eventoPrevisto.nomeEvento,eventoPrevisto.dataInizio, eventoPrevisto.dataFine, eventoPrevisto.descrizione, comune.nomeComune from mercury.eventoPrevisto, mercury.comune where eventoPrevisto.idComune = comune.idComune and eventoPrevisto.idTipoEvento = 2 order by eventoPrevisto.dataInizio limit 1
 		</sql:query>
 		<sql:query var="teatro" dataSource="jdbc/mercury">
 		select eventoPrevisto.nomeEvento,eventoPrevisto.dataInizio, eventoPrevisto.dataFine, eventoPrevisto.descrizione, comune.nomeComune from mercury.eventoPrevisto, mercury.comune where eventoPrevisto.idComune = comune.idComune and eventoPrevisto.idTipoEvento = 3 order by eventoPrevisto.dataInizio limit 1 		
 		</sql:query>
 		<sql:query var="mostra" dataSource="jdbc/mercury">
 		select eventoPrevisto.nomeEvento,eventoPrevisto.dataInizio, eventoPrevisto.dataFine, eventoPrevisto.descrizione, comune.nomeComune from mercury.eventoPrevisto, mercury.comune where eventoPrevisto.idComune = comune.idComune and eventoPrevisto.idTipoEvento = 4 order by eventoPrevisto.dataInizio limit 1
		</sql:query>


		<title>Mercury</title>
		
<%
		EventoPrevisto evMostra = 	new EventoPrevisto();
 		EventoPrevisto evFilm = 	new EventoPrevisto();
 		EventoPrevisto evTeatro =	new EventoPrevisto();
 		EventoPrevisto evConcerto = new EventoPrevisto();
 		MercuryImp m = new MercuryImp();
%>
		
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
							<li class="submenu">
								<a href="#">Link Utili</a>
								<ul>
									<li><a href="HomePage.jsp">Home</a></li>
									<li><a onclick="location.href='Newsletter.jsp'">Newsletter</a></li>
									<li><a onclick="location.href='RisultatoRicerca.jsp'">Eventi</a></li>
									<li class="submenu">
								</ul>
							</li>
							<li><a href="LoginEnte.jsp" class="button special">Area Riservata</a></li>
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

						<header>
							<h2>Mercury Events</h2>
						</header>
						<p><strong>Mercury!!</strong>
						<br />
						sito per ricercare eventi vicino 
						<br />
						casa tua.</p>
						<footer>
							<ul class="buttons vertical">
								<li><a href="Newsletter.jsp" class="button fit scrolly">Newsletter</a></li>
								<li><a href="RisultatoRicerca.jsp" class="button fit scrolly">Eventi</a></li>
							</ul>
						</footer>

					</div>

				</section>

			<!-- Main -->
				<article id="main">
					<!-- Prima -->
						<section class="wrapper style3 container special">

							<header class="major">
								<h2><strong>I prossimi eventi</strong></h2>
							</header>

							<div class="row">
								<div class="6u 12u(narrower)">

									<section>
										<a class="image featured"><img src="../images/teatro.jpg"/></a>
										<header>
											<h3><strong>Teatro</strong></h3>
										</header>
										<p>
											<c:forEach var="r" items="${teatro.rows }">
												<strong><c:out value="${r.nomeEvento}" /></strong><br>
												<c:out value="${r.descrizione}" /><br>
												<c:set value="${r.dataInizio}" var="teatroinizio"></c:set>
												<% out.print(m.stringToString((String) pageContext.getAttribute("teatroinizio"))); %> 
												<br>
												<c:set value="${r.dataFine}" var="teatrofine"></c:set>
												<% out.print(m.stringToString((String) pageContext.getAttribute("teatrofine"))); %>
												<br>
												<c:out value="${r.nomeComune}" /><br>
											</c:forEach>
										</p>
									</section>

								</div>
								<div class="6u 12u(narrower)">

									<section>
										<a class="image featured"><img src="../images/concerto.jpg " alt="" /></a>
										<header>
											<h3><strong>Concerto</strong></h3>
										</header>
										<p>								
											<c:forEach var="r" items="${concerto.rows }">
												<strong><c:out value="${r.nomeEvento}" /></strong><br>
												<c:out value="${r.descrizione}" /><br>
												<c:set value="${r.dataInizio}" var="concertoinizio"></c:set>
												<% out.print(m.stringToString((String) pageContext.getAttribute("concertoinizio"))); %> 
												<br>
												<c:set value="${r.dataFine}" var="concertofine"></c:set>
												<% out.print(m.stringToString((String) pageContext.getAttribute("concertofine"))); %>
												<br>
												<c:out value="${r.nomeComune}" /><br>
											</c:forEach>
										</p>
									</section>

								</div>
							</div>
							<div class="row">
								<div class="6u 12u(narrower)">

									<section>
										<a class="image featured"><img src="../images/film.jpg" alt="" /></a>
										<header>
											<h3><strong>Film</strong></h3>
										</header>
											<p>			
												<c:forEach var="r" items="${film.rows }">
													<strong><c:out value="${r.nomeEvento}" /></strong><br>
													<c:out value="${r.descrizione}" /><br>
													<c:set value="${r.dataInizio}" var="filminizio"></c:set>
													<% out.print(m.stringToString((String) pageContext.getAttribute("filminizio"))); %> 
													<br>
													<c:set value="${r.dataFine}" var="filmfine"></c:set>
													<% out.print(m.stringToString((String) pageContext.getAttribute("filmfine"))); %>
													<br>
													<c:out value="${r.nomeComune}" /><br>
												</c:forEach>
											</p>
									</section>

								</div>
								<div class="6u 12u(narrower)">

									<section>
										<a class="image featured"><img src="../images/mostra.jpg" alt="" /></a>
										<header>
											<h3><strong>Mostra</strong></h3>
										</header>
											<p>			
												<c:forEach var="r" items="${mostra.rows }">
													<strong><c:out value="${r.nomeEvento}" /></strong><br>
													<c:out value="${r.descrizione}" /><br>
													<c:set value="${r.dataInizio}" var="mostrainizio"></c:set>
													<% out.print(m.stringToString((String) pageContext.getAttribute("mostrainizio"))); %> 
													<br>
													<c:set value="${r.dataFine}" var="mostrafine"></c:set>
													<% out.print(m.stringToString((String) pageContext.getAttribute("mostrafine"))); %>
													<br>
													<c:out value="${r.nomeComune}" /><br>
												</c:forEach>
											</p>
										</section>
								</div>
							</div>

						</section>

				</article>

			<!-- CTA -->
				<section id="cta">

					<header> 
						
						<a href="#" style="border:none;"><img src="../images/placeholder.jpg" style="border-radius: 100em; width: 3.8em; height: 3.8em;"></a>
 						<a href="#" style="border:none;"><img src="../images/placeholder.jpg" style="border-radius: 100em; width: 3.8em;height: 3.8em;"></a>						
						<a href="https://www.linkedin.com/in/erica-di-vittorio-50bab4154/" style="border:none;"><img src="../images/erica.jpg" style="border-radius: 100em; width: 3.8em;height: 3.8em;"></a>
						<a href="https://www.linkedin.com/in/jessica-esposito-32239114b/" style="border:none;"><img src="../images/jessica.jpg" style="border-radius: 100em; width: 3.8em;height: 3.8em;"></a>
						<a href="https://www.linkedin.com/in/daniele-fuscaldo-513757140/" style="border:none;"><img src="../images/daniele.jpg" style="border-radius: 100em; width: 3.8em;height: 3.8em;"></a>
						<a href="https://www.linkedin.com/in/flavio-isidori/" style="border:none;"><img src="../images/flavio.jpg" style="border-radius: 100em; width: 3.8em;height: 3.8em;"></a>
						<a href="https://www.linkedin.com/in/giancarlo-molo-618035155/" style="border:none;"><img src="../images/giancarlo.jpg" style="border-radius: 100em; width: 3.8em;height: 3.8em;"></a>
						<a href="https://www.linkedin.com/in/alessio-monterosso-1b143a127/" style="border:none;"><img src="../images/alessio2.jpg" style="border-radius: 100em; width: 3.8em;height: 3.8em;"></a>
						<a href="#"style="border:none;"><img src="../images/placeholder.jpg" style="border-radius: 100em; width: 3.8em;height: 3.8em;"></a>
						<a href="https://www.linkedin.com/in/constantin-p%C3%AEslaru-b74668ba/" style="border:none; "><img src="../images/constantin.jpg" style="border-radius: 100em; width: 3.8em;height: 3.8em;"></a>
						<a href="https://www.linkedin.com/in/fabio-savelli-1178a6154/" style="border:none;"><img src="../images/fabio.jpg" style="border-radius: 100em; width: 3.8em;height: 3.8em;"></a>
						<a href="https://www.linkedin.com/in/dorjan-shurdhi-970151122/" style="border:none;"><img src="../images/dorjan.jpg" style="border-radius: 100em; width: 3.8em;height: 3.8em;"></a>
						<a href="https://www.linkedin.com/in/luca-sibilia-869128151/" style="border:none;"><img src="../images/luca.jpg" style="border-radius: 100em; width: 3.8em;height: 3.8em;"></a>
						

					</header> 

				</section>

			<!-- Footer -->
				<footer id="footer">
					<ul class="copyright">
						<li>&copy; Sincrono </li><li>Design: Mercury</a></li>
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