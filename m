From: ming.lei@redhat.com (Ming Lei)
Date: Fri, 2 Jun 2017 09:42:07 +0800
Subject: [PATCH V2] nvme: fix nvme_remove going to uninterruptible sleep
 for ever
In-Reply-To: <20170601193304.GA19500@dhcp-216.srv.tuxera.com>
References: <20170530071610.GA2679@hercules.tuxera.com>
 <4da7c939-1f54-80e5-48fc-06e58e14f018@grimberg.me>
 <20170530142346.GA39428@dhcp-216.srv.tuxera.com>
 <20170601114338.GA24855@lst.de>
 <20170601122818.GA18830@dhcp-216.srv.tuxera.com>
 <20170601123650.GA18883@dhcp-216.srv.tuxera.com>
 <20170601124631.GA28652@lst.de> <20170601145605.GA29369@ming.t460p>
 <20170601193304.GA19500@dhcp-216.srv.tuxera.com>
Message-ID: <20170602014207.GD30505@ming.t460p>

On Thu, Jun 01, 2017@10:33:04PM +0300, Rakesh Pandit wrote:
> On Thu, Jun 01, 2017@10:56:10PM +0800, Ming Lei wrote:
> > On Thu, Jun 01, 2017@02:46:32PM +0200, Christoph Hellwig wrote:
> > > On Thu, Jun 01, 2017@03:36:50PM +0300, Rakesh Pandit wrote:
> > > > Also Sagi pointed out that user space set_features ioctl if fired up
> > > > in a window after nvme_removal it can also result in this issue seems
> > > > to be correct.  I would prefer to keep this as it is and introduce
> > > > similar check higher up in nvme_ioctrl instead so that we don't send
> > > > sync commands if queues are killed already.
> > > > 
> > > > Would you prefer a patch ? Thanks,
> > > 
> > > If we want to kill everyone we probably should do it in ->queue_rq.
> > 
> > Looks ->queue_rq has done it already via checking nvmeq->cq_vector
> > 
> > > Or is the block layer blocking you somewhere else?
> > 
> > blk-mq doesn't handle dying in the I/O path.
> > 
> > Maybe it is similar with 806f026f9b901eaf1a(nvme: use blk_mq_start_hw_queues() in
> > nvme_kill_queues()), seems we need to do it for admin_q too.
> > 
> > Can the following change fix the issue?
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index e44326d5cf19..360758488124 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2438,6 +2438,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
> >  	struct nvme_ns *ns;
> >  
> >  	mutex_lock(&ctrl->namespaces_mutex);
> > +	blk_mq_start_hw_queues(ctrl->admin_q);
> >  	list_for_each_entry(ns, &ctrl->namespaces, list) {
> >  		/*
> >  		 * Revalidating a dead namespace sets capacity to 0. This will
> > 
> > 
> 
> Yes change fixes the issue.

Rakesh, thanks for your test, and I will prepare a formal one for
merging.

thanks,
Ming
