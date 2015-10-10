From: hch@lst.de (Christoph Hellwig)
Date: Sat, 10 Oct 2015 08:53:19 +0200
Subject: [PATCH 3/3] nvme: refactor nvme_queue_rq
In-Reply-To: <20151009201154.GA29924@localhost.localdomain>
References: <1444409756-7317-1-git-send-email-hch@lst.de>
 <1444409756-7317-4-git-send-email-hch@lst.de>
 <20151009201154.GA29924@localhost.localdomain>
Message-ID: <20151010065319.GA17885@lst.de>

On Fri, Oct 09, 2015@02:11:54PM -0600, Jon Derrick wrote:
> Hi Christoph,
> 
> > +	if (!nvme_setup_prps(dev, iod, blk_rq_bytes(req)))
> > +	    	goto out_unmap;
> Git am complains about whitespacing here.

Hmm, checkpatch was fine with it.  I know there was odd whitespacing on
the lines before I touched i but I though I fixed all that.

> The set looks fine to me. I'm tempted to do some performance testing with the microoptimizations present here. Have you seen any results yourself?

On the PCIe side I've only tested it with normal Flash devices where
I didn't see a difference, so numbers would be welcome.
