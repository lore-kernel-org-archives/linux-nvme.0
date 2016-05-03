From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 3 May 2016 01:01:40 -0700
Subject: [PATCH-4.7 2/3] NVMe: Short-cut removal on surprise hot-unplug
In-Reply-To: <1462209128-12376-3-git-send-email-keith.busch@intel.com>
References: <1462209128-12376-1-git-send-email-keith.busch@intel.com>
 <1462209128-12376-3-git-send-email-keith.busch@intel.com>
Message-ID: <20160503080140.GB31768@infradead.org>

> @@ -1584,6 +1593,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_ns *ns, *next;
>  
> +	if (ctrl->state == NVME_CTRL_DEAD)
> +		nvme_kill_queues(ctrl);
> +
>  	mutex_lock(&ctrl->namespaces_mutex);
>  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
>  		nvme_ns_remove(ns);

Not happy about so much magic.. At least add comments explaining why
you're doing this, and that it's just an optimization.
