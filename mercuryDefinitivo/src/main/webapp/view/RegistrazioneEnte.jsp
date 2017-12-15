<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML>
<!--
	Twenty by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>Registrati</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
<link rel="stylesheet" href="..//css/main.css" />
<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
<script type="text/javascript">
		
		function controlloCampi(form) {
			if(form.emailEnte.value=="") {
				alert("Inserire una email");
				return false;
			}
			
			else if(form.nomeEnte.value=="") {
				alert("Inserire un nome dell'ente");
				return false;
			}
			
			return true;
		}
		
		
		
		
		</script>
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
					<li><a>Area Riservata</a></li>
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


				<form action="../ServletReg" method="post"
					onsubmit="return controlloCampi(this);">
					<h1>Inserisci i tuoi dati</h1>


					<div class="row 50%">

						<div class="6u 12u(mobile)">
							<input type="text" name="emailEnte" placeholder="Inserisci Email">
							<br /> <input type="text" name="nomeEnte"
								placeholder="Inserisci Nome">

						</div>

						<div>
							<button class="button special">Registrati</button>

						</div>


					</div>
					<input type="hidden" value="registrazioneEnte" name="form" />
				</form>
				<br />
				<p>
					<%
										String msg = (String)session.getAttribute("giaEsiste"); 
										String msg2 = (String)session.getAttribute("inAttesa");
										if(msg != null) {
											out.print(msg);
											session.invalidate();
										}
								
										
										if(msg2 != null) {
											out.print(msg2);
											session.invalidate();
										}
											
									%>
				</p>
			</div>

		</section>




		<!-- Footer -->
		<footer id="footer">


			<ul class="copyright">
				<li>&copy; Sincrono</li>
				<li>Design: Mercury</li>
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