From: keith.busch@intel.com (Keith Busch)
Date: Wed, 6 Jan 2016 15:44:14 +0000
Subject: [PATCHv3 4/5] NVMe: IO queue deletion re-write
In-Reply-To: <20160106130419.GA23245@infradead.org>
References: <1451923859-14187-1-git-send-email-keith.busch@intel.com>
 <1451923859-14187-5-git-send-email-keith.busch@intel.com>
 <20160106130419.GA23245@infradead.org>
Message-ID: <20160106154414.GD15113@localhost.localdomain>

On Wed, Jan 06, 2016@05:04:19AM -0800, Christoph Hellwig wrote:
> This is my counter-suggestion to the requeue abuse:
> 
> simply do two passes of your algorithm, one for the SQs, one for the
> CQs.  Patch relative to the whole series below:

Yes, thanks, this looks great!

Just a nitpick, I think it'd look better semantically to have
nvme_disable_io_queues handle switching the opcodes instead of having
to call it twice, but this is fine as-is.

Acked-by: Keith Busch <keith.busch at intel.com>
 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3f536c2..4f3d1e3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -154,7 +154,6 @@ struct nvme_queue {
>  	u16 qid;
>  	u8 cq_phase;
>  	u8 cqe_seen;
> -	struct nvme_delete_queue dq;
>  };
>  
>  /*
> @@ -1587,57 +1586,52 @@ static void nvme_dev_scan(struct work_struct *work)
>  
>  static void nvme_del_queue_end(struct request *req, int error)
>  {
> -	unsigned long flags;
>  	struct nvme_queue *nvmeq = req->end_io_data;
>  
>  	blk_mq_free_request(req);
> -
> -	spin_lock_irqsave(&nvmeq->q_lock, flags);
> -	nvme_process_cq(nvmeq);
> -	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
> -
>  	complete(&nvmeq->dev->ioq_wait);
>  }
>  
> -static void nvme_del_sq_end(struct request *req, int error)
> +static void nvme_del_cq_end(struct request *req, int error)
>  {
>  	struct nvme_queue *nvmeq = req->end_io_data;
>  
> -	if (error) {
> -		nvme_del_queue_end(req, error);
> -		return;
> -	}
> +	if (!error) {
> +		unsigned long flags;
>  
> -	nvmeq->dq.opcode = nvme_admin_delete_cq;
> -	req->end_io = nvme_del_queue_end;
> +		spin_lock_irqsave(&nvmeq->q_lock, flags);
> +		nvme_process_cq(nvmeq);
> +		spin_unlock_irqrestore(&nvmeq->q_lock, flags);
> +	}
>  
> -	/* Must requeue. This callback occurs in irq w/ q_lock held */
> -	nvme_requeue_req(req);
> +	nvme_del_queue_end(req, error);
>  }
>  
> -static int nvme_delete_queue(struct nvme_queue *nvmeq, struct request_queue *q)
> +static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
>  {
> +	struct request_queue *q = nvmeq->dev->ctrl.admin_q;
>  	struct request *req;
> +	struct nvme_command cmd;
>  
> -	req = nvme_alloc_request(q, (struct nvme_command *)&nvmeq->dq,
> -							BLK_MQ_REQ_NOWAIT);
> +	memset(&cmd, 0, sizeof(cmd));
> +	cmd.delete_queue.opcode = nvme_admin_delete_sq;
> +	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
> +
> +	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT);
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  
> -	memset(&nvmeq->dq, 0, sizeof(nvmeq->dq));
> -	nvmeq->dq.opcode = nvme_admin_delete_sq;
> -	nvmeq->dq.qid = cpu_to_le16(nvmeq->qid);
> -
> -	req->end_io_data = nvmeq;
>  	req->timeout = ADMIN_TIMEOUT;
> +	req->end_io_data = nvmeq;
>  
> -	blk_execute_rq_nowait(q, NULL, req, false, nvme_del_sq_end);
> +	blk_execute_rq_nowait(q, NULL, req, false,
> +			opcode == nvme_admin_delete_cq ?
> +				nvme_del_cq_end : nvme_del_queue_end);
>  	return 0;
>  }
>  
> -static void nvme_disable_io_queues(struct nvme_dev *dev)
> +static int nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
>  {
> -	struct request_queue *q = dev->ctrl.admin_q;
>  	int i = dev->queue_count - 1, sent = 0;
>  	unsigned long timeout;
>  
> @@ -1648,17 +1642,19 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
>  		struct nvme_queue *nvmeq = dev->queues[i];
>  
>  		nvme_suspend_queue(nvmeq);
> -		if (nvme_delete_queue(nvmeq, q))
> +		if (nvme_delete_queue(nvmeq, opcode))
>  			break;
>  		++sent;
>  	}
>  	while (sent--) {
>  		timeout = wait_for_completion_io_timeout(&dev->ioq_wait, timeout);
>  		if (timeout == 0)
> -			return;
> +			return -EIO;
>  		if (i)
>  			goto retry;
>  	}
> +
> +	return 0;
>  }
>  
>  /*
> @@ -1834,7 +1830,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  			nvme_suspend_queue(nvmeq);
>  		}
>  	} else {
> -		nvme_disable_io_queues(dev);
> +		if (!nvme_disable_io_queues(dev, nvme_admin_delete_sq))
> +			nvme_disable_io_queues(dev, nvme_admin_delete_cq);
>  		nvme_disable_admin_queue(dev, shutdown);
>  	}
>  	nvme_dev_unmap(dev);
