From: hch@lst.de (Christoph Hellwig)
Date: Tue, 18 Jul 2017 19:46:50 +0200
Subject: [PATCH] nvmet: use NVME_NSID_ALL
Message-ID: <20170718174650.25285-1-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 drivers/nvme/target/configfs.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 2d7a98ab53fb..1a34290831db 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -100,7 +100,7 @@ static u16 nvmet_get_smart_log(struct nvmet_req *req,
 	u16 status;
 
 	WARN_ON(req == NULL || slog == NULL);
-	if (req->cmd->get_log_page.nsid == cpu_to_le32(0xFFFFFFFF))
+	if (req->cmd->get_log_page.nsid == cpu_to_le32(NVME_NSID_ALL))
 		status = nvmet_get_smart_log_all(req, slog);
 	else
 		status = nvmet_get_smart_log_nsid(req, slog);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 0a0067e771f5..b6aeb1d70951 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -444,7 +444,7 @@ static struct config_group *nvmet_ns_make(struct config_group *group,
 		goto out;
 
 	ret = -EINVAL;
-	if (nsid == 0 || nsid == 0xffffffff)
+	if (nsid == 0 || nsid == NVME_NSID_ALL)
 		goto out;
 
 	ret = -ENOMEM;
-- 
2.11.0
