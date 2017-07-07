From: zhangweiping@didichuxing.com (weiping zhang)
Date: Sat, 8 Jul 2017 00:53:59 +0800
Subject: [PATCH] nvme-pci: add module parameter for io queue depth
In-Reply-To: <20170707152948.GB14788@localhost.localdomain>
References: <20170707090547.GA2420@localhost.didichuxing.com>
 <20170707152948.GB14788@localhost.localdomain>
Message-ID: <20170707165359.GA27636@localhost.didichuxing.com>

On Fri, Jul 07, 2017@11:29:48AM -0400, Keith Busch wrote:
> On Fri, Jul 07, 2017@05:05:47PM +0800, weiping zhang wrote:
> > Adjust io queue depth more easily.
> >  	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
> >  
> > -	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
> > +	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, io_queue_depth);
> 
> We need to be a little more careful about this field if users can write
> whatever they want. It's gotta be >= 2 or else trouble will occur.

ok, I will send patch v2, thanks all.
