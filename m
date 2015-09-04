From: keith.busch@intel.com (Keith Busch)
Date: Fri, 4 Sep 2015 17:49:18 +0000 (UTC)
Subject: [PATCH] NVMe: Use namespace list for scanning device
In-Reply-To: <1441386733-5554-1-git-send-email-keith.busch@intel.com>
References: <1441386733-5554-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.LNX.2.00.1509041747240.23840@localhost.lm.intel.com>

On Fri, 4 Sep 2015, Keith Busch wrote:
> +static int nvme_scan_ns_list(struct nvme_dev *dev, int nn)
> +{
> +	int i, j, k, ret = 0;
> +	struct nvme_ns *ns;
> +	u32 *ns_list, nsid, prev = 0;
> +	unsigned num_lists = DIV_ROUND_UP(nn, 1024);
> +
> +	ns_list = kmalloc(0x1000, GFP_KERNEL);
> +	if (!*ns_list)
> +		return -ENOMEM;

code copy-paste fail... That should be

 	if (!ns_list)
 		return -ENOMEM;

Will resend.
