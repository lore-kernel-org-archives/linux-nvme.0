From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 25 Oct 2016 11:58:34 -0500
Subject: [PATCH v3 4/6] nvme-rdma: use rdma connection reject helper
 functions
In-Reply-To: <7191d136-aef4-9fed-223e-f2a9c1d958e5@grimberg.me>
References: <cover.1477336045.git.swise@opengridcomputing.com>
 <55638a1d2a9f79af8b9a19eb444c5d0a41691352.1477336045.git.swise@opengridcomputing.com>
 <7191d136-aef4-9fed-223e-f2a9c1d958e5@grimberg.me>
Message-ID: <010901d22ee1$058d6ec0$10a84c40$@opengridcomputing.com>

> > +static const char *const nvme_rdma_cm_status_strs[] = {
> > +	[NVME_RDMA_CM_INVALID_LEN]	= "invalid length",
> > +	[NVME_RDMA_CM_INVALID_RECFMT]	= "invalid record format",
> > +	[NVME_RDMA_CM_INVALID_QID]	= "invalid queue id",
> > +	[NVME_RDMA_CM_INVALID_HSQSIZE]	= "invalid host sq size",
> > +	[NVME_RDMA_CM_INVALID_HRQSIZE]	= "invalid host rq size",
> > +	[NVME_RDMA_CM_NO_RSC]		= "resource not found",
> > +	[NVME_RDMA_CM_INVALID_IRD]	= "invalid ird",
> > +	[NVME_RDMA_CM_INVALID_ORD]	= "Invalid ord",
> > +};
> 
> I think it'd be better to move them to include/linux/nvme-rdma.h
> and use them for logging on the target side too.
> 

You want to put this in nvme-rdma.h as-is so the memory for this is allocated in
each .c file that includes it? 
