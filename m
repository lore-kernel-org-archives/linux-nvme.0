From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 22 Nov 2017 18:45:26 +0200
Subject: [PATCH v4 3/4] nvme-rdma: wait for local invalidation before
 completing a request
In-Reply-To: <20171120113101.8292-4-sagi@grimberg.me>
References: <20171120113101.8292-1-sagi@grimberg.me>
 <20171120113101.8292-4-sagi@grimberg.me>
Message-ID: <35983721-ace6-7da2-eacf-951fbd556da4@mellanox.com>


> @@ -1337,8 +1335,19 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
>   	req->result = cqe->result;
>   
>   	if ((wc->wc_flags & IB_WC_WITH_INVALIDATE) &&
> -	    wc->ex.invalidate_rkey == req->mr->rkey)
> +	    wc->ex.invalidate_rkey == req->mr->rkey) {
>   		req->mr->need_inval = false;
> +	} else if (req->mr->need_inval) {
> +		ret = nvme_rdma_inv_rkey(queue, req);
> +		if (unlikely(ret < 0)) {
> +			dev_err(queue->ctrl->ctrl.device,
> +				"Queueing INV WR for rkey %#x failed (%d)\n",
> +				req->mr->rkey, ret);
> +			nvme_rdma_error_recovery(queue->ctrl);
> +		}
> +		/* the local invalidation completion will end the request */

inv completion or nvme_rdma_error_recovery will end the request...

> +		return 0;
> +	}
>   
>   	if (refcount_dec_and_test(&req->ref)) {
>   		if (rq->tag == tag)
> 
