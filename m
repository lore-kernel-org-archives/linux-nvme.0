From: keith.busch@intel.com (Keith Busch)
Date: Fri, 27 May 2016 09:28:36 -0400
Subject: [PATCHv2] NVMe: Fix removal in case of active namespace list
 scanning method
In-Reply-To: <1464344983-19521-1-git-send-email-sunad.s@samsung.com>
References: <1464344983-19521-1-git-send-email-sunad.s@samsung.com>
Message-ID: <20160527132834.GA19990@localhost.localdomain>

On Fri, May 27, 2016@03:59:43PM +0530, Sunad Bhandary S wrote:
>  static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
>  {
>  	struct nvme_ns *ns;
> @@ -1497,7 +1508,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
>  	for (i = 0; i < num_lists; i++) {
>  		ret = nvme_identify_ns_list(ctrl, prev, ns_list);
>  		if (ret)
> -			goto out;
> +			goto free;
>  
>  		for (j = 0; j < min(nn, 1024U); j++) {
>  			nsid = le32_to_cpu(ns_list[j]);
> @@ -1515,13 +1526,14 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
>  		nn -= j;
>  	}
>   out:
> +	nvme_remove_invalid_namespaces(ctrl, prev);
> + free:

We don't want to remove the namespaces on error here. That could remove
valid, in use namespaces: if nvme_identify_ns_list fails (maybe controller
just doesn't support that identify mode), we do the sequential scanning.

Just leave the 'goto free' alone, and call nvme_remove_invalid_namespaces
only on success.
