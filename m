From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Dec 2018 17:23:13 -0800
Subject: [PATCH 1/2] nvmet-rdma: Fix response use after free
In-Reply-To: <1543852205-776-1-git-send-email-israelr@mellanox.com>
References: <1543852205-776-1-git-send-email-israelr@mellanox.com>
Message-ID: <97bc61b4-d5b7-6dc9-668e-a3900a08f993@grimberg.me>


> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 3f7971d3..732806a 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -529,6 +529,7 @@ static void nvmet_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
>   {
>   	struct nvmet_rdma_rsp *rsp =
>   		container_of(wc->wr_cqe, struct nvmet_rdma_rsp, send_cqe);
> +	struct nvmet_rdma_queue *queue = rsp->queue;

Didn't you mean:
+	struct nvmet_rdma_queue *queue = cq->cq_context;

I'm not sure what this is solving otherwise...

>   
>   	nvmet_rdma_release_rsp(rsp);
>   
> @@ -536,7 +537,7 @@ static void nvmet_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
>   		     wc->status != IB_WC_WR_FLUSH_ERR)) {
>   		pr_err("SEND for CQE 0x%p failed with status %s (%d).\n",
>   			wc->wr_cqe, ib_wc_status_msg(wc->status), wc->status);
> -		nvmet_rdma_error_comp(rsp->queue);
> +		nvmet_rdma_error_comp(queue);
>   	}
>   }
>   
> 
