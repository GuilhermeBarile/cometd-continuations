package com.github.guigouz.cometd;

import java.util.Map;

import org.apache.log4j.Logger;
import org.cometd.bayeux.server.BayeuxServer;
import org.cometd.bayeux.server.ServerSession;
import org.cometd.server.AbstractService;

public class EchoService extends AbstractService  {
	private Logger logger = Logger.getLogger(this.getClass());
	
	public EchoService(BayeuxServer bayeuxServer)  
    {
        super(bayeuxServer, "echo");                                        
        addService("/service/echo", "processEcho");                                     
    }

    public void processEcho(ServerSession remote, Map<String, Object> data)
    {
    	logger.info("Processing echo request");
        remote.deliver(getServerSession(), "/echo", data, null);               
    }
}
