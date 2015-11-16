From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 16 Nov 2015 15:34:41 +0100
Subject: [PATCH 07/13] lightnvm: check for NAND flash and its type
In-Reply-To: <1447684487-25539-1-git-send-email-m@bjorling.me>
References: <1447684487-25539-1-git-send-email-m@bjorling.me>
Message-ID: <1447684487-25539-8-git-send-email-m@bjorling.me>

Only NAND flash with SLC and MLC is supported. Make sure to not try to
initialize TLC memory or other non-volatile memory types.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/lightnvm/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index f659e60..0985a03 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -185,6 +185,16 @@ static int nvm_core_init(struct nvm_dev *dev)
 	dev->plane_mode = NVM_PLANE_SINGLE;
 	dev->max_rq_size = dev->ops->max_phys_sect * dev->sec_size;
 
+	if (grp->mtype != 0) {
+		pr_err("nvm: memory type not supported\n");
+		return -EINVAL;
+	}
+
+	if (grp->fmtype != 0 && grp->fmtype != 1) {
+		pr_err("nvm: flash type not supported\n");
+		return -EINVAL;
+	}
+
 	if (grp->mpos & 0x020202)
 		dev->plane_mode = NVM_PLANE_DOUBLE;
 	if (grp->mpos & 0x040404)
-- 
2.1.4
