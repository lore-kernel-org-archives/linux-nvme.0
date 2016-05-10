From: keith.busch@intel.com (Keith Busch)
Date: Tue, 10 May 2016 15:16:27 -0400
Subject: [PATCH-4.7 2/3] NVMe: Short-cut removal on surprise hot-unplug
In-Reply-To: <20160503080140.GB31768@infradead.org>
References: <1462209128-12376-1-git-send-email-keith.busch@intel.com>
 <1462209128-12376-3-git-send-email-keith.busch@intel.com>
 <20160503080140.GB31768@infradead.org>
Message-ID: <20160510191627.GB21426@localhost.localdomain>

On Tue, May 03, 2016@01:01:40AM -0700, Christoph Hellwig wrote:
> > @@ -1584,6 +1593,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
> >  {
> >  	struct nvme_ns *ns, *next;
> >  
> > +	if (ctrl->state == NVME_CTRL_DEAD)
> > +		nvme_kill_queues(ctrl);
> > +
> >  	mutex_lock(&ctrl->namespaces_mutex);
> >  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
> >  		nvme_ns_remove(ns);
> 
> Not happy about so much magic.. At least add comments explaining why
> you're doing this, and that it's just an optimization.

We could just call nvme_kill_queues from the pci driver's nvme_remove
instead of adding the state. I just thought this was universally useful
for a non-graceful disconnect.
