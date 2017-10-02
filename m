From: hare@suse.de (Hannes Reinecke)
Date: Mon,  2 Oct 2017 15:55:55 +0200
Subject: [PATCH 2/6] nvme: use 'nvmsXnZ' instead of 'nvm-subXnZ'
In-Reply-To: <1506952559-1588-1-git-send-email-hare@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
Message-ID: <1506952559-1588-3-git-send-email-hare@suse.de>

Align with overall nvme device naming scheme.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b1e61c9..f52f0ab 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2689,7 +2689,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->disk->private_data = head;
 	head->disk->queue = q;
 	head->disk->flags = GENHD_FL_EXT_DEVT;
-	sprintf(head->disk->disk_name, "nvm-sub%dn%d",
+	sprintf(head->disk->disk_name, "nvms%dn%d",
 			ctrl->subsys->instance, nsid);
 	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
 	return head;
-- 
1.8.5.6
