From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 26 Jul 2012 12:46:25 -0400
Subject: [PATCH] NVMe: use namespace id for nvme_get_features
In-Reply-To: <1343253998-32681-1-git-send-email-keith.busch@intel.com>
References: <1343253998-32681-1-git-send-email-keith.busch@intel.com>
Message-ID: <20120726164625.GG22985@linux.intel.com>

On Wed, Jul 25, 2012@04:06:38PM -0600, Keith Busch wrote:
> The specification does not provide a use for command dword11 in the NVMe Get
> Features command, but does use the NSID for some features.

... proof that one shouldn't write both sides of a protocol.

Thanks, applied.

> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/block/nvme.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
> index 38b9c73..c4ba0f7 100644
> --- a/drivers/block/nvme.c
> +++ b/drivers/block/nvme.c
> @@ -840,15 +840,15 @@ static int nvme_identify(struct nvme_dev *dev, unsigned nsid, unsigned cns,
>  }
>  
>  static int nvme_get_features(struct nvme_dev *dev, unsigned fid,
> -				unsigned dword11, dma_addr_t dma_addr)
> +				unsigned nsid, dma_addr_t dma_addr)
>  {
>  	struct nvme_command c;
>  
>  	memset(&c, 0, sizeof(c));
>  	c.features.opcode = nvme_admin_get_features;
> +	c.features.nsid = cpu_to_le32(nsid);
>  	c.features.prp1 = cpu_to_le64(dma_addr);
>  	c.features.fid = cpu_to_le32(fid);
> -	c.features.dword11 = cpu_to_le32(dword11);
>  
>  	return nvme_submit_admin_cmd(dev, &c, NULL);
>  }
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
