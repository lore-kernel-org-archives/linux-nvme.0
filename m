From: mlin@kernel.org (Ming Lin)
Date: Thu,  9 Jun 2016 17:37:07 -0400
Subject: [PATCH] nvme-rdma: correctly stop keep alive on error path
Message-ID: <1465508227-14143-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

We didn't stop keep alive when blk_mq_alloc_tag_set() fails
in nvme_rdma_create_io_queues().

This caused below hung when unloading nvme-rdma driver.

[  141.253064] blk-mq: failed to allocate request map
[  146.197258] nvme \xffffffc0\xfffffff7\xffffff95\x18\x01\xffffff88\xffffffff\xffffffff1023: keep-alive failed
[  361.235076] INFO: task kworker/0:0:4 blocked for more than 120 seconds.
[  361.241753]       Tainted: G            E   4.7.0-rc2+ #252
[  361.247359] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  361.255239] kworker/0:0     D ffff8801192dbc40     0     4      2 0x00000000
[  361.262363] Workqueue: events nvme_keep_alive_work [nvme_core]
[  361.268242]  ffff8801192dbc40 4554535953425553 ffff8801192dc000 ffff8801192dbd58
[  361.275741]  ffff8801192dbd50 ffff8801192aa7c0 ffff88011e216300 ffff8801192dbc58
[  361.283232]  ffffffff816ef117 7fffffffffffffff ffff8801192dbcc8 ffffffff816f1b8f
[  361.291252] Call Trace:
[  361.294274]  [<ffffffff816ef117>] schedule+0x37/0x90
[  361.299813]  [<ffffffff816f1b8f>] schedule_timeout+0x13f/0x1a0
[  361.306240]  [<ffffffff816f0271>] wait_for_completion+0x91/0xf0
[  361.312709]  [<ffffffff8108fe00>] ? wake_up_q+0x70/0x70
[  361.318517]  [<ffffffff81081f8b>] flush_work+0xeb/0x160
[  361.324286]  [<ffffffff8107fe10>] ? destroy_worker+0x90/0x90
[  361.330516]  [<ffffffffc07f4331>] nvme_rdma_reset_ctrl+0x41/0x50 [nvme_rdma]
[  361.338097]  [<ffffffffc07e64c0>] nvme_keep_alive_work+0xc0/0xd0 [nvme_core]
[  361.345712]  [<ffffffff8108273c>] process_one_work+0x13c/0x360
[  361.352066]  [<ffffffff810832d6>] worker_thread+0x126/0x490
[  361.358193]  [<ffffffff810831b0>] ? cancel_delayed_work_sync+0x10/0x10
[  361.365240]  [<ffffffff810886d4>] kthread+0xc4/0xe0
[  361.370659]  [<ffffffff816f2bdf>] ret_from_fork+0x1f/0x40
[  361.376559]  [<ffffffff81088610>] ? kthread_create_on_node+0x170/0x170

[  361.383668] INFO: task kworker/0:2:147 blocked for more than 120 seconds.
[  361.390979]       Tainted: G            E   4.7.0-rc2+ #252
[  361.397064] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  361.405443] kworker/0:2     D ffff880035f0bbe0     0   147      2 0x00000000
[  361.413064] Workqueue: nvme_rdma_wq nvme_rdma_reset_ctrl_work [nvme_rdma]
[  361.420474]  ffff880035f0bbe0 ffffffff811ac3a1 ffff880035f0c000 ffff880035f0bd00
[  361.428493]  ffff880035f0bcf8 ffff880117f4dcc0 ffff880117f4dcc0 ffff880035f0bbf8
[  361.436502]  ffffffff816ef117 7fffffffffffffff ffff880035f0bc70 ffffffff816f1b8f
[  361.444521] Call Trace:
[  361.447503]  [<ffffffff811ac3a1>] ? pollwake+0x61/0x70
[  361.453216]  [<ffffffff816ef117>] schedule+0x37/0x90
[  361.458713]  [<ffffffff816f1b8f>] schedule_timeout+0x13f/0x1a0
[  361.465113]  [<ffffffff816f0271>] wait_for_completion+0x91/0xf0
[  361.471560]  [<ffffffff8108fe00>] ? wake_up_q+0x70/0x70
[  361.477339]  [<ffffffff81081f8b>] flush_work+0xeb/0x160
[  361.483078]  [<ffffffff8107fe10>] ? destroy_worker+0x90/0x90
[  361.489285]  [<ffffffff8108307e>] __cancel_work_timer+0x8e/0x1a0
[  361.495811]  [<ffffffff81095ec0>] ? pick_next_entity+0xa0/0x150
[  361.502292]  [<ffffffff810831ae>] cancel_delayed_work_sync+0xe/0x10
[  361.509100]  [<ffffffffc07e65da>] nvme_stop_keep_alive+0x1a/0x20 [nvme_core]
[  361.516734]  [<ffffffffc07f5afb>] nvme_rdma_shutdown_ctrl+0x1b/0xe0 [nvme_rdma]
[  361.524599]  [<ffffffffc07f6119>] nvme_rdma_reset_ctrl_work+0x19/0x120 [nvme_rdma]
[  361.532771]  [<ffffffff8108273c>] process_one_work+0x13c/0x360
[  361.539164]  [<ffffffff8108340b>] worker_thread+0x25b/0x490
[  361.545329]  [<ffffffff816eed2e>] ? __schedule+0x1de/0x590
[  361.551365]  [<ffffffff810831b0>] ? cancel_delayed_work_sync+0x10/0x10
[  361.558481]  [<ffffffff810886d4>] kthread+0xc4/0xe0
[  361.563897]  [<ffffffff816f2bdf>] ret_from_fork+0x1f/0x40
[  361.569863]  [<ffffffff81088610>] ? kthread_create_on_node+0x170/0x170

Signed-off-by: Ming Lin <ming.l at samsung.com>
---
 drivers/nvme/host/rdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 11246b8..8263f2f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1604,14 +1604,14 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	if (error)
 		goto out_cleanup_queue;
 
-	nvme_start_keep_alive(&ctrl->ctrl);
-
 	error = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
 			&ctrl->async_event_sqe, sizeof(struct nvme_command),
 			DMA_TO_DEVICE);
 	if (error)
 		goto out_cleanup_queue;
 
+	nvme_start_keep_alive(&ctrl->ctrl);
+
 	return 0;
 
 out_cleanup_queue:
@@ -1838,7 +1838,6 @@ static int nvme_rdma_create_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return 0;
 
 out_cleanup_connect_q:
-	nvme_stop_keep_alive(&ctrl->ctrl);
 	blk_cleanup_queue(ctrl->ctrl.connect_q);
 out_free_tag_set:
 	blk_mq_free_tag_set(&ctrl->tag_set);
@@ -1969,6 +1968,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	return &ctrl->ctrl;
 
 out_remove_admin_queue:
+	nvme_stop_keep_alive(&ctrl->ctrl);
 	nvme_rdma_destroy_admin_queue(ctrl);
 out_kfree_queues:
 	kfree(ctrl->queues);
-- 
1.9.1
