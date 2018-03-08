From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Mar 2018 08:56:28 +0100
Subject: [PATCH rfc] nvme-pci: make sure to flush sqe writes before db
 record update
In-Reply-To: <20180307175626.15222-1-sagi@grimberg.me>
References: <20180307175626.15222-1-sagi@grimberg.me>
Message-ID: <20180308075628.GA16084@lst.de>

Yes, looks like we'd need this.

On Wed, Mar 07, 2018@07:56:26PM +0200, Sagi Grimberg wrote:
> A wmb() is always required before operations that trigger DMA
> (e.g. mmio write to a doorbell record). Not having it might result
> in write reordering causing the device to fetch partly updated
> submission queue entries.
> 
> Reported-by: Jason Gunthorpe <jgg at ziepe.ca>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> Note that this is stable material, We could add stable
> tag when applying it to the nvme tree.
> 
>  drivers/nvme/host/pci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index db4dedb1cc8f..6c2dcef1ff91 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -437,8 +437,14 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
>  	if (++tail == nvmeq->q_depth)
>  		tail = 0;
>  	if (nvme_dbbuf_update_and_check_event(tail, nvmeq->dbbuf_sq_db,
> -					      nvmeq->dbbuf_sq_ei))
> +					      nvmeq->dbbuf_sq_ei)) {
> +		/*
> +		 * Make sure that descriptors are written before
> +		 * doorbell record.
> +		 */
> +		wmb();
>  		writel(tail, nvmeq->q_db);
> +	}
>  	nvmeq->sq_tail = tail;
>  }
>  
> -- 
> 2.14.1
---end quoted text---
