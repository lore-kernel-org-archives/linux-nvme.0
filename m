From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 May 2019 08:15:55 +0200
Subject: [PATCH, RFC 2/2] nvme: validate cntlid during controller
 initialisation
In-Reply-To: <20190508142814.GB7113@localhost.localdomain>
References: <20190508075508.28552-1-hch@lst.de>
 <20190508075508.28552-2-hch@lst.de>
 <20190508142814.GB7113@localhost.localdomain>
Message-ID: <20190509061555.GB15229@lst.de>

On Wed, May 08, 2019@08:28:14AM -0600, Keith Busch wrote:
> On Wed, May 08, 2019@09:55:08AM +0200, Christoph Hellwig wrote:
> > +	list_for_each_entry(tmp, &subsys->ctrls, subsys_entry) {
> > +		if (ctrl->state == NVME_CTRL_DELETING ||
> > +		    ctrl->state == NVME_CTRL_DEAD)
> > +			continue;
> > +
> > +		if (tmp->cntlid == ctrl->cntlid) {
> > +			dev_err(ctrl->device,
> > +				"Duplicate cntlid %u, rejecting\n",
> > +				ctrl->cntlid);
> 
> Patch looks great, but let's make this print more informative by showing
> tmp's device name too:
> 
> 			dev_err(ctrl->device,
> 				"Duplicate cntlid %u with %s, rejecting\n",
> 				ctrl->cntlid, dev_name(tmp->device));

Sure.  The printk was taken 1:1 from the existing code, but I could
improve it.
