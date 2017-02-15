From: parav@mellanox.com (Parav Pandit)
Date: Wed, 15 Feb 2017 16:54:44 +0000
Subject: [PATCH] nvmet: Avoid writing fabric_ops, queue pointers on	every
 request.
In-Reply-To: <20170215163422.GA28506@lst.de>
References: <1486507066-23168-1-git-send-email-parav@mellanox.com>
 <5bcb5982-36a6-67f5-8416-45e321235fa9@grimberg.me>
 <VI1PR0502MB3008C2598C5492B2EB4D1E55D1420@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <700fde5d-3b84-2279-4176-c871364d4b97@grimberg.me>
 <VI1PR0502MB3008753C22DDAD6B5C20FC57D1590@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <fbe16be7-ed21-d231-471e-cdffe346264b@grimberg.me>
 <20170215161523.GA27837@lst.de>
 <c76d9dcf-f5d4-0133-ff22-e8bb7f672680@grimberg.me>
 <VI1PR0502MB3008DEDC435576804B935D98D15B0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <20170215163422.GA28506@lst.de>
Message-ID: <VI1PR0502MB3008E499C4E3012CA0DAE5E4D15B0@VI1PR0502MB3008.eurprd05.prod.outlook.com>



> -----Original Message-----
> From: hch at lst.de [mailto:hch at lst.de]
> Sent: Wednesday, February 15, 2017 10:34 AM
> To: Parav Pandit <parav at mellanox.com>
> Cc: Sagi Grimberg <sagi at grimberg.me>; hch at lst.de;
> james.smart at broadcom.com; linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] nvmet: Avoid writing fabric_ops, queue pointers on
> every request.
> 
> On Wed, Feb 15, 2017@04:31:00PM +0000, Parav Pandit wrote:
> > How about
> > nvmet_ops_init()
> > nvmet_link_queues()
> 
> Just do the one respective two trivial assignment inline in the callers.  That
> actually leads to smaller source and binary code.

o.k.
