jQuery(function($) {
	var cometd = $.cometd;
	// force long polling
	cometd.websocketEnabled = false;

	function _connectionEstablished() {
		$('#status').attr('class', 'label label-success').html(
				'Connection Established');
	}

	function _connectionBroken() {
		$('#status').attr('class', 'label label-danger').html(
				'Connection Broken');
	}

	function _connectionClosed() {
		$('#status').attr('class', 'label label-default').html(
				'Connection Closed');
	}

	// Function that manages the connection status with the Bayeux server
	var _connected = false;
	function _metaConnect(message) {
		if (cometd.isDisconnected()) {
			_connected = false;
			_connectionClosed();
			return;
		}

		var wasConnected = _connected;
		_connected = message.successful === true;
		if (!wasConnected && _connected) {
			_connectionEstablished();
		} else if (wasConnected && !_connected) {
			_connectionBroken();
		}
	}

	// Function invoked when first contacting the server and
	// when the server has lost the state of this client
	function _metaHandshake(handshake) {
		if (handshake.successful === true) {

			cometd.batch(function() {
				cometd.subscribe('/hello', function(message) {
					$('#output').append('<div>Server Says: '
							+ message.data.greeting + '</div>');
				});
				// Publish on a service channel since the message is for the
				// server only
				cometd.publish('/service/hello', {
					name : 'World'
				});
			});
		}
	}

	// Disconnect when the page unloads
	// unloader.addOnUnload(function()
	// {
	// cometd.disconnect(true);
	// });

	var cometURL = location.protocol + "//" + location.host
			+ config.contextPath + "/cometd";

	cometd.configure({
		url : cometURL,
		logLevel : 'debug'
	});

	cometd.addListener('/meta/handshake', _metaHandshake);
	cometd.addListener('/meta/connect', _metaConnect);

	cometd.handshake();

});

// Serialize form to object
(function($) {
	$.fn.serializeObject = function() {
		var o = {};
		var a = this.serializeArray();
		$.each(a, function() {
			if (o[this.name] !== undefined) {
				if (!o[this.name].push) {
					o[this.name] = [ o[this.name] ];
				}
				o[this.name].push(this.value || '');
			} else {
				o[this.name] = this.value || '';
			}
		});
		return o;
	};
})(jQuery);