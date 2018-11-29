From: jalee@purestorage.com (Jaesoo Lee)
Date: Thu, 29 Nov 2018 15:59:14 -0800
Subject: [PATCH] nvme-rdma: complete requests from ->timeout
Message-ID: <1543535954-28073-1-git-send-email-jalee@purestorage.com>

After f6e7d48 (block: remove BLK_EH_HANDLED), the low-level device driver
is responsible to complete the timed out request and a series of changes
were submitted for various LLDDs to make completions from ->timeout
subsequently. However, adding the completion code in NVMe driver was
skipped with the assumption made in below NVMe LLDD's change.

Commit message of db8c48e (nvme: return BLK_EH_DONE from ->timeout):
 NVMe always completes the request before returning from ->timeout, either
 by polling for it, or by disabling the controller.   Return BLK_EH_DONE so
 that the block layer doesn't even try to complete it again.

This does not hold at least for NVMe RDMA host driver. An example scenario
is when the RDMA connection is gone while the controller is being deleted.
In this case, the nvmf_reg_write32() for sending shutdown admin command by
the delete_work could be hung forever if the command is not completed by
the timeout handler.

Stack trace of hang looks like:
 kworker/u66:2   D    0 21098      2 0x80000080
 Workqueue: nvme-delete-wq nvme_delete_ctrl_work
 Call Trace:
 __schedule+0x2ab/0x880
 schedule+0x36/0x80
 schedule_timeout+0x161/0x300
 ? __next_timer_interrupt+0xe0/0xe0
 io_schedule_timeout+0x1e/0x50
 wait_for_completion_io_timeout+0x130/0x1a0
 ? wake_up_q+0x80/0x80
 blk_execute_rq+0x6e/0xa0
 __nvme_submit_sync_cmd+0x6e/0xe0
 nvmf_reg_write32+0x6c/0xc0 [nvme_fabrics]
 nvme_shutdown_ctrl+0x56/0x110
 nvme_rdma_shutdown_ctrl+0xf8/0x100 [nvme_rdma]
 nvme_rdma_delete_ctrl+0x1a/0x20 [nvme_rdma]
 nvme_delete_ctrl_work+0x66/0x90
 process_one_work+0x179/0x390
 worker_thread+0x1da/0x3e0
 kthread+0x105/0x140
 ? max_active_store+0x80/0x80
 ? kthread_bind+0x20/0x20
 ret_from_fork+0x35/0x40

Signed-off-by: Jaesoo Lee <jalee at purestorage.com>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d181caf..25319b7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1688,6 +1688,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	/* fail with DNR on cmd timeout */
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
 
+	blk_mq_complete_request(rq);
 	return BLK_EH_DONE;
 }
 
-- 
1.9.1
