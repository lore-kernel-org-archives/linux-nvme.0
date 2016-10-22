From: swise@opengridcomputing.com (Steve Wise)
Date: Sat, 22 Oct 2016 10:57:28 -0500
Subject: [PATCH RFC v2 2/3] rdma_cm: add rdma_consumer_reject()
 helper	function
In-Reply-To: <20161021121428.GB17028@lst.de>
References: <cover.1477003235.git.swise@opengridcomputing.com>
 <cb135696be86c21c144ef35a4d6f7f71394a3627.1477003235.git.swise@opengridcomputing.com>
 <20161021121428.GB17028@lst.de>
Message-ID: <004501d22c7c$fd3e6fa0$f7bb4ee0$@opengridcomputing.com>

> > --- a/drivers/infiniband/core/cma.c
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -114,6 +114,19 @@ const char *__attribute_const__
> rdma_reject_msg(struct rdma_cm_id *id,
> >  }
> >  EXPORT_SYMBOL(rdma_reject_msg);
> >
> > +bool rdma_consumer_reject(struct rdma_cm_id *id, int reason)
> > +{
> > +	if (rdma_ib_or_roce(id->device, id->port_num))
> > +		return ib_consumer_reject(reason);
> > +
> > +	if (rdma_protocol_iwarp(id->device, id->port_num))
> > +		return iw_consumer_reject(reason);
> > +
> > +	/* FIXME should we WARN_ONCE() here? */
> > +	return false;
> 
> Yes.  Also I'd just inline the ib_consumer_reject and iw_consumer_reject
> helpers here.
>

Why is that preferred vs the static inline functions in ib_cm.h and iw_cm.h?
