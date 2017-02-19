From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 19 Feb 2017 11:43:23 -0800
Subject: [PATCH 1/2] nvme-rdma: move nvme cm status helper to .h file
In-Reply-To: <1487527146-5358-1-git-send-email-maxg@mellanox.com>
References: <1487527146-5358-1-git-send-email-maxg@mellanox.com>
Message-ID: <20170219194323.GB16163@infradead.org>

> +static inline const char *nvme_rdma_cm_msg(enum nvme_rdma_cm_status status)
> +{
> +	switch (status) {
> +	case NVME_RDMA_CM_INVALID_LEN: return "invalid length";
> +	case NVME_RDMA_CM_INVALID_RECFMT: return "invalid record format";
> +	case NVME_RDMA_CM_INVALID_QID: return "invalid queue ID";
> +	case NVME_RDMA_CM_INVALID_HSQSIZE: return "invalid host SQ size";
> +	case NVME_RDMA_CM_INVALID_HRQSIZE: return "invalid host RQ size";
> +	case NVME_RDMA_CM_NO_RSC: return "resource not found";
> +	case NVME_RDMA_CM_INVALID_IRD: return "invalid IRD";
> +	case NVME_RDMA_CM_INVALID_ORD: return "Invalid ORD";
> +	default: return "unrecognized reason";
> +	}
> +}

This also moves from a lookup array to a switch statement.  That's
fine with me, but should be mentioned in the changelog.

Also please don't put code on the same line as the switch label.
