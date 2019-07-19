From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 19 Jul 2019 13:15:50 -0700
Subject: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
In-Reply-To: <ba6d1a56-8f86-4060-a167-6d67435e1a88@grimberg.me>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
 <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
 <ba6d1a56-8f86-4060-a167-6d67435e1a88@grimberg.me>
Message-ID: <e516395c-7741-af1a-42a9-2bd528b3976c@grimberg.me>


>> [1]:
> Or actually:
> -- 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 76cd3dd8736a..a0e2072fe73e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3576,6 +3576,12 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  ??????? struct nvme_ns *ns, *next;
>  ??????? LIST_HEAD(ns_list);
> 
> +?????? mutex_lock(&ctrl->scan_lock);
> +?????? list_for_each_entry(ns, &ctrl->namespaces, list)
> +?????????????? if (nvme_mpath_clear_current_path(ns))
> +?????????????????????? kblockd_schedule_work(&ns->head->requeue_work);
> +?????? mutex_lock(&ctrl->scan_lock);

This should be mutex_unlock of course...
