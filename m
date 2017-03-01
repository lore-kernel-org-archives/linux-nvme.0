From: parav@mellanox.com (Parav Pandit)
Date: Tue, 28 Feb 2017 20:06:39 -0600
Subject: [PATCH] nvme-rdma: nvme-fc: Fix avoid tag set initialization twice.
Message-ID: <1488333999-30412-1-git-send-email-parav@mellanox.com>

When BLK_MQ_F_NO_SCHED is not set for a tagset of a request queue,
it tries to initialize the queue twice where blk_mq_alloc_rq_map() gets
invoked twice as part of blk_mq_alloc_tag_set() and blk_mq_init_queue()
through elevator init path.
When for a given tagset it gets reinitialized through init_queue() path,
number of reserved tags are zero. Due to which any command issued with
BLK_MQ_REQ_RESERVED fails to allocate a tag as seen in below stack
trace.

Set it for nvme admin queue of RDMA and FC to avoid such error similar
to change of d34849913.

kernel: CPU: 37 PID: 20942 Comm: nvme Not tainted 4.10.0-linux-block+ #12
kernel: Call Trace:
kernel: dump_stack+0x63/0x87
kernel: __warn+0xd1/0xf0
kernel: warn_slowpath_null+0x1d/0x20
kernel: blk_mq_get_tag+0x298/0x2a0
kernel: ? remove_wait_queue+0x60/0x60
kernel: __blk_mq_alloc_request+0x1b/0xc0
kernel: blk_mq_sched_get_request+0x186/0x270
kernel: blk_mq_alloc_request+0x81/0xd0
kernel: nvme_alloc_request+0x5a/0x70 [nvme_core]
kernel: __nvme_submit_sync_cmd+0x31/0xe0 [nvme_core]
kernel: nvmf_connect_admin_queue+0x128/0x190 [nvme_fabrics]
kernel: ? blk_mq_init_allocated_queue+0x502/0x540
kernel: nvme_rdma_configure_admin_queue+0x1a0/0x480 [nvme_rdma]
kernel: nvme_rdma_create_ctrl+0x2a9/0x7a0 [nvme_rdma]
kernel: nvmf_dev_write+0x793/0x952 [nvme_fabrics]
kernel: __vfs_write+0x37/0x140
kernel: ? __fd_install+0x31/0xd0
kernel: vfs_write+0xb2/0x1b0
kernel: SyS_write+0x55/0xc0
kernel: entry_SYSCALL_64_fastpath+0x1a/0xa9

Going forward admin_queue and ioq tag set initialization helper function
will be implemented to be used by all the transports to avoid such bugs
in future.

Fixes: d34849913 ("blk-mq-sched: allow setting of default IO scheduler")
Signed-off-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/host/fc.c   | 1 +
 drivers/nvme/host/rdma.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9690beb..876e99c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1987,6 +1987,7 @@ enum blk_eh_timer_return
 	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_FC_AQ_BLKMQ_DEPTH;
 	ctrl->admin_tag_set.reserved_tags = 2; /* fabric connect + Keep-Alive */
+	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
 	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_fc_fcp_op) +
 					(SG_CHUNK_SIZE *
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 49b2121..c3f96fd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1563,6 +1563,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	ctrl->admin_tag_set.ops = &nvme_rdma_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_RDMA_AQ_BLKMQ_DEPTH;
 	ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
+	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
 	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
 		SG_CHUNK_SIZE * sizeof(struct scatterlist);
-- 
1.8.3.1
