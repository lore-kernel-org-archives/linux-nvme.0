From: colin.king@canonical.com (Colin King)
Date: Tue, 27 Dec 2016 16:04:09 +0000
Subject: [PATCH] nvme: admin-cmd: fix spelling mistake: "Counld" -> "Could"
Message-ID: <20161227160409.9059-1-colin.king@canonical.com>

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in pr_err message

Signed-off-by: Colin Ian King <colin.king at canonical.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ec1ad2a..0c2688c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -41,7 +41,7 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->get_log_page.nsid);
 	if (!ns) {
 		status = NVME_SC_INVALID_NS;
-		pr_err("nvmet : Counld not find namespace id : %d\n",
+		pr_err("nvmet : Could not find namespace id : %d\n",
 				le32_to_cpu(req->cmd->get_log_page.nsid));
 		goto out;
 	}
-- 
2.10.2
