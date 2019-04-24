From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Apr 2019 11:53:17 -0700
Subject: [PATCH 2/4] nvme-tcp: Fix a NULL deref when an admin connect times out
In-Reply-To: <20190424185319.18942-1-sagi@grimberg.me>
References: <20190424185319.18942-1-sagi@grimberg.me>
Message-ID: <20190424185319.18942-3-sagi@grimberg.me>

If we timeout the admin startup sequence we might not yet have
an I/O tagset allocated which causes the teardown sequence to crash.
Make nvme_tcp_teardown_io_queues safe by not iterating inflight tags
if the tagset wasn't allocated.

Fixes: 39d57757467b ("nvme-tcp: fix timeout handler")
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/tcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5e761bf17ef2..7201fbeb4a8f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1719,7 +1719,9 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
-	blk_mq_tagset_busy_iter(ctrl->admin_tagset, nvme_cancel_request, ctrl);
+	if (ctrl->admin_tagset)
+		blk_mq_tagset_busy_iter(ctrl->admin_tagset,
+			nvme_cancel_request, ctrl);
 	blk_mq_unquiesce_queue(ctrl->admin_q);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
 }
@@ -1731,7 +1733,9 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		return;
 	nvme_stop_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-	blk_mq_tagset_busy_iter(ctrl->tagset, nvme_cancel_request, ctrl);
+	if (ctrl->tagset)
+		blk_mq_tagset_busy_iter(ctrl->tagset,
+			nvme_cancel_request, ctrl);
 	if (remove)
 		nvme_start_queues(ctrl);
 	nvme_tcp_destroy_io_queues(ctrl, remove);
-- 
2.17.1
