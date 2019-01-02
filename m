From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 2 Jan 2019 16:04:12 +0200
Subject: [PATCH] nvmet-rdma: fix null dereference under heavy load
In-Reply-To: <20190102105103.19850-1-rajur@chelsio.com>
References: <20190102105103.19850-1-rajur@chelsio.com>
Message-ID: <ef4b9d98-f55d-8597-7fa0-c4e49e7e3b0c@mellanox.com>


On 1/2/2019 12:51 PM, Raju Rangoju wrote:
> Under heavy load if we don't have any pre-allocated rsps left, we
> dynamically allocate a rsp, but we are not actually allocating memory
> for nvme_completion (rsp->req.rsp). In such a case, accessing pointer
> fields (req->rsp->status) in nvmet_req_init() will result in crash.
>
> To fix this, allocate the memory for nvme_completion by calling
> nvmet_rdma_alloc_rsp()
>
> fixes 8407879c(nvmet-rdma: fix possible bogus dereference under heavy
> load)
>
> Signed-off-by: Raju Rangoju <rajur at chelsio.com>
> ---
>   drivers/nvme/target/rdma.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index a8d23eb80192..3d02e41868b1 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -139,6 +139,10 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
>   static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc);
>   static void nvmet_rdma_qp_event(struct ib_event *event, void *priv);
>   static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue);
> +static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
> +				struct nvmet_rdma_rsp *r);
> +static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
> +				struct nvmet_rdma_rsp *r);
>   
>   static const struct nvmet_fabrics_ops nvmet_rdma_ops;
>   
> @@ -173,6 +177,7 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
>   {
>   	struct nvmet_rdma_rsp *rsp;
>   	unsigned long flags;
> +	int ret = -EINVAL;

this integer can be used inside the scope of the "if" and also maybe 
redundant (Sagi/Christoph any preferences ?)

anyway please use "unlikely" in this datapath flow condition for efficiency.

otherwise, looks good.

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>




>   
>   	spin_lock_irqsave(&queue->rsps_lock, flags);
>   	rsp = list_first_entry_or_null(&queue->free_rsps,
> @@ -182,9 +187,15 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
>   	spin_unlock_irqrestore(&queue->rsps_lock, flags);
>   
>   	if (unlikely(!rsp)) {
> -		rsp = kmalloc(sizeof(*rsp), GFP_KERNEL);
> +		rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
>   		if (unlikely(!rsp))
>   			return NULL;
> +		ret = nvmet_rdma_alloc_rsp(queue->dev, rsp);
> +		if (ret) {
> +			kfree(rsp);
> +			return NULL;
> +		}
> +
>   		rsp->allocated = true;
>   	}
>   
> @@ -197,6 +208,7 @@ nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
>   	unsigned long flags;
>   
>   	if (unlikely(rsp->allocated)) {
> +		nvmet_rdma_free_rsp(rsp->queue->dev, rsp);
>   		kfree(rsp);
>   		return;
>   	}
