From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Mon, 26 Feb 2018 14:17:03 +0100
Subject: [PATCH 04/19] lightnvm: add shorten OCSSD version in geo
In-Reply-To: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1519651038-16845-5-git-send-email-javier@cnexlabs.com>

Create a shorten version to use in the generic geometry.

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 6 ++++++
 include/linux/lightnvm.h     | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8befb60eeacb..a48950a37b8d 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -299,6 +299,9 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 	dev_geo->major_ver_id = id->ver_id;
 	dev_geo->minor_ver_id = 2;
 
+	/* Set compacted version for upper layers */
+	dev_geo->c.version = NVM_OCSSD_SPEC_12;
+
 	dev_geo->nr_chnls = src->num_ch;
 	dev_geo->nr_luns = src->num_lun;
 	dev_geo->all_luns = dev_geo->nr_chnls * dev_geo->nr_luns;
@@ -385,6 +388,9 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	dev_geo->major_ver_id = id->mjr;
 	dev_geo->minor_ver_id = id->mnr;
 
+	/* Set compacted version for upper layers */
+	dev_geo->c.version = NVM_OCSSD_SPEC_20;
+
 	if (!(dev_geo->major_ver_id == 2 && dev_geo->minor_ver_id == 0)) {
 		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
 				dev_geo->major_ver_id, dev_geo->minor_ver_id);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index ccaf8a30202d..57d00644a1c6 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -23,6 +23,11 @@ enum {
 #define NVM_LUN_BITS (8)
 #define NVM_CH_BITS  (7)
 
+enum {
+	NVM_OCSSD_SPEC_12 = 12,
+	NVM_OCSSD_SPEC_20 = 20,
+};
+
 struct ppa_addr {
 	/* Generic structure for all addresses */
 	union {
@@ -262,6 +267,9 @@ enum {
 
 /* Device common geometry */
 struct nvm_common_geo {
+	/* kernel short version */
+	u8	version;
+
 	/* chunk geometry */
 	u32	num_chk;	/* chunks per lun */
 	u32	clba;		/* sectors per chunk */
-- 
2.7.4
