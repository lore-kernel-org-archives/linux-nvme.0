From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 15:06:35 +0200
Subject: [PATCH 09/10] nvmet: Set mnan correctly
In-Reply-To: <20180529125249.GI7376@lst.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-10-hare@suse.de>
 <20180529125249.GI7376@lst.de>
Message-ID: <20180529150635.7af65b52@pentland.suse.de>

On Tue, 29 May 2018 14:52:49 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, May 29, 2018@12:14:30PM +0200, Hannes Reinecke wrote:
> >  	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
> > -	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
> > +	id->mnan = cpu_to_le32(ctrl->subsys->nr_namespaces);  
> 
> "Maximum Number of Allocated Namespaces (MNAN): This field indicates
> the maximum number of allocated namespaces."
> 
> maximum != current
> 

What exactly is the difference between 'allocated' and 'current'
namespaces in the context of nvmet?

It's not that we have _allocated_ all possible namespace. And the mnan
field was specifically designed to give a hint to the host on how many
namespaces are expected to be available to it.

Cheers,

Hannes
