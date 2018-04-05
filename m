From: hch@lst.de (Christoph Hellwig)
Date: Thu, 5 Apr 2018 10:54:38 +0200
Subject: [PATCH] nvme: fix flush dependency in delete controller flow
In-Reply-To: <20180402123727.3961-1-nitzanc@mellanox.com>
References: <20180402123727.3961-1-nitzanc@mellanox.com>
Message-ID: <20180405085438.GC2286@lst.de>

On Mon, Apr 02, 2018@12:37:27PM +0000, Nitzan Carmi wrote:
> nvme_delete_ctrl queues a work on a MEM_RECLAIM queue
> (nvme_delete_wq), which eventually calls cleanup_srcu_struct,
> which in turn flushes a delayed work from an !MEM_RECLAIM
> queue. This is unsafe as we might trigger deadlocks under
> severe memory pressure.
> 
> Fix this by moving the cleanups to a seperate work over
> the safe !MEM_RECLAIM system_wq.

This seems like an odd workaround.  It seems like not allowing
cleanup_srcu_struct from mem reclaim wqs is a really odd API
issue.

Paul, anything we can do there?

> Fixes: ed754e5dee ("nvme: track shared namespaces")
> Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>  drivers/nvme/host/core.c | 12 ++++++++++--
>  drivers/nvme/host/nvme.h |  1 +
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 75f3e4c..7fc5d9d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -362,6 +362,14 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  }
>  EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
>  
> +static void nvme_free_ns_head_work(struct work_struct *work) {
> +	struct nvme_ns_head *head =
> +		container_of(work, struct nvme_ns_head, free_work);
> +
> +	cleanup_srcu_struct(&head->srcu);
> +	kfree(head);
> +}
> +
>  static void nvme_free_ns_head(struct kref *ref)
>  {
>  	struct nvme_ns_head *head =
> @@ -370,8 +378,7 @@ static void nvme_free_ns_head(struct kref *ref)
>  	nvme_mpath_remove_disk(head);
>  	ida_simple_remove(&head->subsys->ns_ida, head->instance);
>  	list_del_init(&head->entry);
> -	cleanup_srcu_struct(&head->srcu);
> -	kfree(head);
> +	queue_work(system_wq, &head->free_work);
>  }
>  
>  static void nvme_put_ns_head(struct nvme_ns_head *head)
> @@ -3099,6 +3106,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  		goto out_free_head;
>  	head->instance = ret;
>  	INIT_LIST_HEAD(&head->list);
> +	INIT_WORK(&head->free_work, nvme_free_ns_head_work);
>  	init_srcu_struct(&head->srcu);
>  	head->subsys = ctrl->subsys;
>  	head->ns_id = nsid;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 178aced..f443608 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -270,6 +270,7 @@ struct nvme_ns_head {
>  	spinlock_t		requeue_lock;
>  	struct work_struct	requeue_work;
>  #endif
> +	struct work_struct	free_work;
>  	struct list_head	list;
>  	struct srcu_struct      srcu;
>  	struct nvme_subsystem	*subsys;
> -- 
> 1.8.2.3
---end quoted text---
