From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 25 Oct 2016 19:36:25 +0300
Subject: [PATCH v3 4/6] nvme-rdma: use rdma connection reject helper
 functions
In-Reply-To: <55638a1d2a9f79af8b9a19eb444c5d0a41691352.1477336045.git.swise@opengridcomputing.com>
References: <cover.1477336045.git.swise@opengridcomputing.com>
 <55638a1d2a9f79af8b9a19eb444c5d0a41691352.1477336045.git.swise@opengridcomputing.com>
Message-ID: <7191d136-aef4-9fed-223e-f2a9c1d958e5@grimberg.me>


> +static const char *const nvme_rdma_cm_status_strs[] = {
> +	[NVME_RDMA_CM_INVALID_LEN]	= "invalid length",
> +	[NVME_RDMA_CM_INVALID_RECFMT]	= "invalid record format",
> +	[NVME_RDMA_CM_INVALID_QID]	= "invalid queue id",
> +	[NVME_RDMA_CM_INVALID_HSQSIZE]	= "invalid host sq size",
> +	[NVME_RDMA_CM_INVALID_HRQSIZE]	= "invalid host rq size",
> +	[NVME_RDMA_CM_NO_RSC]		= "resource not found",
> +	[NVME_RDMA_CM_INVALID_IRD]	= "invalid ird",
> +	[NVME_RDMA_CM_INVALID_ORD]	= "Invalid ord",
> +};

I think it'd be better to move them to include/linux/nvme-rdma.h
and use them for logging on the target side too.
