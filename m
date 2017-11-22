From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 22 Nov 2017 18:06:52 +0200
Subject: [PATCH v4 2/4] nvme-rdma: don't complete requests before a send
 work request has completed
In-Reply-To: <20171120113101.8292-3-sagi@grimberg.me>
References: <20171120113101.8292-1-sagi@grimberg.me>
 <20171120113101.8292-3-sagi@grimberg.me>
Message-ID: <76a9dd67-c2c1-fe61-9d26-2609340cb97c@mellanox.com>



On 11/20/2017 1:30 PM, Sagi Grimberg wrote:
> In order to guarantee that the HCA will never get an access violation
> (either from invalidated rkey or from iommu) when retrying a send
> operation we must complete a request only when both send completion
> and the nvme cqe has arrived. We need to set the send/recv completions
> flags atomically because we might have more than a single context
> accessing the request concurrently (one is cq irq-poll context and
> the other is user-polling used in IOCB_HIPRI).
> 
> Only then we are safe to invalidate the rkey (if needed), unmap
> the host buffers, and complete the IO.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 85c98589a5e0..9202cfa9300b 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -59,6 +59,9 @@ struct nvme_rdma_request {
>   	struct nvme_request	req;
>   	struct ib_mr		*mr;
>   	struct nvme_rdma_qe	sqe;
> +	union nvme_result	result;
> +	__le16			status;
> +	refcount_t		ref;
>   	struct ib_sge		sge[1 + NVME_RDMA_MAX_INLINE_SEGMENTS];
>   	u32			num_sge;
>   	int			nents;
> @@ -1162,6 +1165,7 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
>   	req->num_sge = 1;
>   	req->inline_data = false;
>   	req->mr->need_inval = false;
> +	refcount_set(&req->ref, 2); /* send and recv completions */
>   
>   	c->common.flags |= NVME_CMD_SGL_METABUF;
>   
> @@ -1198,8 +1202,19 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
>   
>   static void nvme_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
>   {
> -	if (unlikely(wc->status != IB_WC_SUCCESS))
> +	struct nvme_rdma_qe *qe =
> +		container_of(wc->wr_cqe, struct nvme_rdma_qe, cqe);
> +	struct nvme_rdma_request *req =
> +		container_of(qe, struct nvme_rdma_request, sqe);

what will happen if we get here from qe that belongs to async_event 
post_send request (completion with error ) ?
the container_of will be wrong...


> +	struct request *rq = blk_mq_rq_from_pdu(req);
> +
> +	if (unlikely(wc->status != IB_WC_SUCCESS)) {
>   		nvme_rdma_wr_error(cq, wc, "SEND");
> +		return;
> +	}
> +
> +	if (refcount_dec_and_test(&req->ref))
> +		nvme_end_request(rq, req->status, req->result);
