From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 12:14:22 +0200
Subject: [PATCH 01/10] nvme: add missing kfree() in nvme_configure_ana()
In-Reply-To: <20180529101431.62271-1-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
Message-ID: <20180529101431.62271-2-hare@suse.de>

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0d3ef3098063..1a8791340862 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -421,6 +421,7 @@ int nvme_configure_ana(struct nvme_ctrl *ctrl)
 out_free_ana_log_buf:
 	kfree(ctrl->ana_log_buf);
 out_free_ana_state:
+	kfree(ctrl->ana_state);
 	return -ENOMEM;
 }
 
-- 
2.12.3
