From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 11:17:52 +0300
Subject: [PATCH 1/3] nvme: provide a way to disable nvme mpath per
 subsystem
In-Reply-To: <20180525125322.15398-2-jthumshirn@suse.de>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525125322.15398-2-jthumshirn@suse.de>
Message-ID: <795f42a6-a6c3-e42d-3215-71b36fb7a0d4@grimberg.me>


> @@ -246,3 +246,27 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>   	blk_cleanup_queue(head->disk->queue);
>   	put_disk(head->disk);
>   }
> +
> +int nvme_mpath_change_personality(struct nvme_subsystem *subsys)
> +{
> +	struct nvme_ctrl *ctrl;
> +	int ret = 0;
> +
> +restart:
> +	mutex_lock(&subsys->lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (!list_empty(&ctrl->namespaces)) {
> +			mutex_unlock(&subsys->lock);
> +			nvme_remove_namespaces(ctrl);

This looks completely broken. Any of these namespaces can have an
active handle on it.
