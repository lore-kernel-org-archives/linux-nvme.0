From: hch@lst.de (Christoph Hellwig)
Date: Tue, 16 Jul 2019 08:06:23 +0200
Subject: [PATCH 3/3] nvme: Add support for Apple 2018+ models
In-Reply-To: <20190716004649.17799-3-benh@kernel.crashing.org>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
 <20190716004649.17799-3-benh@kernel.crashing.org>
Message-ID: <20190716060623.GC29414@lst.de>

On Tue, Jul 16, 2019@10:46:49AM +1000, Benjamin Herrenschmidt wrote:
> Based on reverse engineering and original patch by
> 
> Paul Pawlowski <paul at mrarm.io>
> 
> This adds support for Apple weird implementation of NVME in their
> 2018 or later machines. It accounts for the twice-as-big SQ entries
> for the IO queues, and the fact that only interrupt vector 0 appears
> to function properly.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh at kernel.crashing.org>
> ---
>  drivers/nvme/host/core.c |  5 ++++-
>  drivers/nvme/host/nvme.h | 10 ++++++++++
>  drivers/nvme/host/pci.c  |  6 ++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 716ebe87a2b8..480ea24d8cf4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2701,7 +2701,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
>  
>  		/* Grab required IO queue size */
> -		ctrl->iosqes = id->sqes & 0xf;
> +		if (ctrl->quirks & NVME_QUIRK_128_BYTES_SQES)
> +			ctrl->iosqes = 7;
> +		else
> +			ctrl->iosqes = id->sqes & 0xf;
>  		if (ctrl->iosqes < NVME_NVM_IOSQES) {
>  			dev_err(ctrl->device,
>  				"unsupported required IO queue size %d\n", ctrl->iosqes);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 34ef35fcd8a5..b2a78d08b984 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -92,6 +92,16 @@ enum nvme_quirks {
>  	 * Broken Write Zeroes.
>  	 */
>  	NVME_QUIRK_DISABLE_WRITE_ZEROES		= (1 << 9),
> +
> +	/*
> +	 * Use only one interrupt vector for all queues
> +	 */
> +	NVME_QUIRK_SINGLE_VECTOR		= (1 << 10),
> +
> +	/*
> +	 * Use non-standard 128 bytes SQEs.
> +	 */
> +	NVME_QUIRK_128_BYTES_SQES		= (1 << 11),
>  };
>  
>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 54b35ea4af88..ab2358137419 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2080,6 +2080,9 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
>  	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
>  	dev->io_queues[HCTX_TYPE_READ] = 0;
>  
> +	if (dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR)
> +		irq_queues = 1;
> +
>  	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
>  			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);

Callin pci_alloc_irq_vectors_affinity in this case seems a bit
pointless, but if this works for you I'd rather keep it as-is for now
if this works for you.
