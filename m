From: parav@mellanox.com (Parav Pandit)
Date: Wed, 8 Feb 2017 18:06:52 +0000
Subject: [PATCH] nvmet: Avoid writing fabric_ops, queue pointers on every
 request.
In-Reply-To: <5bcb5982-36a6-67f5-8416-45e321235fa9@grimberg.me>
References: <1486507066-23168-1-git-send-email-parav@mellanox.com>
 <5bcb5982-36a6-67f5-8416-45e321235fa9@grimberg.me>
Message-ID: <VI1PR0502MB3008C2598C5492B2EB4D1E55D1420@VI1PR0502MB3008.eurprd05.prod.outlook.com>

Hi Sagi,

> -----Original Message-----
> From: Sagi Grimberg [mailto:sagi at grimberg.me]
> Sent: Wednesday, February 8, 2017 4:13 AM
> To: Parav Pandit <parav at mellanox.com>; hch at lst.de;
> james.smart at broadcom.com; linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] nvmet: Avoid writing fabric_ops, queue pointers on
> every request.
> 
> 
> 
> On 08/02/17 00:37, Parav Pandit wrote:
> > Fabric operations are constants of a registered transport. They don't
> > change with every target request that gets processed by the nvmet-core.
> > Therefore this patch moves fabrics_ops initialization out of the hot
> > request processing path for rdma and fc.
> > It continues to remain in same way for loop target through extra API.
> 
> Can't you add it to nvme_loop_init_iod()?
I didn't review that option when I first did it. I look it now and I believe it can be moved there.
I was under assumption that init_request() is done on every request processing and if that's the case we are not currently touching nvmet_loop_queue, so that minor overhead can be avoided by continue to do this in current location.

> 
> > Additionally this patch further avoid nvme cq and sq pointer
> > initialization for every request during every request processing for
> > rdma because nvme queue linking occurs during queue allocation time
> > for AQ and IOQ.
> 
> This breaks SRQ mode where every nvmet_rdma_cmd serves different
> queues in it's lifetime..

I fail to understand that.
nvmet_rdma_create_queue_ib() is call for as many QPs as we create; not based on number of SRQs we create.
nvmet_rdma_queue stores cq and sq.
So there are as many cq and sq on the fabric side as QPs for fabric_connect command is called.
queue is pulled out of cq context on which we received the command.
SRQ is just a place shared among this nvme queues to share the RQ buffer, right?
What did I miss?
