From: hch@lst.de (Christoph Hellwig)
Date: Sat, 10 Oct 2015 09:28:40 +0200
Subject: [PATCH 3/3] nvme: refactor nvme_queue_rq
In-Reply-To: <20151009201154.GA29924@localhost.localdomain>
References: <1444409756-7317-1-git-send-email-hch@lst.de>
 <1444409756-7317-4-git-send-email-hch@lst.de>
 <20151009201154.GA29924@localhost.localdomain>
Message-ID: <20151010072840.GA18358@lst.de>

On Fri, Oct 09, 2015@02:11:54PM -0600, Jon Derrick wrote:
> Hi Christoph,
> 
> > +	if (!nvme_setup_prps(dev, iod, blk_rq_bytes(req)))
> > +	    	goto out_unmap;
> Git am complains about whitespacing here.

Ok, I fixed the whitespaces in patch 2 and reintroducem them in 3, I'll
fix it in the next resend.
