From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Sep 2016 10:41:21 +0200
Subject: [PATCH v3 2/3] nvme: Pass pointers, not dma addresses, to
 nvme_get/set_features()
In-Reply-To: <accff9a7a1b04cdb8fc364851f20b93e3de0d7f0.1474002926.git.luto@kernel.org>
References: <cover.1474002926.git.luto@kernel.org>
 <accff9a7a1b04cdb8fc364851f20b93e3de0d7f0.1474002926.git.luto@kernel.org>
Message-ID: <20160916084121.GC2415@lst.de>

On Thu, Sep 15, 2016@10:24:20PM -0700, Andy Lutomirski wrote:
> Any user I can imagine that needs a buffer at all will want to pass
> a pointer directly.  There are no currently callers that use
> buffers, so this change is painless, and it will make it much easier
> to start using features that use buffers (e.g. APST).
> 
> Signed-off-by: Andy Lutomirski <luto at kernel.org>
> ---

Looks good mostly good, but a nitpick below:

> +	/*
> +	 * Casting buffer to void* is safe here: __nvme_submit_sync_cmd knows
> +	 * that we're writing because it decodes the opcode.
> +	 */
> +	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &cqe,
> +			(void *)buffer, buflen, 0, NVME_QID_ANY, 0, 0);

Cant we just drop the const annotation to avoid these casts?
