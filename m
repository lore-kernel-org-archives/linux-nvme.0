From: parav@mellanox.com (Parav Pandit)
Date: Wed, 8 Feb 2017 15:19:20 +0000
Subject: [PATCHv1] nvmet-rdma: Support 16K worth of inline data for	write
 commands
In-Reply-To: <20170208083110.GC7629@lst.de>
References: <1486507882-23688-1-git-send-email-parav@mellanox.com>
 <20170208083110.GC7629@lst.de>
Message-ID: <VI1PR0502MB30087DD343977DA57187E3E3D1420@VI1PR0502MB3008.eurprd05.prod.outlook.com>

Hi Christoph,

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch at lst.de]
> Sent: Wednesday, February 8, 2017 2:31 AM
> To: Parav Pandit <parav at mellanox.com>
> Cc: hch at lst.de; sagi at grimberg.me; james.smart at broadcom.com; linux-
> nvme at lists.infradead.org
> Subject: Re: [PATCHv1] nvmet-rdma: Support 16K worth of inline data for
> write commands
> 
> Hi Parav,
> 
> I like this in principle, but I'm really worried about the resource consumption
> of just enabling this by default.  I think we need a tunable in configfs for the
> max inline data, and for the queue depth at least, and maybe reduce the
> queue depth a bit by default to compensate for the much higher per-queue
> memory usage.

I agree with it. I tried that but it wasn't straightforward because it has to come all the way from rdma cm handler level.
While discussing with Max and Idan also we talked that we want to make it configfs for each nvmet_host.
So this is starting point. Let users use it for a while and in near future, we will make it a configfs per host or subsystem parameter as incremental patch.
