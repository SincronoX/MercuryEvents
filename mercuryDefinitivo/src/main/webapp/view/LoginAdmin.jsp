<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<title>Mercury Events</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="..//css/main.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<%
		if (session.getAttribute("admin") != null){
			response.sendRedirect("AreaRiservataAdmin.jsp");
			return;
		}
		%>
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
									<li><a href="Newsletter.jsp">Newsletter</a></li>
									<li><a href="RisultatoRicerca.jsp">Eventi</a></li>
									
								</ul>
							</li>
							<li><a href="LoginAdmin.jsp" class="button special">Area Riservata</a></li>
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

									<form action="../ServletLogAdmin" method="post">
										<h1>Inserisci i tuoi dati </h1>

										<div class="row 50%">
												
											<div class="6u 12u(mobile)">
												<input type="text" placeholder="Inserisci Email" name="emailAdmin">
												<br>
												<input type="Password" placeholder="Inserisci Password" name="pswAdmin">

												<br>
											</div>
											
												<div>
													<button class="button special1" name="form" value="LoginAdmin">Login</button>
												</div>

											
										</div>
									</form>
								

							</div>

				</section>



			
			<!-- Footer -->
				<footer id="footer">


					<ul class="copyright">
						<li>&copy; Sincrono </li><li>Design: Mercury</a></li>
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