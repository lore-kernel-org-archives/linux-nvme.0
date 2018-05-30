From: hch@lst.de (Christoph Hellwig)
Date: Wed, 30 May 2018 18:46:00 +0200
Subject: [PATCH 12/12] nvme: limit warnings from nvme_identify_ns
In-Reply-To: <20180530164600.26856-1-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
Message-ID: <20180530164600.26856-13-hch@lst.de>

When rescanning namespaces after an AEN we will issue Identify Namespace
comands to namespaces that have gone away, so don't warn for this specific
case.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1ae77428a1a5..7ad3cfc9d4e1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -984,7 +984,9 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 
 	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
 	if (error) {
-		dev_warn(ctrl->device, "Identify namespace failed\n");
+		/* don't warn on a namespace that has gone away */
+		if (error < 0 || ((error & ~NVME_SC_DNR) != NVME_SC_INVALID_NS))
+			dev_warn(ctrl->device, "Identify namespace failed\n");
 		kfree(id);
 		return NULL;
 	}
-- 
2.17.0
