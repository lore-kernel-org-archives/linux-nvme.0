From: keith.busch@intel.com (Keith Busch)
Date: Wed, 31 May 2017 12:21:50 -0400
Subject: [PATCH] nvme/pci: Remove watchdog timer
In-Reply-To: <6eb8ac59-cb3f-d0eb-f6cb-fb232e30957c@grimberg.me>
References: <1495800988-27311-1-git-send-email-keith.busch@intel.com>
 <6eb8ac59-cb3f-d0eb-f6cb-fb232e30957c@grimberg.me>
Message-ID: <20170531162150.GE2845@localhost.localdomain>

On Tue, May 30, 2017@02:53:28PM +0300, Sagi Grimberg wrote:
> 
> >  static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >  {
> >  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> > @@ -957,6 +1001,17 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >  	struct nvme_dev *dev = nvmeq->dev;
> >  	struct request *abort_req;
> >  	struct nvme_command cmd;
> > +	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> > +
> > +	/*
> > +	 * Reset immediately if the controller is failed
> > +	 */
> > +	if (nvme_should_reset(dev, readl(dev->bar + NVME_REG_CSTS))) {
> > +		nvme_warn_reset(dev, csts);
> > +		nvme_dev_disable(dev, false);
> 
> Why the nvme_dev_disable here? its going to happen in reset_work..

Not if the reset work is already running or we are trying to remove the
device. We have to disable inline with the timeout work to make sure we
reclaim the timed out command.

Back in the day, we needed reset_work to do the disable when blk-mq's
timeout handler ran in soft-irq context, but that part of reset_work.
This patch should obviate the need for reset_work to ever disable the
controller.
