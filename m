From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 29 Jun 2017 14:09:12 +0300
Subject: [PATCH 7/7] nvme-fc: update tagset nr_hw_queues after queues reinit
In-Reply-To: <1498734552-14845-1-git-send-email-sagi@grimberg.me>
References: <1498734552-14845-1-git-send-email-sagi@grimberg.me>
Message-ID: <1498734552-14845-8-git-send-email-sagi@grimberg.me>

We might have more/less queues once we reconnect/reset. For
example due to cpu going online/offline or controller constraints.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5ee821d9cb75..ffe0589969bd 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2277,6 +2277,8 @@ nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (ret)
 		goto out_delete_hw_queues;
 
+	blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
+
 	return 0;
 
 out_delete_hw_queues:
-- 
2.7.4
