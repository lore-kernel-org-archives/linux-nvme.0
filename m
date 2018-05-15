From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 15 May 2018 09:52:21 +0200
Subject: [PATCH 3/5] nvme: call nvmf_create_ctrl before checking for
 duplicate assignment
In-Reply-To: <20180515075055.GB23659@lst.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-4-jthumshirn@suse.de>
 <20180515075055.GB23659@lst.de>
Message-ID: <20180515075221.4ppaxdvbosy36ltk@linux-x5ow.site>

On Tue, May 15, 2018@09:50:55AM +0200, Christoph Hellwig wrote:
> On Tue, May 15, 2018@09:40:41AM +0200, Johannes Thumshirn wrote:
> > In nvmf_dev_write we did check if the /dev/nvme-fabrics device node's
> > private data is already set and then create a controller data
> > structure afterwards. The private data is protected by the
> > nvmf_dev_mutex, but there is no need to hold it while calling
> > nvmf_create_ctrl().
> > 
> > This also reduces the number of lockdep complaints in the 'nvme
> > connect' with fcloop scenario.
> 
> Something looks seriously fishy in fcloop.  How do we and up in
> a RCU critical section here?

__blk_mq_run_hw_queue() calls blk_mq_sched_dispatch_requests() with
the hctx_lock() a.k.a rcu_read_lock() held.

nvmf_connect_admin_queue() does I/O which causes the above to be called.

> In general it seems like fc loop needs to offload any I/O to a workqueue
> just like nvme-loop does, but even then I can't see how that is going to
> cause an issue in this area.

Hmm I'll be looking into it.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
