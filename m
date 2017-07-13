From: mwilck@suse.com (Martin Wilck)
Date: Fri, 14 Jul 2017 00:25:31 +0200
Subject: [PATCH 1/3] nvmet: identify controller: improve standard compliance
In-Reply-To: <20170713222533.30794-1-mwilck@suse.com>
References: <20170713222533.30794-1-mwilck@suse.com>
Message-ID: <20170713222533.30794-2-mwilck@suse.com>

The NVME standard mandates that the SN, MN, and FR fields of
the Indentify Controller Data Structure be "ASCII strings".
That means that they may not contain 0-bytes, not even string
terminators.

Signed-off-by: Martin Wilck <mwilck at suse.com>
Reviewed-by: Hannes Reinecke <hare at suse.de>
---
 drivers/nvme/target/admin-cmd.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 35f930db3c02c..b580141d57401 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -168,11 +168,21 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void copy_and_pad(char *dst, int dst_len, const char *src, int src_len)
+{
+	int len = min(src_len, dst_len);
+
+	memcpy(dst, src, len);
+	if (dst_len > len)
+		memset(dst + len, ' ', dst_len - len);
+}
+
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
 	u16 status = 0;
+	const char model[] = "Linux";
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
@@ -184,14 +194,11 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->vid = 0;
 	id->ssvid = 0;
 
-	memset(id->sn, ' ', sizeof(id->sn));
-	snprintf(id->sn, sizeof(id->sn), "%llx", ctrl->serial);
+	bin2hex(id->sn, &ctrl->serial, min(sizeof(ctrl->serial),
+					   sizeof(id->sn) / 2));
 
-	memset(id->mn, ' ', sizeof(id->mn));
-	strncpy((char *)id->mn, "Linux", sizeof(id->mn));
-
-	memset(id->fr, ' ', sizeof(id->fr));
-	strncpy((char *)id->fr, UTS_RELEASE, sizeof(id->fr));
+	copy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1);
+	copy_and_pad(id->fr, sizeof(id->fr), UTS_RELEASE, strlen(UTS_RELEASE));
 
 	id->rab = 6;
 
-- 
2.13.2
