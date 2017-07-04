From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  4 Jul 2017 10:57:35 +0300
Subject: [PATCH v2 7/8] nvme-fc: update tagset nr_hw_queues after queues reinit
In-Reply-To: <1499155056-11241-1-git-send-email-sagi@grimberg.me>
References: <1499155056-11241-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499155056-11241-8-git-send-email-sagi@grimberg.me>

We might have more/less queues once we reconnect/reset. For
example due to cpu going online/offline or controller constraints.

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 996720043b3a..1e859ee2b565 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2279,6 +2279,8 @@ nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (ret)
 		goto out_delete_hw_queues;
 
+	blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
+
 	return 0;
 
 out_delete_hw_queues:
-- 
2.7.4
