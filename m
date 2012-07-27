From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 27 Jul 2012 14:00:59 -0400
Subject: [PATCH] NVMe: Do not set IO queue depth beyond device max
In-Reply-To: <1343403244-21334-1-git-send-email-keith.busch@intel.com>
References: <1343403244-21334-1-git-send-email-keith.busch@intel.com>
Message-ID: <20120727180059.GL22985@linux.intel.com>

On Fri, Jul 27, 2012@09:34:04AM -0600, Keith Busch wrote:
> Set the depth for IO queues to the device's maximum supported queue
> entries if the requested depth exceeds the device's capabilities.

Thanks, applied with a couple of fixups.

>  	struct device *dmadev = &dev->pci_dev->dev;
> -	unsigned extra = (depth / 8) + (depth * sizeof(struct nvme_cmd_info));
> +	unsigned extra = DIV_ROUND_UP(depth, 8) + (depth * sizeof(
> +							struct nvme_cmd_info));

Better to split like so:

	unsigned extra = DIV_ROUND_UP(depth, 8) + (depth *
						sizeof(struct nvme_cmd_info));

(some might argue for either:

	unsigned extra = DIV_ROUND_UP(depth, 8);
	extra += depth * sizeof(struct nvme_cmd_info);

or

	unsigned extra;

	extra = DIV_ROUND_UP(depth, 8) + (depth * sizeof(struct nvme_cmd_info));

but I prefer the way I've done it :-)

>  };
>  
> +#define NVME_CAP_MQES(cap)	(cap & 0xffff)
>  #define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
>  #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
>  

This hunk failed to apply because of the added definition for NVME_CAP_MPSMIN
which was added in a patch from you I applied yesterday :-)  So I fixed it.
