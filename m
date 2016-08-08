From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 8 Aug 2016 14:32:36 +0300
Subject: [RFC 1/2] nvme-rdma: Matching rdma WC to rdma queue according to
 WC QP
In-Reply-To: <1470654019-717-1-git-send-email-roysh@mellanox.com>
References: <1470654019-717-1-git-send-email-roysh@mellanox.com>
Message-ID: <95bbeb83-15d1-293d-ba51-87515ed45085@grimberg.me>



On 08/08/16 14:00, Roy Shterman wrote:
> Today when assiging rdma_nvme_queue to rdma work complition we use

s/complition/completion

> cq_context which is passed as queue pointer when creating the CQ.
> In case we will want to aggregate few QP to one CQ this method will
> not work, hence it will be better if we will use QP context instead.
>
> Signed-off-by: Roy Shterman <roysh at mellanox.com>
> ---
>  drivers/nvme/host/rdma.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 278551b..98a0ab5 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -277,6 +277,7 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
>  	init_attr.qp_type = IB_QPT_RC;
>  	init_attr.send_cq = queue->ib_cq;
>  	init_attr.recv_cq = queue->ib_cq;
> +	init_attr.qp_context = queue;
>
>  	ret = rdma_create_qp(queue->cm_id, dev->pd, &init_attr);
>
> @@ -803,7 +804,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
>  static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
>  		const char *op)
>  {
> -	struct nvme_rdma_queue *queue = cq->cq_context;
> +	struct nvme_rdma_queue *queue = wc->qp->qp_context;
>  	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
>
>  	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
> @@ -1163,7 +1164,7 @@ static int __nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc, int tag)
>  {
>  	struct nvme_rdma_qe *qe =
>  		container_of(wc->wr_cqe, struct nvme_rdma_qe, cqe);
> -	struct nvme_rdma_queue *queue = cq->cq_context;
> +	struct nvme_rdma_queue *queue = wc->qp->qp_context;
>  	struct ib_device *ibdev = queue->device->dev;
>  	struct nvme_completion *cqe = qe->data;
>  	const size_t len = sizeof(struct nvme_completion);

On its own, the patch is useless. I don't see a point getting it
in without the actual purpose its designed to allow.
Moreover, CQ sharing involves allocating large CQs (so we have room for
multiple QPs). This makes much better sense for the target driver
(which serves multiple hosts) but a little less for the host driver.

For the host driver, we'll need a proper performance justification to
sacrifice pre-allocation of large CQs (we'll one for the target as
well, but it won't be hard to show in real-life scenarios).
