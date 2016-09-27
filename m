From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 27 Sep 2016 11:31:03 -0500
Subject: [PATCH 9/9] [RFC] nvme: Fix a race condition
In-Reply-To: <9c372b04-a194-58c4-a64f-b155b52a5244@sandisk.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
 <9c372b04-a194-58c4-a64f-b155b52a5244@sandisk.com>
Message-ID: <013c01d218dc$8a5406c0$9efc1440$@opengridcomputing.com>

> @@ -2079,11 +2075,15 @@ EXPORT_SYMBOL_GPL(nvme_kill_queues);
>  void nvme_stop_queues(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_ns *ns;
> +	struct request_queue *q;
> 
>  	mutex_lock(&ctrl->namespaces_mutex);
>  	list_for_each_entry(ns, &ctrl->namespaces, list) {
> -		blk_mq_cancel_requeue_work(ns->queue);
> -		blk_mq_stop_hw_queues(ns->queue);
> +		q = ns->queue;
> +		blk_quiesce_queue(q);
> +		blk_mq_cancel_requeue_work(q);
> +		blk_mq_stop_hw_queues(q);
> +		blk_resume_queue(q);
>  	}
>  	mutex_unlock(&ctrl->namespaces_mutex);

Hey Bart, should nvme_stop_queues() really be resuming the blk queue?
