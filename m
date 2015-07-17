From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 17 Jul 2015 00:51:23 -0700
Subject: [PATCHv4 2/2] NVMe: Use CMB for the IO SQes if available
In-Reply-To: <1437087088-1628-3-git-send-email-jonathan.derrick@intel.com>
References: <1437087088-1628-1-git-send-email-jonathan.derrick@intel.com>
 <1437087088-1628-3-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20150717075123.GB31679@infradead.org>

On Thu, Jul 16, 2015@04:51:28PM -0600, Jon Derrick wrote:
> +static int use_cmb_sqes = 1;
> +module_param(use_cmb_sqes, int, 0644);
> +MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");

This should be a bool.

> +static void nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
> +				int qid, int depth)
> +{
> +	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev->cmbsz)) {
> +		unsigned offset = (qid - 1) *
> +					roundup(SQ_SIZE(depth), dev->page_size);
> +		nvmeq->sq_dma_addr = dev->cmb_dma_addr + offset;
> +		nvmeq->sq_cmds_io = dev->cmb + offset;
> +	} else {
> +		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
> +					&nvmeq->sq_dma_addr, GFP_KERNEL);
> +	}
> +}

Can you just return an error on allocation failure here insead of
checking sq_cmds after the call to the function?
