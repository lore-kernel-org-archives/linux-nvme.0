From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Oct 2018 10:43:41 -0700
Subject: [PATCH v2 1/4] nvme: introduce ctrl attributes enumeration
In-Reply-To: <20181030174344.20171-1-sagi@grimberg.me>
References: <20181030174344.20171-1-sagi@grimberg.me>
Message-ID: <20181030174344.20171-2-sagi@grimberg.me>

We are growing more controller attributes, so use
a proper enumeration for it. For now just add the
128-bit hostid which we support.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 include/linux/nvme.h            | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 1179f6314323..30778ffc46f5 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -304,7 +304,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	/* XXX: figure out what to do about RTD3R/RTD3 */
 	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
-	id->ctratt = cpu_to_le32(1 << 0);
+	id->ctratt = cpu_to_le32(NVME_CTRL_ATTR_HID_128_BIT);
 
 	id->oacs = 0;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 818dbe9331be..753c83a5c01f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -198,6 +198,10 @@ enum {
 	NVME_PS_FLAGS_NON_OP_STATE	= 1 << 1,
 };
 
+enum nvme_ctrl_attr {
+	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
+};
+
 struct nvme_id_ctrl {
 	__le16			vid;
 	__le16			ssvid;
-- 
2.17.1
