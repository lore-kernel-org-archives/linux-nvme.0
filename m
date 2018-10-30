From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Oct 2018 11:39:14 -0700
Subject: [PATCH 2/3] nvme-multipath: Select paths based on NUMA locality
In-Reply-To: <20181026125718.122767-3-hare@suse.de>
References: <20181026125718.122767-1-hare@suse.de>
 <20181026125718.122767-3-hare@suse.de>
Message-ID: <0e4c5103-8d31-3b30-a1d4-f8fe4d6a0da3@grimberg.me>


> @@ -163,8 +164,11 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
>   
>   	if (!found)
>   		found = fallback;
> -	if (found)
> +	if (found) {
> +		dev_dbg(disk_to_dev(head->disk), "none: node %d path %s\n",
> +			node, found->disk->disk_name);

none?

>   		rcu_assign_pointer(head->current_path[node], found);
> +	}
>   	return found;
>   }
>   
> @@ -528,6 +532,7 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
>   		nvme_mpath_set_live(ns);
>   		mutex_unlock(&ns->head->lock);
>   	}
> +	nvme_mpath_clear_current_path(ns);

Didn't I see this in a different patch from keith?

Please document why this is added.
