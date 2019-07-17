From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 17 Jul 2019 20:54:29 +0900
Subject: [PATCH v2 3/3] nvme-pci: Add support for Apple 2018+ models
In-Reply-To: <20190717004527.30363-3-benh@kernel.crashing.org>
References: <20190717004527.30363-1-benh@kernel.crashing.org>
 <20190717004527.30363-3-benh@kernel.crashing.org>
Message-ID: <20190717115429.GC10495@minwoo-desktop>

On 19-07-17 10:45:27, Benjamin Herrenschmidt wrote:
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
> 
> # Conflicts:
> #	drivers/nvme/host/core.c
> ---
>  drivers/nvme/host/nvme.h | 10 ++++++++++
>  drivers/nvme/host/pci.c  | 21 ++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 716a876119c8..ced0e0a7e039 100644
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
> index 1637677afb78..7088971d4c42 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2081,6 +2081,13 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
>  	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
>  	dev->io_queues[HCTX_TYPE_READ] = 0;
>  
> +	/*
> +	 * Some Apple controllers require all queues to use the
> +	 * first vector.
> +	 */
> +	if (dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR)
> +		irq_queues = 1;
> +
>  	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
>  			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
>  }
> @@ -2322,7 +2329,16 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  				io_queue_depth);
>  	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
>  	dev->dbs = dev->bar + 4096;
> -	dev->io_sqes = NVME_NVM_IOSQES;
> +
> +	/*
> +	 * Some Apple controllers require a non-standard SQE size.
> +	 * Interestingly they also seem to ignore the CC:IOSQES register
> +	 * so we don't bother updating it here.
> +	 */

That is really interesting.

This also looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>

Thanks,
