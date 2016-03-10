From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 10 Mar 2016 09:27:00 +0100
Subject: [PATCH] nvme: add a constant for the identify payload size
In-Reply-To: <20160309190731.GD2464@linux.intel.com>
References: <1457542477-25191-1-git-send-email-hch@lst.de>
 <20160309190731.GD2464@linux.intel.com>
Message-ID: <20160310082700.GI3464@c203.arch.suse.de>

On Wed, Mar 09, 2016@02:07:31PM -0500, Matthew Wilcox wrote:
> On Wed, Mar 09, 2016@05:54:37PM +0100, Christoph Hellwig wrote:
> > The NVMe spec specifies a hardcoded payload length of 4k for all
> > types of Identify commands.  Use a constant instead of hardcoded
> > values that can be confused for the page size.
> 
> I think the problem here is that we don't have a struct for nvme_ns_list.
> 
> Something like this:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e2d11d6..a4a7210 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -296,14 +296,16 @@ int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
>  	return error;
>  }
>  
> -static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *ns_list)
> +static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid,
> +				struct nvme_id_ns_list *ns_list)
>  {
>  	struct nvme_command c = { };
>  
>  	c.identify.opcode = nvme_admin_identify;
>  	c.identify.cns = cpu_to_le32(2);
>  	c.identify.nsid = cpu_to_le32(nsid);
> -	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list, 0x1000);
> +	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list,
> +					sizeof(*ns_list));
>  }
>  
>  int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
> @@ -1296,11 +1298,11 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
>  {
>  	struct nvme_ns *ns;
> -	__le32 *ns_list;
> +	struct nvme_id_ns_list *ns_list;
>  	unsigned i, j, nsid, prev = 0, num_lists = DIV_ROUND_UP(nn, 1024);
>  	int ret = 0;
>  
> -	ns_list = kzalloc(0x1000, GFP_KERNEL);
> +	ns_list = kzalloc(sizeof(*ns_list), GFP_KERNEL);
>  	if (!ns_list)
>  		return -ENOMEM;
>  
> @@ -1310,7 +1312,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
>  			goto out;
>  
>  		for (j = 0; j < min(nn, 1024U); j++) {
> -			nsid = le32_to_cpu(ns_list[j]);
> +			nsid = le32_to_cpu(ns_list->nsid[j]);
>  			if (!nsid)
>  				goto out;
>  
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index aff71ef..ec2198c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -175,6 +175,7 @@ static inline void _nvme_check_size(void)
>  	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
>  	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != 4096);
>  	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
> +	BUILD_BUG_ON(sizeof(struct nvme_id_ns_list) != 4096);
>  	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
>  	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
>  }
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index a55986f..e9122cf 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -183,6 +183,10 @@ struct nvme_id_ns {
>  	__u8			vs[3712];
>  };
>  
> +struct nvme_id_ns_list {
> +	__le32			nsid[1024];
> +};
> +
>  enum {
>  	NVME_NS_FEAT_THIN	= 1 << 0,
>  	NVME_NS_FLBAS_LBA_MASK	= 0xf,
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

IMHO Christoph's version is more readable.

Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
