From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 21 Jun 2015 22:41:46 -0700
Subject: [PATCH] NVMe: Use CMB for the SQ if available
In-Reply-To: <1434750357-29162-1-git-send-email-jonathan.derrick@intel.com>
References: <1434750357-29162-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20150622054146.GA27663@infradead.org>

On Fri, Jun 19, 2015@03:45:57PM -0600, Jon Derrick wrote:
> +static inline void nvme_put_cmd(struct nvme_queue *nvmeq,
> +				struct nvme_command *cmd)
> +{
> +	if (nvmeq->cmb_mapped)
> +		memcpy_toio(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd,
> +				sizeof(*cmd));
> +}

You'll need a separate sq_cmds replacement that's __iomem annotated
for this case.

> +static inline struct nvme_command *nvme_get_cmd(struct nvme_queue *nvmeq)
> +{
> +	if (nvmeq->cmb_mapped)
> +		return &nvmeq->cmb_cmd;

> +
> +	return &nvmeq->sq_cmds[nvmeq->sq_tail];
> +}

I think you really want to restructure the submission helpers to not
need this.  We always overwrite the whole command using memcpy/memset,
so I'd suggest to replace the remaining direct accesses to ->sq_cmds
with calls to __nvme_submit_cmd in a preparatory patch.

> +	if (qid && NVME_CMB_SQS(dev->cmbsz) && dev->cmb) {
> +		unsigned offset = (qid - 1) *
> +					roundup(SQ_SIZE(depth), dev->page_size);
> +		nvmeq->cmb_mapped = true;
> +		nvmeq->sq_dma_addr = dev->cmb_dma_addr + offset;
> +		return (void *)((uintptr_t)dev->cmb + offset);

Just do the arithmetics on the void pointer, that's a gcc extension
much of the Linux codebase assumes to be present.
