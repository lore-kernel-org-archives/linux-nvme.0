From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 8 Jan 2017 09:18:17 -0800
Subject: [PATCH] NVME: Fix CMB types
In-Reply-To: <1483654731-12049-1-git-send-email-jonathan.derrick@intel.com>
References: <1483654731-12049-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20170108171817.GA20466@infradead.org>

On Thu, Jan 05, 2017@03:18:51PM -0700, Jon Derrick wrote:
> ioremapping and the Create SQes command expect a phys_addr_t, so convert
> current usages of dma_addr_t to this type. Also break out the current
> reuse of sq_dma_addr into dma and physical addresses, depending on if
> CMB is being used for SQes.
> 
> Reported by: Max Gurtovoy <maxg at mellanox.com>
> Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
> ---
> Hope this is a good stopgap until we get a more formalized CMB
> management code. Also I don't know whose tree we are using now, so this
> applies to axboe/master

I don't really like the helper with the if - what's the point of having
two variables with different types if we the only user does an implicit
cast to another type.  Maybe we should use use u64 instead of either
dma_addr_t or phys_addr_t and add a comment explaining why we do this?
