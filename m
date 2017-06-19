From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 09:01:52 +0200
Subject: [PATCH v2 2/4] nvme-pci: factor out cqe handling into a
 dedicated routine
In-Reply-To: <1497796090-14808-3-git-send-email-sagi@grimberg.me>
References: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
 <1497796090-14808-3-git-send-email-sagi@grimberg.me>
Message-ID: <20170619070152.GD12938@lst.de>

On Sun, Jun 18, 2017@05:28:08PM +0300, Sagi Grimberg wrote:
> Makes the code slightly more readable.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/pci.c | 53 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 042cfe5ef8e9..26eb1743f8bc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -741,6 +741,35 @@ static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
>  	}
>  }
>  
> +static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
> +		struct nvme_completion *cqe)
> +{
> +	struct request *req;
> +
> +	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
> +		dev_warn(nvmeq->dev->ctrl.device,
> +			"invalid id %d completed on queue %d\n",
> +			cqe->command_id, le16_to_cpu(cqe->sq_id));
> +		return;
> +	}
> +
> +	/*
> +	 * AEN requests are special as they don't time out and can
> +	 * survive any kind of queue freeze and often don't respond to
> +	 * aborts.  We don't even bother to allocate a struct request
> +	 * for them but rather special case them here.
> +	 */

Lots more space for the comments now, they could be reflowed.  Nothing
worth resending for, though.

Reviewed-by: Christoph Hellwig <hch at lst.de>
