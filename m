From: hch@lst.de (Christoph Hellwig)
Date: Fri, 31 Mar 2017 17:00:06 +0200
Subject: [PATCH 2/4] nvmet: add missing byte swap in nvmet_get_smart_log
In-Reply-To: <20170331150008.16034-1-hch@lst.de>
References: <20170331150008.16034-1-hch@lst.de>
Message-ID: <20170331150008.16034-3-hch@lst.de>

In this case entirely harmless as it's all-ones, but still nice to
shut up sparse.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index a7bcff45f437..76450b0c55f1 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -100,7 +100,7 @@ static u16 nvmet_get_smart_log(struct nvmet_req *req,
 	u16 status;
 
 	WARN_ON(req == NULL || slog == NULL);
-	if (req->cmd->get_log_page.nsid == 0xFFFFFFFF)
+	if (req->cmd->get_log_page.nsid == cpu_to_le32(0xFFFFFFFF))
 		status = nvmet_get_smart_log_all(req, slog);
 	else
 		status = nvmet_get_smart_log_nsid(req, slog);
-- 
2.11.0
