From: keith.busch@intel.com (Keith Busch)
Date: Fri, 30 Sep 2016 11:20:53 -0400
Subject: [PATCH 4/5] nvme: use symbolic constants for CNS values
In-Reply-To: <1475236270-18329-5-git-send-email-hch@lst.de>
References: <1475236270-18329-1-git-send-email-hch@lst.de>
 <1475236270-18329-5-git-send-email-hch@lst.de>
Message-ID: <20160930152053.GC22601@localhost.localdomain>

On Fri, Sep 30, 2016@01:51:09PM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>

> ---
>  drivers/nvme/host/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 329381a..4bade0d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -554,7 +554,7 @@ int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
>  
>  	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
>  	c.identify.opcode = nvme_admin_identify;
> -	c.identify.cns = cpu_to_le32(1);
> +	c.identify.cns = cpu_to_le32(NVME_ID_CNS_CTRL);
>  
>  	*id = kmalloc(sizeof(struct nvme_id_ctrl), GFP_KERNEL);
>  	if (!*id)
> @@ -572,7 +572,7 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
>  	struct nvme_command c = { };
>  
>  	c.identify.opcode = nvme_admin_identify;
> -	c.identify.cns = cpu_to_le32(2);
> +	c.identify.cns = cpu_to_le32(NVME_ID_CNS_NS_ACTIVE_LIST);
>  	c.identify.nsid = cpu_to_le32(nsid);
>  	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list, 0x1000);
>  }
> -- 
> 2.1.4
