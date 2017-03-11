From: rajur@chelsio.com (Raju  Rangoju)
Date: Sat, 11 Mar 2017 08:29:20 +0000
Subject: nvmet: race condition while CQE are getting processed
 concurrently with the DISCONNECTED event
In-Reply-To: <7c08d54c-7a2d-74dd-79df-807113b032c3@grimberg.me>
References: <CY1PR12MB07747089AFFCB6115BBCF5ECBC210@CY1PR12MB0774.namprd12.prod.outlook.com>,
 <7c08d54c-7a2d-74dd-79df-807113b032c3@grimberg.me>
Message-ID: <CY1PR12MB07742826168C26FC8462D893BC230@CY1PR12MB0774.namprd12.prod.outlook.com>


Hi Sagi,


This patch looks good. I was able to run the test overnight without any issues.
Please see my comments inline.


-Thanks




From: Sagi Grimberg <sagi@grimberg.me>
Sent: Thursday, March 9, 2017 5:15 PM
To: Raju Rangoju; hch at lst.de
Cc: SWise OGC; linux-nvme; Yi Zhang
Subject: Re: nvmet: race condition while CQE are getting processed concurrently with the DISCONNECTED event
?    
> Hi Sagi,

Hi Raju (CC'ing Yi)

>
> I had tried each of the below patches individually,? issue is still seen with both the patches.
>
> with patch #1, from the dmesg I see that NULL pointer dereference issue is hit before the 3,4,5 (see below) were finished successfully for that queue
>
> Where :
> 1. rdma_diconnect
> 2. nvmet_sq_destroy
> 3. ib_drain_qp
> 4. rdma_destroy_qp
> 5. ib_free_cq (which flushes the cq worker)

I took a deeper look here, and I think that the root cause has nothing
to do with the 2 (still useful) patches I sent.?

< RAJU > Yes, NULL deref happens much before calling ib_free_cq().



Actually, the fact that
patch (1) caused you to get the NULL deref even before 3,4,5 tells me
that the qp and cq are not free at all, and for some reason we see them
as NULL.
<RAJU > Yes.

So in nvmet_rdma_recv_done() if the queue is not in state
NVMET_RDMA_Q_LIVE, we simply restore the rsp back to the queue free
list:

static inline void
nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
{
???????? unsigned long flags;

???????? spin_lock_irqsave(&rsp->queue->rsps_lock, flags);
???????? list_add_tail(&rsp->free_list, &rsp->queue->free_rsps);
???????? spin_unlock_irqrestore(&rsp->queue->rsps_lock, flags);
}

However we only set rsp->queue in nvmet_rdma_handle_command() which
does not take place because, as I mentioned, we are in disconnect
state...

I think this patch should make this issue go away:
--
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 973b674ab55b..06a8c6114098 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -180,9 +180,9 @@ nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
? {
???????? unsigned long flags;

-?????? spin_lock_irqsave(&rsp->queue->rsps_lock, flags);
-?????? list_add_tail(&rsp->free_list, &rsp->queue->free_rsps);
-?????? spin_unlock_irqrestore(&rsp->queue->rsps_lock, flags);
+?????? spin_lock_irqsave(&rsp->cmd->queue->rsps_lock, flags);
+?????? list_add_tail(&rsp->free_list, &rsp->cmd->queue->free_rsps);
+?????? spin_unlock_irqrestore(&rsp->cmd->queue->rsps_lock, flags);
? }

? static void nvmet_rdma_free_sgl(struct scatterlist *sgl, unsigned int 
nents)
@@ -473,7 +473,7 @@ static void nvmet_rdma_process_wr_wait_list(struct 
nvmet_rdma_queue *queue)

? static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
? {
-?????? struct nvmet_rdma_queue *queue = rsp->queue;
+?????? struct nvmet_rdma_queue *queue = rsp->cmd->queue;

???????? atomic_add(1 + rsp->n_rdma, &queue->sq_wr_avail);

@@ -517,7 +517,7 @@ static void nvmet_rdma_send_done(struct ib_cq *cq, 
struct ib_wc *wc)
????????????????????? wc->status != IB_WC_WR_FLUSH_ERR)) {
???????????????? pr_err("SEND for CQE 0x%p failed with status %s (%d).\n",
???????????????????????? wc->wr_cqe, ib_wc_status_msg(wc->status), 
wc->status);
-?????????????? nvmet_rdma_error_comp(rsp->queue);
+?????????????? nvmet_rdma_error_comp(rsp->cmd->queue);
???????? }
? }

