<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1" />

<title>Cometd Continuations</title>

<link rel="stylesheet" href="bootstrap.min.css" />

<%--
    The reason to use a JSP is that it is very easy to obtain server-side configuration
    information (such as the contextPath) and pass it to the JavaScript environment on the client.
    --%>
<script type="text/javascript">
	var config = {
		contextPath : '${pageContext.request.contextPath}'
	};
</script>


<script src="jquery/jquery-1.8.3.js"></script>
<script src="bootstrap.min.js"></script>
<script src="org/cometd.js"></script>
<script src="jquery/jquery.cometd.js"></script>
<script src="application.js"></script>

<style type="text/css">
#output div { border-bottom: 1px dotted #666; padding: 10px 0; }
#output div pre { margin: 0; }
</style>
</head>
<body>
	<header>
		<div class="navbar navbar-fixed-top">
			<a class="navbar-brand" href="#">Cometd Continuations</a>
			<p class="navbar-text">
				<span id="status" class="label"></span>
			</p>
		</div>
	</header>
	<div class="container" style="padding-top: 60px">

		<div class="row">
			<div id="output" class="col-lg-8"></div>
			<div id="toolbox" class="col-lg-4"
				style="position: fixed; overflow-y: auto; right: 0; bottom: 0; padding-top: 0px; top: 50px; max-height: 100%">

				<form action="/service/echo" class="form-horizontal" title="Echo">

					<fieldset>

						<!-- Form Name -->
						<legend>Echo Service</legend>


						<!-- Text input-->
						<div class="form-group">
							<label class="col-lg-3 control-label" for="echoMessage">Message</label>
							<div class="col-lg-9">
								<input id="echoMessage" name="message" placeholder=""
									class="input-lg" type="text">
							</div>
						</div>

						<div class="form-group">
							<div class="col-lg-9 col-lg-offset-3">
								<button type="submit" class="btn btn-default">Send</button>
							</div>
						</div>
					</fieldset>
				</form>

			</div>
		</div>
	</div>

	<!-- ui script -->
	<script type="text/javascript">
		jQuery(function($) {
			// Init forms
			$("#toolbox form").on(
					"submit",
					function() {
						var channel = /.+?\:\/\/.+?(\/.+?)(?:#|\?|$)/
								.exec(this.action)[1];
						console.log("channel " + channel);
						$.cometd.publish(channel, $(this).serializeObject());

						return false;
					});

			$.cometd.subscribe("/echo", function(message) {
				$('#output').append('<div>'
					+ "<pre>" + JSON.stringify(message.data) + "</pre>"
				+'</div>');
			});
		});

		
	</script>
</body>
</html>