From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 29 Jun 2016 23:48:38 -0700
Subject: [PATCHv2 1/3] nvme: Remove RCU namespace protection
In-Reply-To: <20160628163512.GB8607@localhost.localdomain>
References: <1466702946-13065-1-git-send-email-keith.busch@intel.com>
 <1466702946-13065-2-git-send-email-keith.busch@intel.com>
 <20160628083137.GA32618@infradead.org>
 <20160628163512.GB8607@localhost.localdomain>
Message-ID: <20160630064838.GA1608@infradead.org>

On Tue, Jun 28, 2016@12:35:13PM -0400, Keith Busch wrote:
> > And this is the scary one - it does an unprotected
> > list_for_each_entry_safe, and nvme_remove_namespaces isn't even called
> > from the scan workqueue.
> > 
> > I think this needs to be something like:
> > 
> > 	mutex_lock(&ctrl->namespaces_mutex);
> > 	list_splice_init(&ctrl->namespaces, &tmp);
> > 	mutex_unlock(&ctrl->namespaces_mutex);
> > 
> > 	list_for_each_entry_safe(ns, next, &tmp, list) {
> > 		..
> > 
> > 		nvme_ns_remove(ns);
> 
> We actually can't do that. The namespace needs to be on ctrl->namespaces
> during nvme_ns_remove because it does IO, and the controller can fail
> during that IO. Every namespace needs to be on the ctrl's namespace
> list until after del_gendisk completes so we can recover from potential
> failures.

But we remove it from the list before del_gendisk in
nvme_remove_invalid_namespaces and nvme_scan_ns_list already.  I guess
that's fine because we're not going to do I/O on them at this point,
but what prevents us form doing this two step removal in
nvme_remove_namespaces?
