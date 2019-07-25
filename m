From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 12:43:02 -0600
Subject: [PATCH] nvme: fix controller removal race with scan work
In-Reply-To: <20190725183758.3318-1-sagi@grimberg.me>
References: <20190725183758.3318-1-sagi@grimberg.me>
Message-ID: <5f04998a-5a79-f05b-e64a-3029d919c81c@deltatee.com>



On 2019-07-25 12:37 p.m., Sagi Grimberg wrote:
> ---
>  drivers/nvme/host/core.c      | 11 +++++++++++
>  drivers/nvme/host/multipath.c | 35 +++++++++++++++++++++++++++++------
>  drivers/nvme/host/nvme.h      |  2 +-
>  3 files changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1c2863216082..bb5cf7e80969 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3577,6 +3577,17 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	struct nvme_ns *ns, *next;
>  	LIST_HEAD(ns_list);
>  
> +	/*
> +	 * make sure to requeue I/O to all namespaces as these
> +	 * might result from the scan itself and must complete
> +	 * for the scan_work to make progress
> +	 */
> +	mutex_lock(&ctrl->scan_lock);
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		if (nvme_mpath_clear_current_path(ns))
> +			kblockd_schedule_work(&ns->head->requeue_work);
> +	mutex_unlock(&ctrl->scan_lock);

If you try to compile this patch with multipath disabled I think you'll
find this doesn't work seeing 'requeue_work' only exists with
CONFIG_NVME_MULTIPATH set.

My solution to this is here:

https://github.com/sbates130272/linux-p2pmem/commit/0c2fbe1abd5e799cd42fc7f55ee0a7f05df8ac4a.patch

Logan
