From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 25 May 2018 01:53:13 -0700
Subject: [PATCH] nvme: fix KASAN warning when parsing host nqn
In-Reply-To: <20180514124414.GA25689@lst.de>
References: <20180514122312.62068-1-hare@suse.de>
 <20180514124414.GA25689@lst.de>
Message-ID: <20180525085313.GA10951@infradead.org>

On Mon, May 14, 2018@02:44:14PM +0200, Christoph Hellwig wrote:
> On Mon, May 14, 2018@02:23:12PM +0200, Hannes Reinecke wrote:
> > -	host = kmalloc(sizeof(*host), GFP_KERNEL);
> > +	host = kzalloc(sizeof(*host), GFP_KERNEL);
> >  	if (!host)
> >  		goto out_unlock;
> >  
> >  	kref_init(&host->ref);
> > -	memcpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
> > +	memcpy(host->nqn, hostnqn, strlen(hostnqn));
> 
> That pattern is called strcpy :)  And we better use strlcpy here,
> just in case.

Can you resend a fixed up version?
