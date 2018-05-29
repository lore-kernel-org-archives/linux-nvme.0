From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 15:40:19 +0200
Subject: [PATCH 09/10] nvmet: Set mnan correctly
In-Reply-To: <20180529150635.7af65b52@pentland.suse.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-10-hare@suse.de> <20180529125249.GI7376@lst.de>
 <20180529150635.7af65b52@pentland.suse.de>
Message-ID: <20180529134019.GB8916@lst.de>

On Tue, May 29, 2018@03:06:35PM +0200, Hannes Reinecke wrote:
> On Tue, 29 May 2018 14:52:49 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Tue, May 29, 2018@12:14:30PM +0200, Hannes Reinecke wrote:
> > >  	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
> > > -	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
> > > +	id->mnan = cpu_to_le32(ctrl->subsys->nr_namespaces);  
> > 
> > "Maximum Number of Allocated Namespaces (MNAN): This field indicates
> > the maximum number of allocated namespaces."
> > 
> > maximum != current
> > 
> 
> What exactly is the difference between 'allocated' and 'current'
> namespaces in the context of nvmet?

NVMe differciates between allocated namespaces that exist in a given
subsystem, and attached namespaces that are attached to a given
controller.  I can't see how that distinction actually matters
here.
