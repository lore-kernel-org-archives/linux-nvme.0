From: axboe@fb.com (Jens Axboe)
Date: Tue, 24 Jun 2014 19:38:21 -0600
Subject: [PATCH v9] NVMe: Convert to blk-mq
In-Reply-To: <1403651531-24891-2-git-send-email-m@bjorling.me>
References: <1403651531-24891-1-git-send-email-m@bjorling.me>
 <1403651531-24891-2-git-send-email-m@bjorling.me>
Message-ID: <53AA280D.2030103@fb.com>

On 2014-06-24 17:12, Matias Bj?rling wrote:
> +static int nvme_admin_init_request(void *data, struct request *req,
> +				unsigned int hctx_idx, unsigned int rq_idx,
> +				unsigned int numa_node)
>   {
> -	return DIV_ROUND_UP(depth, 8) + (depth * sizeof(struct nvme_cmd_info));
> +	struct nvme_dev *dev = data;
> +	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
> +	struct nvme_queue *nvmeq = dev->queues[0];
> +
> +	WARN_ON(!nvmeq);
> +	WARN_ON(!cmd);
> +	cmd->nvmeq = nvmeq;
> +	return 0;

Get rid of the WARN_ON(!cmd) - if that should trigger, we'll see the 
obvious oops right after.

> +static int nvme_init_request(void *data, struct request *req,
> +				unsigned int hctx_idx, unsigned int rq_idx,
> +				unsigned int numa_node)
> +{
> +	struct nvme_dev *dev = data;
> +	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
> +	struct nvme_queue *nvmeq = dev->queues[hctx_idx + 1];
> +
> +	WARN_ON(!nvmeq);
> +	WARN_ON(!cmd);
> +	cmd->nvmeq = nvmeq;
> +	return 0;

Ditto

> +/* Admin queue isn't initialized as a request queue. If at some point this
> + * happens anyway, make sure to notify the user */
> +static int nvme_admin_queue_rq(struct blk_mq_hw_ctx *hctx, struct request *req)
>   {
> -	struct nvme_ns *ns = q->queuedata;
> -	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
> -	int result = -EBUSY;
> -
> -	if (!nvmeq) {
> -		bio_endio(bio, -EIO);
> -		return;
> -	}
> -
> -	spin_lock_irq(&nvmeq->q_lock);
> -	if (!nvmeq->q_suspended && bio_list_empty(&nvmeq->sq_cong))
> -		result = nvme_submit_bio_queue(nvmeq, ns, bio);
> -	if (unlikely(result)) {
> -		if (!waitqueue_active(&nvmeq->sq_full))
> -			add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
> -		bio_list_add(&nvmeq->sq_cong, bio);
> -	}
> -
> -	nvme_process_cq(nvmeq);
> -	spin_unlock_irq(&nvmeq->q_lock);
> -	put_nvmeq(nvmeq);
> +	WARN_ON(1);
> +	return BLK_MQ_RQ_QUEUE_ERROR;

That should be a WARN_ON_ONCE(1). In case it does trigger, you don't 
want to see it tons of times, once is enough.

-- 
Jens Axboe
