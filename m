From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 10 Jul 2019 17:43:49 -0700
Subject: [PATCH rfc 4/6] nvme-cli: expand --device argument processing
In-Reply-To: <20190710232740.26734-5-jsmart2021@gmail.com>
References: <20190710232740.26734-1-jsmart2021@gmail.com>
 <20190710232740.26734-5-jsmart2021@gmail.com>
Message-ID: <f8576e9c-0a92-41fa-84c0-03a985b41253@grimberg.me>


> The connect-all --device argument was used to specify a specific device
> to be used as the discovery controller. The device is typically a
> long-lived discovery controller that posted a discovery event.
> No attempt was made to ensure the device is who it is supposed to be
> before using it.
> 
> Revised the code to use the other arguments in the connect-all request
> to validate that the device is the entity that was expected. If the
> device doesn't match, the cli will look for an existing matching device
> (will be a discovery controller due to nqn) with the same connect
> parameters and use it.  If one is not found on the system, a new
> discovery controller will be created for the connect-all request.

This can really use some splitting up, not easy to review this patch...
