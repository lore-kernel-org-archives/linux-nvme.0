From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 28 Jun 2018 13:54:38 -0600
Subject: [PATCH v2 1/1] nvme: Ensure forward progress during Admin passthru
In-Reply-To: <20180628191947.GA2192@sbauer-Z170X-UD5>
References: <20180622195914.18575-1-scott.bauer@intel.com>
 <20180628171007.2423-1-scott.bauer@intel.com>
 <20180628191631.GB12970@localhost.localdomain>
 <20180628191947.GA2192@sbauer-Z170X-UD5>
Message-ID: <20180628195438.GC12970@localhost.localdomain>

On Thu, Jun 28, 2018@01:19:48PM -0600, Scott Bauer wrote:
> On Thu, Jun 28, 2018@01:16:32PM -0600, Keith Busch wrote:
> > On Thu, Jun 28, 2018@11:10:07AM -0600, Scott Bauer wrote:
> > >  static void nvme_put_subsystem(struct nvme_subsystem *subsys);
> > > +static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> > > +					   unsigned nsid);
> > > +
> > > +static void nvme_set_queue_dying(struct nvme_ns *ns)
> > > +{
> > > +	blk_set_queue_dying(ns->queue);
> > > +	/* Forcibly unquiesce queues to avoid blocking dispatch */
> > > +	blk_mq_unquiesce_queue(ns->queue);
> > > +}
> > 
> > I think we should actually do everything that the dead namespace does,
> > including revalidating the capacity to 0, just in case a buffered writer
> > is preventing the removal from completing. Here's an update on top of
> > your patch.
> > 
> 
> >  {
> > +	/*
> > +	 * Revalidating a dead namespace sets capacity to 0. This will end
> > +	 * buffered writers dirtying pages that can't be synced.
> > +	 */
> > +	if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
> > +		continue;
> > +	revalidate_disk(ns->disk);
> 
> I was under the impression we could not do this because the queues are still frozen,
> that's why we didnt just issue a scan_work?
> 
> revalidate_disk can potentially try and issue more I/O while the queues are
> frozen from passthru start.

Not when the namespace is dead. It will just set capacity to 0 which
kills any buffered writers; no new IO will be attempted, and anything
gating on entering the frozen queue will fail once we set the queue to
dying.
