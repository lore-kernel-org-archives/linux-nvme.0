From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 27 Jun 2018 14:49:14 -0600
Subject: [PATCH 1/1] nvme: Ensure forward progress during Admin passthru
In-Reply-To: <20180627202741.GF9361@localhost.localdomain>
References: <20180622195914.18575-1-scott.bauer@intel.com>
 <20180622195914.18575-2-scott.bauer@intel.com>
 <20180627191241.GE9361@localhost.localdomain>
 <20180627190137.GA9697@sbauer-Z170X-UD5>
 <20180627202741.GF9361@localhost.localdomain>
Message-ID: <20180627204914.GA10657@localhost.localdomain>

On Wed, Jun 27, 2018@02:27:41PM -0600, Keith Busch wrote:
>  static void nvme_update_formats(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_ns *ns, *next;
> -	LIST_HEAD(rm_list);
>  
> -	down_write(&ctrl->namespaces_rwsem);
> +	down_read(&ctrl->namespaces_rwsem);
>  	list_for_each_entry(ns, &ctrl->namespaces, list) {
> -		if (ns->disk && nvme_revalidate_disk(ns->disk)) {
> -			list_move_tail(&ns->list, &rm_list);
> -		}
> +		if (ns->disk && nvme_revalidate_disk(ns->disk))
> +			if (test_bit(NVME_NS_DEAD, &ns->flags))
> +				set_capacity(disk, 0);

Meant to be "!test_and_set_bit(...)" ... and needs to do a few other
things on top of setting capacity to 0, like blk_set_queue_dying. Maybe
just turn the inner loop of nvme_kill_queues() into a function call so
this path can reuse it.
