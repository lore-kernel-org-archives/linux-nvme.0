From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Wed, 28 Feb 2018 16:49:24 +0100
Subject: [PATCH 04/15] lightnvm: add shorten OCSSD version in geo
In-Reply-To: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1519832975-25432-5-git-send-email-javier@cnexlabs.com>

Create a shorten version to use in the generic geometry.

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 6 ++++++
 include/linux/lightnvm.h     | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index a600e70b6e6b..85f336a79cda 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -299,6 +299,9 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 	geo->major_ver_id = id->ver_id;
 	geo->minor_ver_id = 2;
 
+	/* Set compacted version for upper layers */
+	geo->version = NVM_OCSSD_SPEC_12;
+
 	geo->nr_chnls = src->num_ch;
 	geo->nr_luns = src->num_lun;
 	geo->all_luns = geo->nr_chnls * geo->nr_luns;
@@ -385,6 +388,9 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	geo->major_ver_id = id->mjr;
 	geo->minor_ver_id = id->mnr;
 
+	/* Set compacted version for upper layers */
+	geo->version = NVM_OCSSD_SPEC_20;
+
 	if (!(geo->major_ver_id == 2 && geo->minor_ver_id == 0)) {
 		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
 				geo->major_ver_id, geo->minor_ver_id);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 4b2ecbf45fd9..b8bc158a2472 100644
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
@@ -266,6 +271,9 @@ struct nvm_geo {
 	u8	major_ver_id;
 	u8	minor_ver_id;
 
+	/* kernel short version */
+	u8	version;
+
 	/* instance specific geometry */
 	int nr_chnls;
 	int nr_luns;		/* per channel */
-- 
2.7.4
