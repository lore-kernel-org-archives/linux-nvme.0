From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 30 Jan 2018 17:28:58 +0800
Subject: [PATCH 1/3] nvme: Sync queues on controller resets
In-Reply-To: <20180129235949.26267-1-keith.busch@intel.com>
References: <20180129235949.26267-1-keith.busch@intel.com>
Message-ID: <9ae19844-da78-1421-482c-0a498c55b648@oracle.com>

Hi Keith

Thanks for your patch.
That's really appreciated.

On 01/30/2018 07:59 AM, Keith Busch wrote:
> This patch has the nvme pci driver synchronize request queues to ensure
> that starting up the controller is not racing with a previously running
> timeout handler.
> 
> Reported-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c | 15 ++++++++++++++-
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  |  1 +
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e8104871cbbf..ceb5d72d8c97 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3540,12 +3540,25 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>  	struct nvme_ns *ns;
>  
>  	mutex_lock(&ctrl->namespaces_mutex);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
>  		blk_mq_unquiesce_queue(ns->queue);
> +		blk_mq_kick_requeue_list(ns->queue);
> +	}
>  	mutex_unlock(&ctrl->namespaces_mutex);
>  }
>  EXPORT_SYMBOL_GPL(nvme_start_queues);
>  
> +void nvme_sync_queues(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_ns *ns;
> +
> +	mutex_lock(&ctrl->namespaces_mutex);
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		blk_sync_queue(ns->queue);
> +	mutex_unlock(&ctrl->namespaces_mutex);
> +}
> +EXPORT_SYMBOL_GPL(nvme_sync_queues);
> +
>  int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
>  {
>  	if (!ctrl->ops->reinit_request)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 8e4550fa08f8..e7786bc845fe 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -374,6 +374,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  
>  void nvme_stop_queues(struct nvme_ctrl *ctrl);
>  void nvme_start_queues(struct nvme_ctrl *ctrl);
> +void nvme_sync_queues(struct nvme_ctrl *ctrl);
>  void nvme_kill_queues(struct nvme_ctrl *ctrl);
>  void nvme_unfreeze(struct nvme_ctrl *ctrl);
>  void nvme_wait_freeze(struct nvme_ctrl *ctrl);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6fe7af00a1f4..9e3d7b293509 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2286,6 +2286,7 @@ static void nvme_reset_work(struct work_struct *work)
>  	 */
>  	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
>  		nvme_dev_disable(dev, false);
> +	nvme_sync_queues(&dev->ctrl);

There could be a circular pattern here. Please consider the following scenario:

timeout_work context                    reset_work context
nvme_timeout                            nvme_reset_work
  -> nvme_dev_disable                     -> nvme_sync_queues // hold namespace_mutex
    -> nvme_stop_queues                     -> blk_sync_queue
      -> require namespaces_mutex               -> cancel_work_sync(&q->timeout_work)

On the other hand, the blk_mq_kick_requeue_list() should be also added in nvme_kill_queues
for the case of queue_count < 2

Thanks
Jianchao

>  
>  	/*
>  	 * Introduce RECONNECTING state from nvme-fc/rdma transports to mark the
> 
