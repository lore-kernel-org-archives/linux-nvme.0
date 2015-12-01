From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Tue, 1 Dec 2015 20:46:48 +0100
Subject: [PATCH v2] nvme: temporary fix for Apple controller reset
In-Reply-To: <781f695dc3cedc678faf29070a6f6bf5@localhost>
References: <781f695dc3cedc678faf29070a6f6bf5@localhost>
Message-ID: <9cc23b98072a89f0f469f528f6e8f74e@localhost>

The patch below has been reviewed by Christoph and reported to work.
However, there is still no sign that it will be applied to linux-4.4.

Please either undo commit c74dc7801d515d01847fd5cf2b472489fa5717b1,
which added the PCI ID of the Apple controller, or merge the patch below
asap.


Currently, the driver will make that controller destroy data!


Best,
Stephan


On 2015/November/22 03:28, Stephan G?nther wrote:
> Recent patches added basic support for the Apple NVMe controller but
> still cause resets and data corruption on that particular controller
> when a specific pattern of read/flush commands occurs. Limiting the
> queue depth to 2 works around that issue.
> 
> This patch enforces that limit only for the Apple controller and is
> considered a temporary fix until we find the root source of that
> problem.
> 
> Signed-off-by: Stephan G?nther <guenther at tum.de>
> Signed-off-by: Maurice Leclaire <leclaire at in.tum.de>
> ---
>  drivers/nvme/host/pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8187df2..d3c2b03 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2701,6 +2701,18 @@ static int nvme_dev_map(struct nvme_dev *dev)
>  	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
>  	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
>  	dev->dbs = ((void __iomem *)dev->bar) + 4096;
> +
> +	/*
> + 	 * Temporary fix for the Apple controller found in the MacBook8,1 and
> +	 * some MacBook7,1 to avoid controller resets and data loss.
> + 	 */
> +	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001) {
> + 		dev->q_depth = 2;
> +		dev_warn(dev->dev, "detected Apple NVMe controller, set "
> +			"queue depth=%u to work around controller resets\n",
> +			dev->q_depth);
> +	}
> +
>  	if (readl(&dev->bar->vs) >= NVME_VS(1, 2))
>  		dev->cmb = nvme_map_cmb(dev);
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
