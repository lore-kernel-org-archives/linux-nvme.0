From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 28 Jun 2016 01:31:37 -0700
Subject: [PATCHv2 1/3] nvme: Remove RCU namespace protection
In-Reply-To: <1466702946-13065-2-git-send-email-keith.busch@intel.com>
References: <1466702946-13065-1-git-send-email-keith.busch@intel.com>
 <1466702946-13065-2-git-send-email-keith.busch@intel.com>
Message-ID: <20160628083137.GA32618@infradead.org>

> +static struct nvme_ns *nvme_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)

Can you call this nvme_find_get_ns?  A plain get is usually just
a wrapper around kref_get.

>   done:
> +	mutex_lock(&ctrl->namespaces_mutex);
>  	list_sort(NULL, &ctrl->namespaces, ns_cmp);
>  	mutex_unlock(&ctrl->namespaces_mutex);

This now leaves the list unordered between lock drops (actually we
already had that issue with the RCU conversion).  I think we just need
to do an already sorted insert, which shouldn't be too hard.

> @@ -1656,10 +1662,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	if (ctrl->state == NVME_CTRL_DEAD)
>  		nvme_kill_queues(ctrl);
>  
> -	mutex_lock(&ctrl->namespaces_mutex);
>  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
>  		nvme_ns_remove(ns);
> -	mutex_unlock(&ctrl->namespaces_mutex);

And this is the scary one - it does an unprotected
list_for_each_entry_safe, and nvme_remove_namespaces isn't even called
from the scan workqueue.

I think this needs to be something like:

	mutex_lock(&ctrl->namespaces_mutex);
	list_splice_init(&ctrl->namespaces, &tmp);
	mutex_unlock(&ctrl->namespaces_mutex);

	list_for_each_entry_safe(ns, next, &tmp, list) {
		..

		nvme_ns_remove(ns);

> +	mutex_lock(&ctrl->namespaces_mutex);
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
>  		if (!kref_get_unless_zero(&ns->kref))
>  			continue;

> @@ -1848,7 +1852,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>  
>  		nvme_put_ns(ns);

The get/put pair here can go away now as there will always be at
least one reference to the ns if it is on the ->namespaces list.
