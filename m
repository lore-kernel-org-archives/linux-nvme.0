From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 24 Dec 2015 12:36:01 +0200
Subject: [PATCH 1/3] nvme: synchronize access to ctrl->namespaces
In-Reply-To: <1450952155-8693-2-git-send-email-hch@lst.de>
References: <1450952155-8693-1-git-send-email-hch@lst.de>
 <1450952155-8693-2-git-send-email-hch@lst.de>
Message-ID: <567BCA91.9090709@dev.mellanox.co.il>


> Currently traversal and modification of ctrl->namespaces happens completely
> unsynchronized, which can be fixed by the addition of a simple mutex.

Ha yes, I may have seen strange behavior in this area wrt to
deletes and resets.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b82bbea..e4a6868 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c

Umm, I submitted a patch to move these to the core (which you reviewed
:)). I've not seen any negative feedback on it so far.

Jens, are you planning on taking it? and if you do,
Christoph, would you mind rebasing a top of it?

Otherwise,

Looks good,

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>

> @@ -1907,6 +1907,7 @@ static void nvme_freeze_queues(struct nvme_dev *dev)
>   {
>   	struct nvme_ns *ns;
>
> +	mutex_lock(&dev->ctrl.namespaces_mutex);
>   	list_for_each_entry(ns, &dev->ctrl.namespaces, list) {
>   		blk_mq_freeze_queue_start(ns->queue);
>
> @@ -1917,18 +1918,21 @@ static void nvme_freeze_queues(struct nvme_dev *dev)
>   		blk_mq_cancel_requeue_work(ns->queue);
>   		blk_mq_stop_hw_queues(ns->queue);
>   	}
> +	mutex_unlock(&dev->ctrl.namespaces_mutex);
>   }
>
>   static void nvme_unfreeze_queues(struct nvme_dev *dev)
>   {
>   	struct nvme_ns *ns;
>
> +	mutex_lock(&dev->ctrl.namespaces_mutex);
>   	list_for_each_entry(ns, &dev->ctrl.namespaces, list) {
>   		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
>   		blk_mq_unfreeze_queue(ns->queue);
>   		blk_mq_start_stopped_hw_queues(ns->queue, true);
>   		blk_mq_kick_requeue_list(ns->queue);
>   	}
> +	mutex_unlock(&dev->ctrl.namespaces_mutex);
>   }
>
>   static void nvme_dev_shutdown(struct nvme_dev *dev)
>
