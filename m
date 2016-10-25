From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 25 Oct 2016 13:20:49 -0500
Subject: [PATCH v3 4/6] nvme-rdma: use rdma connection reject helper
 functions
In-Reply-To: <b5d32deb-af6a-3f98-98da-c5f61d400876@sandisk.com>
References: <cover.1477336045.git.swise@opengridcomputing.com>
 <55638a1d2a9f79af8b9a19eb444c5d0a41691352.1477336045.git.swise@opengridcomputing.com>
 <b5d32deb-af6a-3f98-98da-c5f61d400876@sandisk.com>
Message-ID: <014d01d22eec$832e60e0$898b22a0$@opengridcomputing.com>

> 
> On 10/24/2016 12:09 PM, Steve Wise wrote:
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
> Please capitalize abbreviations (SQ, RQ, ID, IRD and ORD).
>

will do.

 
> > +static const char *nvme_rdma_cm_msg(enum nvme_rdma_cm_status status)
> > +{
> > +	size_t index = status;
> > +
> > +	if (index >= ARRAY_SIZE(nvme_rdma_cm_status_strs) ||
> > +	    !nvme_rdma_cm_status_strs[index])
> > +		return "unrecognized reason";
> > +	else
> > +		return nvme_rdma_cm_status_strs[index];
> > +};
> 
> Please consider rewriting this if-statement such that the recognized
> reason scenario occurs first.
>

sure.
 
> > +	rej_msg = rdma_reject_msg(cm_id, status);
> > +	rej_data = (struct nvme_rdma_cm_rej *)
> > +		   rdma_consumer_reject_data(cm_id, ev, &rej_data_len);
> 
> Please reorder the patches in this patch series such that it doesn't
> break a bisect. rdma_consumer_reject_data() should be introduced before
> it is used.
> 

rdma_consumer_reject_data() is introduced in patch 3.
