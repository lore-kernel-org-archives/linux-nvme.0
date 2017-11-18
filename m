From: leonro@mellanox.com (Leon Romanovsky)
Date: Sat, 18 Nov 2017 09:36:56 +0200
Subject: [PATCH 1/3] IB/core: add a simple SRQ pool per PD
In-Reply-To: <c94d2e03-dd32-ff0a-789f-aae4d65f3955@mellanox.com>
References: <1510852885-25519-1-git-send-email-maxg@mellanox.com>
 <1510852885-25519-2-git-send-email-maxg@mellanox.com>
 <20171116181049.GO18825@mtr-leonro.local>
 <c94d2e03-dd32-ff0a-789f-aae4d65f3955@mellanox.com>
Message-ID: <20171118073656.GS18825@mtr-leonro.local>

On Fri, Nov 17, 2017@09:12:46PM +0200, Max Gurtovoy wrote:
> > > +#ifndef _RDMA_SRQ_POOL_H
> > > +#define _RDMA_SRQ_POOL_H 1
> > > +
> > > +#include <rdma/ib_verbs.h>
> > > +
> > > +struct ib_srq *ib_srq_pool_get(struct ib_pd *pd);
> > > +void ib_srq_pool_put(struct ib_pd *pd, struct ib_srq *srq);
> > > +
> > > +int ib_srq_pool_init(struct ib_pd *pd, int nr,
> > > +		struct ib_srq_init_attr *srq_attr);
> > > +void ib_srq_pool_destroy(struct ib_pd *pd);
> >
> > Can you please use rdma_ prefix instead of ib_ prefix?
> >
> > Thanks
> >
>
> Do you mean rdma_srq_pool_get instead of ib_srq_pool_get ? is this new
> convetion ? this is a pool that contain ib_srq objects and not rdma_srq
> objects..

I want to follow similar pattern as was chosen for various popular pools
implementation, like dma_pool_, mempool e.t.c

IMHO rdma_srqpool_* looks cleaner than it is now.

Thanks

>
> I can do it if needed.

>
> > > +
> > > +#endif /* _RDMA_SRQ_POOL_H */
> > > --
> > > 1.8.3.1
> > >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171118/298fd8de/attachment.sig>
