From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 04 Nov 2016 08:54:27 -0700
Subject: [PATCH] nvmet: Don't queue fatal error work if csts.cfs is set
In-Reply-To: <20161104000111.GA14022@lst.de>
References: <1478207842-27774-1-git-send-email-sagi@grimberg.me>
 <20161104000111.GA14022@lst.de>
Message-ID: <1478274867.2886.3.camel@linux.intel.com>

On Fri, 2016-11-04@01:01 +0100, Christoph Hellwig wrote:
> > 
> > ?{
> > -	ctrl->csts |= NVME_CSTS_CFS;
> > +	if (test_and_set_bit(NVME_CSTS_CFS, (unsigned long
> > *)&ctrl->csts))
> > +		return;
> > +
> 
> This can't work - test_and_set_bit takes a bit index and
> NVME_CSTS_CFS
> is the actual value.??I think we'll need a lock to protect ->csts
> instead.

Yeah, I agree, it feels more like a lock solution.

> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
