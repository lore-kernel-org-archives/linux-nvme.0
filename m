From: keith.busch@intel.com (Keith Busch)
Date: Thu, 15 Jun 2017 13:04:49 -0400
Subject: [PATCH] nvme-pci: another 64-bit division for the host memory
 buffer code
In-Reply-To: <20170613153130.20426-1-hch@lst.de>
References: <20170613153130.20426-1-hch@lst.de>
Message-ID: <20170615170449.GD13399@localhost.localdomain>

Looks fine.

Reviewed-by: Keith Busch <keith.busch at intel.com>

On Tue, Jun 13, 2017@05:31:30PM +0200, Christoph Hellwig wrote:
> [to be folded into "nvme-pci: implement host memory buffer support"]
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> 
> ---
> 
> Now tested with a full i386 build, sigh..
> ---
>  drivers/nvme/host/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 788bb2c479d0..4b50fef1fa1b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1591,12 +1591,14 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
>  	struct nvme_host_mem_buf_desc *descs;
>  	u32 chunk_size, max_entries, i = 0;
>  	void **bufs;
> -	u64 size;
> +	u64 size, tmp;
>  
>  	/* start big and work our way down */
>  	chunk_size = min(preferred, (u64)PAGE_SIZE << MAX_ORDER);
>  retry:
> -	max_entries = DIV_ROUND_UP(preferred, chunk_size);
> +	tmp = (preferred + chunk_size - 1);
> +	do_div(tmp, chunk_size);
> +	max_entries = tmp;
>  	descs = kcalloc(max_entries, sizeof(*descs), GFP_KERNEL);
>  	if (!descs)
>  		goto out;
> -- 
> 2.11.0
> 
