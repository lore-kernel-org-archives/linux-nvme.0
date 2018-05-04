From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Fri,  4 May 2018 16:02:18 +0800
Subject: [PATCH] nvme-rdma: fix double free in nvme_rdma_free_queue
Message-ID: <1525420938-9492-1-git-send-email-jianchao.w.wang@oracle.com>

BUG: KASAN: double-free or invalid-free in nvme_rdma_free_queue+0xf6/0x110 [nvme_rdma]
Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work [nvme_rdma]
Call Trace:
 dump_stack+0x91/0xeb
 print_address_description+0x6b/0x290
 kasan_report_invalid_free+0x55/0x80
 __kasan_slab_free+0x176/0x190
 kfree+0xeb/0x310
 nvme_rdma_free_queue+0xf6/0x110 [nvme_rdma]
 nvme_rdma_configure_admin_queue+0x1a3/0x4d0 [nvme_rdma]
 nvme_rdma_reset_ctrl_work+0x4e/0xd0 [nvme_rdma]
 process_one_work+0x3ca/0xaa0
 worker_thread+0x4e2/0x6c0
 kthread+0x18d/0x1e0
 ret_from_fork+0x24/0x30

The double free is on ctrl->async_event_sqe.
If nvme_rdma_start_queue in nvme_rdma_configure_admin_queue fails,
nvme_rdma_free_queue will be invoked. However, at the moment, the
ctrl->async_event_sqe has not been allocated and it has been freed
in
nvme_rdma_reset_ctrl_work
  -> nvme_rdma_shutdown_ctrl
    ->nvme_rdma_destroy_admin_queue
      -> nvme_rdma_free_queue

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/rdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a0ead1d..fd965d0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -168,8 +168,11 @@ static inline size_t nvme_rdma_inline_data_size(struct nvme_rdma_queue *queue)
 static void nvme_rdma_free_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
 		size_t capsule_size, enum dma_data_direction dir)
 {
+	if (!qe->data)
+		return;
 	ib_dma_unmap_single(ibdev, qe->dma, capsule_size, dir);
 	kfree(qe->data);
+	qe->data = NULL;
 }
 
 static int nvme_rdma_alloc_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
-- 
2.7.4
