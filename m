From: anish.jhaveri@paviliondata.com (Anish Jhaveri)
Date: Tue, 12 Sep 2017 22:12:31 -0700
Subject: [PATCH 02/10] RDMA timeout triggers failover.
In-Reply-To: <970e4fc8-398a-c42f-6a1e-67a8955b371b@broadcom.com>
References: <20170912042226.bwdalyhvqd5xc24n@haynes>
 <970e4fc8-398a-c42f-6a1e-67a8955b371b@broadcom.com>
Message-ID: <20170913051230.vaq6drn4zjukyh7s@haynes>


On Tue, Sep 12, 2017@08:48:58AM -0700, James Smart wrote:
> I don't know this is a good idea - just because there's a controller reset
> we need to failover a path ? Also putting failover smarts in the transport
> doesn't seem like a great idea. Also, there's more than just an rdma
> transport....
> 
> -- james
>
Sorry for late reply. Configuring email client took a while.

Trigger failover from controller reset path can be removed, as
keep_alive timer failure would trigger failover.

What if target controller resets and comes back up within timeframe
that keep-alive timer gets serviced. This will lead to aborting of 
all IO request after multiple retries and retries completed within
same time frame before another keep_alive would get serviced. 
This will not trigger fail over. 
