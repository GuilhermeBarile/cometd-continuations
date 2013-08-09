Cometd Continuations Example
============================

This is a working cometd example tested on Tomcat v6.0. It 
uses the Jetty Continuations filter, so it doesn´t require 
the Advanced NIO Connector or a servlet 3.0 environment. 

Dependencies are listed on the pom.xml file.

References
----------

* Jetty Continuations http://wiki.eclipse.org/Jetty/Feature/Continuations#Jetty_6_Continuations
	> Continuations Overview
* CometD 2 Configuration in Servlet Containers http://cometd.org/documentation/2.x/howtos/servlet-containers
	> Details the ContinuationFilter used on this project 
* Service examples were taken from the Cometd Tutorials http://docs.cometd.org/tutorials/

Other approaches
----------------

Most of the documentation about realtime websockets (and 
fallbacks) depend on a servlet-3.0 context.

WebSockets with Embedding Jetty http://angelozerr.wordpress.com/2011/07/26/websockets_jetty_step4/ 
has a working implementation with some caveats.