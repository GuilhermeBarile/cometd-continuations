package com.github.guigouz.cometd;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.cometd.bayeux.server.BayeuxServer;
import org.cometd.bayeux.server.ServerSession;
import org.cometd.server.AbstractService;

public class HelloService extends AbstractService  {

	private Logger logger = Logger.getLogger(this.getClass());
	
	public HelloService(BayeuxServer bayeuxServer)  
    {
        super(bayeuxServer, "hello");                                
        addService("/service/hello", "processHello");               
    }

    public void processHello(ServerSession remote, Map<String, Object> data)
    {
    	logger.info("Processing hello request");
    	
    	String name = (String)data.get("name");

    	// Broadcast the request
    	Map<String, Object> output = new HashMap<String, Object>();
        output.put("greeting", "Hello from " + remote.getUserAgent());
    	getBayeux().getChannel("/hello").publish(getLocalSession(), output, null);
    	
    	// Reply to the current client
        output = new HashMap<String, Object>();
        output.put("greeting", "Hello, " + name);
        remote.deliver(getServerSession(), "/hello", output, null);        
    }
}
