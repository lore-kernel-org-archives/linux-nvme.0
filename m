From: parav@mellanox.com (Parav Pandit)
Date: Wed, 1 Mar 2017 15:11:37 +0000
Subject: [PATCH] nvme-rdma: nvme-fc: Fix avoid tag set initialization
 twice.
In-Reply-To: <20170301145918.GA12248@lst.de>
References: <1488333999-30412-1-git-send-email-parav@mellanox.com>
 <20170301145918.GA12248@lst.de>
Message-ID: <VI1PR0502MB3008DDF70AD2CB310B194786D1290@VI1PR0502MB3008.eurprd05.prod.outlook.com>

Hi Christoph,

I tried for-linus branch of Jens. That seems to work without this fix.
So I will resend the patch as optimization instead of as fix similar to PCIe?

Parav

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch at lst.de]
> Sent: Wednesday, March 1, 2017 8:59 AM
> To: Parav Pandit <parav at mellanox.com>
> Cc: james.smart at broadcom.com; keith.busch at intel.com; axboe at fb.com;
> hch at lst.de; sagi at grimberg.me; linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] nvme-rdma: nvme-fc: Fix avoid tag set initialization
> twice.
> 
> On Tue, Feb 28, 2017@08:06:39PM -0600, Parav Pandit wrote:
> > When BLK_MQ_F_NO_SCHED is not set for a tagset of a request queue, it
> > tries to initialize the queue twice where blk_mq_alloc_rq_map() gets
> > invoked twice as part of blk_mq_alloc_tag_set() and
> > blk_mq_init_queue() through elevator init path.
> 
> Maybe we'll need to fix this in the block core instead of working around it?
