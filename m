From: keith.busch@intel.com (Keith Busch)
Date: Tue, 28 Jun 2016 12:35:13 -0400
Subject: [PATCHv2 1/3] nvme: Remove RCU namespace protection
In-Reply-To: <20160628083137.GA32618@infradead.org>
References: <1466702946-13065-1-git-send-email-keith.busch@intel.com>
 <1466702946-13065-2-git-send-email-keith.busch@intel.com>
 <20160628083137.GA32618@infradead.org>
Message-ID: <20160628163512.GB8607@localhost.localdomain>

On Tue, Jun 28, 2016@01:31:37AM -0700, Christoph Hellwig wrote:
> > @@ -1656,10 +1662,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
> >  	if (ctrl->state == NVME_CTRL_DEAD)
> >  		nvme_kill_queues(ctrl);
> >  
> > -	mutex_lock(&ctrl->namespaces_mutex);
> >  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
> >  		nvme_ns_remove(ns);
> > -	mutex_unlock(&ctrl->namespaces_mutex);
> 
> And this is the scary one - it does an unprotected
> list_for_each_entry_safe, and nvme_remove_namespaces isn't even called
> from the scan workqueue.
> 
> I think this needs to be something like:
> 
> 	mutex_lock(&ctrl->namespaces_mutex);
> 	list_splice_init(&ctrl->namespaces, &tmp);
> 	mutex_unlock(&ctrl->namespaces_mutex);
> 
> 	list_for_each_entry_safe(ns, next, &tmp, list) {
> 		..
> 
> 		nvme_ns_remove(ns);

We actually can't do that. The namespace needs to be on ctrl->namespaces
during nvme_ns_remove because it does IO, and the controller can fail
during that IO. Every namespace needs to be on the ctrl's namespace
list until after del_gendisk completes so we can recover from potential
failures.

It does look concerning, but it's safe if the caller ensures no scan
work is or ever will be active. If that sounds okay or no alternative
exists, I can document this usage requirement in the code.
