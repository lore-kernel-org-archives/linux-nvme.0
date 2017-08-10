From: hch@lst.de (Christoph Hellwig)
Date: Thu, 10 Aug 2017 10:38:27 +0200
Subject: [PATCH 1/2] nvme: Fix nvme reset command timeout handling
In-Reply-To: <20170728075834.GC4043@linux-x5ow.site>
References: <1501174721-8253-1-git-send-email-keith.busch@intel.com>
 <20170728075834.GC4043@linux-x5ow.site>
Message-ID: <20170810083827.GB22739@lst.de>

On Fri, Jul 28, 2017@09:58:34AM +0200, Johannes Thumshirn wrote:
> On Thu, Jul 27, 2017@12:58:40PM -0400, Keith Busch wrote:
> >  static void nvme_set_latency_tolerance(struct device *dev, s32 val)
> > @@ -1856,17 +1857,25 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
> >  
> >  	kfree(id);
> >  
> > +	if (ret < 0)
> > +		return ret;
> > +
> 
> This is a bit confusing IMHO, how about this?

Agreed.

We probably should get this series into 4.13, so other comments would
be welcome.
