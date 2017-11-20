From: hch@lst.de (Christoph Hellwig)
Date: Mon, 20 Nov 2017 12:16:40 +0100
Subject: [PATCH v2 2/3] nvme-rdma: don't complete requests before a
 send work request has completed
In-Reply-To: <df9c9545-7c00-328b-9f98-535d8e889715@grimberg.me>
References: <20171108100616.26605-1-sagi@grimberg.me>
 <20171108100616.26605-3-sagi@grimberg.me> <20171109092110.GB16966@lst.de>
 <0f368bc9-2e9f-4008-316c-46b85661a274@grimberg.me>
 <20171120083130.GC27552@lst.de>
 <384d8a51-aa2f-5954-c9fd-a0c88d7e5364@grimberg.me>
 <20171120084102.GA28456@lst.de>
 <58bdc9c0-f98e-9d9f-f81e-fbed572f922e@grimberg.me>
 <20171120104921.GA31309@lst.de>
 <df9c9545-7c00-328b-9f98-535d8e889715@grimberg.me>
Message-ID: <20171120111640.GA32043@lst.de>

> +       if (wc->wc_flags & IB_WC_WITH_INVALIDATE) {
> +               if (unlikely(wc->ex.invalidate_rkey == req->mr->rkey)) {

The == here should be a != I think.

> +                       dev_err(queue->ctrl->ctrl.device,
> +                               "Bogus remote invalidation for rkey %#x\n",
> +                               req->mr->rkey);
> +                       nvme_rdma_error_recovery(queue->ctrl);
> +               }
>                 req->mr->need_inval = false;
> -               refcount_dec(&req->ref);
>         } else if (req->mr->need_inval) {
>                 ret = nvme_rdma_inv_rkey(queue, req);
>                 if (unlikely(ret < 0)) {
> @@ -1347,6 +1349,8 @@ static int nvme_rdma_process_nvme_rsp(struct 
> nvme_rdma_queue *queue,
>                                 req->mr->rkey, ret);
>                         nvme_rdma_error_recovery(queue->ctrl);
>                 }
> +               /* return here as we can't really end the request */
> +               return 0;

Maybe replace the comment with

		/* the local invalidation completion will end the request */

Otherwise this looks fine to me.
