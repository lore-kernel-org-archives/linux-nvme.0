From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 10 Oct 2016 09:47:52 +0200
Subject: [PATCH rfc 3/6] nvme-pci: Use irq-poll for completion processing
In-Reply-To: <6ec3fc69-7f1f-250c-2f9e-f1639694b9dc@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <1475660534-16681-4-git-send-email-sagi@grimberg.me>
 <20161005134013.jkgc6jfbya7x7ou3@linux-x5ow.site>
 <6ec3fc69-7f1f-250c-2f9e-f1639694b9dc@grimberg.me>
Message-ID: <20161010074751.evzcnvmj4eqol74o@linux-x5ow.site>

On Wed, Oct 05, 2016@07:57:11PM +0300, Sagi Grimberg wrote:
> 
> > > @@ -49,6 +50,7 @@
> > >  #define NVME_AQ_DEPTH		256
> > >  #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
> > >  #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
> > > +#define NVME_POLL_BUDGET_IRQ	256
> > 
> > Is there a reason for the 256 or is it just a nicely suited value?
> 
> Umm, No good reason behind it, I used this value before for irq-poll
> and it seemed to fit best. We can try other budgets or have it
> configurable. The point is to not abuse the soft-irq context for too
> long and maintain fairness between completion queues so we just need
> a reasonable value.

Ah OK. I'm not sure whether we should impose a limit (be it a wild guess or a
measurement) or make it adjustable via sysfs. IIRC there is a sysctl to tune
the NAPI budget in the networking stack, which then again raises the question
of doing it global or on a per controller basis.

> 
> 
> > Especially
> > as you've been using INT_MAX as a budget for CQ processing before (which I
> > think is kinda high).
> 
> That was just for keeping the existing logic before we change to
> irq-poll.

Sounds reasonable.

Anyways, I'm looking forward to getting this merged. We can sort out the
tune-ability later on I think.

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
