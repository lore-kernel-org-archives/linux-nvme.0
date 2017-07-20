From: mwilck@suse.com (Martin Wilck)
Date: Thu, 20 Jul 2017 17:27:44 +0200
Subject: [PATCH v2 2/3] nvmet: identify controller: improve standard compliance
In-Reply-To: <20170720152745.3274-1-mwilck@suse.com>
References: <20170720152745.3274-1-mwilck@suse.com>
Message-ID: <20170720152745.3274-3-mwilck@suse.com>

The NVME standard mandates that the SN, MN, and FR fields of
the Indentify Controller Data Structure be "ASCII strings".
That means that they may not contain 0-bytes, not even string
terminators.

Signed-off-by: Martin Wilck <mwilck at suse.com>
---
 drivers/nvme/target/admin-cmd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 35f930db3c02c..bd040ae32528d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -173,6 +173,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
 	u16 status = 0;
+	const char MODEL[] = "Linux";
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
@@ -184,14 +185,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
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
+	memcpy_and_pad(id->mn, sizeof(id->mn), MODEL, sizeof(MODEL) - 1, ' ');
+	memcpy_and_pad(id->fr, sizeof(id->fr),
+		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
 
 	id->rab = 6;
 
-- 
2.13.2
