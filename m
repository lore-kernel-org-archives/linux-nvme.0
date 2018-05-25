From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 14:42:09 +0200
Subject: [PATCHv3 1/9] nvme: Sync request queues on reset
In-Reply-To: <20180524203500.14081-2-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-2-keith.busch@intel.com>
Message-ID: <20180525124209.GD23463@lst.de>

On Thu, May 24, 2018@02:34:52PM -0600, Keith Busch wrote:
> This patch fixes races that occur with simultaneous controller
> resets

Wait..  How do we end up with simultaneous controller resets?  We
not only have the NVME_CTRL_RESETTING resetting state, but also
execute all resets from ctrl->reset_work, so they are implicitly
single threaded.

> by synchronizing request queues prior to initializing the
> controller. Without this, a timeout thread may attempt disabling a
> controller at the same time as we're trying to enable it.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c | 21 +++++++++++++++++++--
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  | 11 +++++++----
>  3 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dc8aa2c1c22a..33034e469bbc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3469,6 +3469,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(nvme_init_ctrl);
>  
> +static void nvme_start_queue(struct nvme_ns *ns)
> +{
> +	blk_mq_unquiesce_queue(ns->queue);
> +	blk_mq_kick_requeue_list(ns->queue);
> +}
> +
>  /**
>   * nvme_kill_queues(): Ends all namespace queues
>   * @ctrl: the dead controller that needs to end
> @@ -3497,7 +3503,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>  		blk_set_queue_dying(ns->queue);
>  
>  		/* Forcibly unquiesce queues to avoid blocking dispatch */
> -		blk_mq_unquiesce_queue(ns->queue);
> +		nvme_start_queue(ns);
>  	}
>  	up_read(&ctrl->namespaces_rwsem);
>  }
> @@ -3567,11 +3573,22 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>  
>  	down_read(&ctrl->namespaces_rwsem);
>  	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		blk_mq_unquiesce_queue(ns->queue);
> +		nvme_start_queue(ns);
>  	up_read(&ctrl->namespaces_rwsem);

The whole kick the requeue list when starting queues bit seems like
it should be a separate patch.

>  }
>  EXPORT_SYMBOL_GPL(nvme_start_queues);
>  
> +void nvme_sync_queues(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_ns *ns;
> +
> +	down_read(&ctrl->namespaces_rwsem);
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		blk_sync_queue(ns->queue);
> +	up_read(&ctrl->namespaces_rwsem);
> +}
> +EXPORT_SYMBOL_GPL(nvme_sync_queues);
> +
>  int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
>  {
>  	if (!ctrl->ops->reinit_request)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ec6e4acc4d48..4f43918cd902 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -403,6 +403,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
>  void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  		volatile union nvme_result *res);
>  
> +void nvme_sync_queues(struct nvme_ctrl *ctrl);
>  void nvme_stop_queues(struct nvme_ctrl *ctrl);
>  void nvme_start_queues(struct nvme_ctrl *ctrl);
>  void nvme_kill_queues(struct nvme_ctrl *ctrl);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 917e1714f7d9..9da28e10d942 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2317,11 +2317,14 @@ static void nvme_reset_work(struct work_struct *work)
>  		goto out;
>  
>  	/*
> -	 * If we're called to reset a live controller first shut it down before
> -	 * moving on.
> +	 * Ensure there are no timeout work in progress prior to forcefully
> +	 * disabling the queue. There is no harm in disabling the device even
> +	 * when it was already disabled, as this will forcefully reclaim any
> +	 * IOs that are stuck due to blk-mq's timeout handling that prevents
> +	 * timed out requests from completing.
>  	 */
> -	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
> -		nvme_dev_disable(dev, false);
> +	nvme_sync_queues(&dev->ctrl);
> +	nvme_dev_disable(dev, false);

And this part also makes sense to me, but I don't really understand
how it relates to the commit message.
