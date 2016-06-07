From: keith.busch@intel.com (Keith Busch)
Date: Tue, 7 Jun 2016 14:55:45 -0400
Subject: Question on Patch - NVMe: Shutdown controller only for power-off
In-Reply-To: <BL2PR04MB163077C4D3CD0E5075DF8E3925D0@BL2PR04MB163.namprd04.prod.outlook.com>
References: <BL2PR04MB163B82FED551339CEDC2116925D0@BL2PR04MB163.namprd04.prod.outlook.com>
 <20160607175840.GC28414@localhost.localdomain>
 <BL2PR04MB163077C4D3CD0E5075DF8E3925D0@BL2PR04MB163.namprd04.prod.outlook.com>
Message-ID: <20160607185545.GF28414@localhost.localdomain>

On Tue, Jun 07, 2016@06:42:00PM +0000, Jeff Lien wrote:
> Keith,
> The issue isn't that the fw activate requires a shutdown; it's more that the HGST controller takes much longer to execute the nvme_disable_ctrl if it hasn't been shutdown first.  This issue caused us to add a longer delay before the first read of the csts reg in nvme_wait_ready.
> 
> Rather than adding a delay in nvme_disable_controller, I think the better option would be to shutdown the controller.  The comment says "If we're called to reset a live controller first shut it down" so in this case I think the shutdown parm should be true.

I'll change the comment to say "disable" instead of "shut down". We
want to reserve controller shutdown to power loss scenarios per spec
recommendations, which this is not. A controller reset is generally much
faster than a shutdown, which is why we don't toggle CC.SHN here.
