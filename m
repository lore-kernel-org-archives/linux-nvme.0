From: mwilck@suse.com (Martin Wilck)
Date: Mon, 14 Aug 2017 22:12:39 +0200
Subject: [PATCH v4 3/3] nvmet_execute_identify_ctrl: use memcpy_and_pad()
In-Reply-To: <20170814201239.15255-1-mwilck@suse.com>
References: <20170810084541.bawqaebfycnguomx@infradead.org>
 <20170814201239.15255-1-mwilck@suse.com>
Message-ID: <20170814201239.15255-4-mwilck@suse.com>

This changes the earlier patch "nvmet: don't report 0-bytes
in serial number" to use the memcpy_and_pad() helper introduced
in a previous patch.

Signed-off-by: Martin Wilck <mwilck at suse.com>
---
 drivers/nvme/target/admin-cmd.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index a53bb6635b837..7ccea863e0ab5 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -168,15 +168,6 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void copy_and_pad(char *dst, int dst_len, const char *src, int src_len)
-{
-	int len = min(src_len, dst_len);
-
-	memcpy(dst, src, len);
-	if (dst_len > len)
-		memset(dst + len, ' ', dst_len - len);
-}
-
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -196,8 +187,9 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	bin2hex(id->sn, &ctrl->subsys->serial,
 		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
-	copy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1);
-	copy_and_pad(id->fr, sizeof(id->fr), UTS_RELEASE, strlen(UTS_RELEASE));
+	memcpy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1, ' ');
+	memcpy_and_pad(id->fr, sizeof(id->fr),
+		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
 
 	id->rab = 6;
 
-- 
2.14.0
