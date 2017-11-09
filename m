From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 9 Nov 2017 17:33:35 +0000
Subject: [PATCH v3 1/9] RDMA/core: Add implicit per-device completion
 queue pools
In-Reply-To: <23b598f2-6982-0d15-69e4-c526c627ec33@grimberg.me>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <20171108095742.25365-2-sagi@grimberg.me>
 <fe2c23b7-2923-2693-28c3-6a6f399bda26@mellanox.com>
 <23b598f2-6982-0d15-69e4-c526c627ec33@grimberg.me>
Message-ID: <1510248814.2608.19.camel@wdc.com>

On Thu, 2017-11-09@19:31 +0200, Sagi Grimberg wrote:
> > > +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
> > > +        enum ib_poll_context poll_ctx)
> > > +{
> > > +    LIST_HEAD(tmp_list);
> > > +    struct ib_cq *cq;
> > > +    unsigned long flags;
> > > +    int nr_cqs, ret, i;
> > > +
> > > +    /*
> > > +     * Allocated at least as many CQEs as requested, and otherwise
> > > +     * a reasonable batch size so that we can share CQs between
> > > +     * multiple users instead of allocating a larger number of CQs.
> > > +     */
> > > +    nr_cqes = max(nr_cqes, min(dev->attrs.max_cqe, IB_CQE_BATCH));
> > 
> > did you mean min() ?
> 
> No, I meant max. If we choose the CQ size, we choose the min between the
> default and the device capability, if the user chooses, we rely that it
> asked for no more than the device capability (and if not, allocation
> will fail, as it should).

Hello Sagi,

How about the following:

	min(dev->attrs.max_cqe, max(nr_cqes, IB_CQE_BATCH))

Bart.
