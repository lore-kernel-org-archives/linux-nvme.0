From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Mon, 26 Feb 2018 14:17:04 +0100
Subject: [PATCH 05/19] lightnvm: complete geo structure with maxoc*
In-Reply-To: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1519651038-16845-6-git-send-email-javier@cnexlabs.com>

Complete the generic geometry structure with the maxoc and maxocpu
felds, present in the 2.0 spec.

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 9 +++++++++
 include/linux/lightnvm.h     | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index a48950a37b8d..a8f35e8b7953 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -323,6 +323,13 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 	dev_geo->c.ws_opt = sec_per_pg;
 	dev_geo->c.mw_cunits = 8;		/* default to MLC safe values */
 
+	/* Do not impose values for maximum number of open blocks as it is
+	 * unspecified in 1.2. Users of 1.2 must be aware of this and eventually
+	 * specify these values through a quirk if restrictions apply.
+	 */
+	dev_geo->c.maxoc = dev_geo->all_luns * dev_geo->c.num_chk;
+	dev_geo->c.maxocpu = dev_geo->c.num_chk;
+
 	dev_geo->c.cap = le32_to_cpu(src->mccap);
 
 	dev_geo->c.trdt = le32_to_cpu(src->trdt);
@@ -413,6 +420,8 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	dev_geo->c.ws_min = le32_to_cpu(id->ws_min);
 	dev_geo->c.ws_opt = le32_to_cpu(id->ws_opt);
 	dev_geo->c.mw_cunits = le32_to_cpu(id->mw_cunits);
+	dev_geo->c.maxoc = le32_to_cpu(id->maxoc);
+	dev_geo->c.maxocpu = le32_to_cpu(id->maxocpu);
 
 	dev_geo->c.cap = le32_to_cpu(id->mccap);
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 57d00644a1c6..e8e6bfd4d0d4 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -280,6 +280,8 @@ struct nvm_common_geo {
 	u32	ws_min;		/* minimum write size */
 	u32	ws_opt;		/* optimal write size */
 	u32	mw_cunits;	/* distance required for successful read */
+	u32	maxoc;		/* maximum open chunks */
+	u32	maxocpu;	/* maximum open chunks per parallel unit */
 
 	/* device capabilities. Note that this represents capabilities in 1.2
 	 * and media and controller capabilities in 2.0
-- 
2.7.4
