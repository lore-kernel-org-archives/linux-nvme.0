From: hch@lst.de (Christoph Hellwig)
Date: Tue, 4 Sep 2018 21:06:53 +0200
Subject: [PATCH v2] nvmet-rdma: fix possible bogus dereference under
 heavy load
In-Reply-To: <20180903104707.5776-1-sagi@grimberg.me>
References: <20180903104707.5776-1-sagi@grimberg.me>
Message-ID: <20180904190653.GA2060@lst.de>

On Mon, Sep 03, 2018@03:47:07AM -0700, Sagi Grimberg wrote:
> -	rsp = list_first_entry(&queue->free_rsps,
> +	rsp = list_first_entry_or_null(&queue->free_rsps,
>  				struct nvmet_rdma_rsp, free_list);
> -	list_del(&rsp->free_list);
> +	if (likely(rsp)) {
> +		list_del(&rsp->free_list);
> +		rsp->allocated = false;

Given that we never set allocated to true for something we got from
the freelist, and the structures were allocated using kcalloc I don't
?ee why we need to set it to false here.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