@@ -525,7 +525,7 @@ static void nvmet_rdma_queue_response(struct 
nvmet_req *req)
? {
???????? struct nvmet_rdma_rsp *rsp =
???????????????? container_of(req, struct nvmet_rdma_rsp, req);
-?????? struct rdma_cm_id *cm_id = rsp->queue->cm_id;
+?????? struct rdma_cm_id *cm_id = rsp->cmd->queue->cm_id;
???????? struct ib_send_wr *first_wr, *bad_wr;

???????? if (rsp->flags & NVMET_RDMA_REQ_INVALIDATE_RKEY) {
@@ -541,9 +541,9 @@ static void nvmet_rdma_queue_response(struct 
nvmet_req *req)
???????? else
???????????????? first_wr = &rsp->send_wr;

-?????? nvmet_rdma_post_recv(rsp->queue->dev, rsp->cmd);
+?????? nvmet_rdma_post_recv(rsp->cmd->queue->dev, rsp->cmd);

-?????? ib_dma_sync_single_for_device(rsp->queue->dev->device,
+?????? ib_dma_sync_single_for_device(rsp->cmd->queue->dev->device,
???????????????? rsp->send_sge.addr, rsp->send_sge.length,
???????????????? DMA_TO_DEVICE);

@@ -614,7 +614,7 @@ static u16 nvmet_rdma_map_sgl_inline(struct 
nvmet_rdma_rsp *rsp)
? static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
???????????????? struct nvme_keyed_sgl_desc *sgl, bool invalidate)
? {
-?????? struct rdma_cm_id *cm_id = rsp->queue->cm_id;
+?????? struct rdma_cm_id *cm_id = rsp->cmd->queue->cm_id;
???????? u64 addr = le64_to_cpu(sgl->addr);
???????? u32 len = get_unaligned_le24(sgl->length);
???????? u32 key = get_unaligned_le32(sgl->key);
@@ -676,7 +676,7 @@ static u16 nvmet_rdma_map_sgl(struct nvmet_rdma_rsp 
*rsp)

? static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
? {
-?????? struct nvmet_rdma_queue *queue = rsp->queue;
+?????? struct nvmet_rdma_queue *queue = rsp->cmd->queue;

???????? if (unlikely(atomic_sub_return(1 + rsp->n_rdma,
???????????????????????? &queue->sq_wr_avail) < 0)) {
@@ -703,11 +703,6 @@ static void nvmet_rdma_handle_command(struct 
nvmet_rdma_queue *queue,
? {
???????? u16 status;

-?????? cmd->queue = queue;
-?????? cmd->n_rdma = 0;
-?????? cmd->req.port = queue->port;
-
-
???????? ib_dma_sync_single_for_cpu(queue->dev->device,
???????????????? cmd->cmd->sge[0].addr, cmd->cmd->sge[0].length,
???????????????? DMA_FROM_DEVICE);
@@ -763,6 +758,8 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, 
struct ib_wc *wc)
???????? rsp->cmd = cmd;
???????? rsp->flags = 0;
???????? rsp->req.cmd = cmd->nvme_cmd;
+?????? rsp->n_rdma = 0;
+?????? rsp->req.port = queue->port;

???????? if (unlikely(queue->state != NVMET_RDMA_Q_LIVE)) {
???????????????? unsigned long flags;
--
     
