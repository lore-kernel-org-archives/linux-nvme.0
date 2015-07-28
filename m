From: sathya.m@samsung.com (Sathyavathi M)
Date: Tue, 28 Jul 2015 15:18:32 +0530
Subject: [PATCH] NVMe: Read-Write Error Recovery mode page
Message-ID: <1438076912-1896-1-git-send-email-sathya.m@samsung.com>

This patch implements the SCSI to NVMe translation for Read Write Error
Recovery mode page, as defined by the SCSI translation specification version 1.4

Signed-off-by: Sathyavathi M <sathya.m at samsung.com>
---
 drivers/block/nvme-scsi.c | 61 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index e5a63f0..5333c31 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -108,6 +108,7 @@ static int sg_version_num = 30534;	/* 2 digits for each component */
 #define RESERVED_FIELD					0
 
 /* Mode Sense/Select defines */
+#define MODE_PAGE_RW_ERR_RECOVERY			0x01
 #define MODE_PAGE_INFO_EXCEP				0x1C
 #define MODE_PAGE_CACHING				0x08
 #define MODE_PAGE_CONTROL				0x0A
@@ -115,11 +116,12 @@ static int sg_version_num = 30534;	/* 2 digits for each component */
 #define MODE_PAGE_RETURN_ALL				0x3F
 #define MODE_PAGE_BLK_DES_LEN				0x08
 #define MODE_PAGE_LLBAA_BLK_DES_LEN			0x10
+#define MODE_PAGE_RW_ERR_RECOVERY_LEN			0x0C
 #define MODE_PAGE_CACHING_LEN				0x14
 #define MODE_PAGE_CONTROL_LEN				0x0C
 #define MODE_PAGE_POW_CND_LEN				0x28
 #define MODE_PAGE_INF_EXC_LEN				0x0C
-#define MODE_PAGE_ALL_LEN				0x54
+#define MODE_PAGE_ALL_LEN				0x60
 #define MODE_SENSE6_MPH_SIZE				4
 #define MODE_SENSE_PAGE_CONTROL_MASK			0xC0
 #define MODE_SENSE_PAGE_CODE_OFFSET			2
@@ -143,6 +145,7 @@ static int sg_version_num = 30534;	/* 2 digits for each component */
 #define MODE_SELECT_PAGE_CODE_MASK			0x3F
 #define SHORT_DESC_BLOCK				8
 #define LONG_DESC_BLOCK					16
+#define MODE_PAGE_RW_ERR_RECOVERY_LEN_FILED		0x0A
 #define MODE_PAGE_POW_CND_LEN_FIELD			0x26
 #define MODE_PAGE_INF_EXC_LEN_FIELD			0x0A
 #define MODE_PAGE_CACHING_LEN_FIELD			0x12
@@ -919,6 +922,34 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 
 /* MODE SENSE Helper Functions */
 
+static int nvme_trans_fill_rw_err_recovery_page(struct nvme_ns *ns,
+		struct sg_io_hdr *hdr, u8 *resp, int len)
+{
+	int res = SNTI_TRANSLATION_SUCCESS;
+	int nvme_sc;
+	struct nvme_dev *dev = ns->dev;
+	u32 feature_resp;
+	u16 tler;
+
+	if (len < MODE_PAGE_RW_ERR_RECOVERY_LEN)
+		return SNTI_INTERNAL_ERROR;
+
+	nvme_sc = nvme_get_features(dev, NVME_FEAT_ERR_RECOVERY, 0, 0,
+							&feature_resp);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (res)
+		return res;
+	tler = (feature_resp & 0xFFFF) * 0x100;
+	resp[0] = MODE_PAGE_RW_ERR_RECOVERY;
+	resp[1] = MODE_PAGE_RW_ERR_RECOVERY_LEN_FILED;
+	resp[2] = 0xC0;		/* DCR=0, DTE=0, PER=0, EER=0
+				* RC=0, TB=0, ARRE=1, AWRE=1 */
+	resp[10] = ((tler & 0xFF00) >> 8);
+	resp[11] = tler & 0xFF;
+
+	return res;
+}
+
 static int nvme_trans_fill_mode_parm_hdr(u8 *resp, int len, u8 cdb10, u8 llbaa,
 					u16 mode_data_length, u16 blk_desc_len)
 {
@@ -1069,11 +1100,13 @@ static int nvme_trans_fill_all_pages(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 {
 	int res;
 	u16 mode_pages_offset_1 = 0;
-	u16 mode_pages_offset_2, mode_pages_offset_3, mode_pages_offset_4;
+	u16 mode_pages_offset_2, mode_pages_offset_3, mode_pages_offset_4,
+							mode_pages_offset_5;
 
 	mode_pages_offset_2 = mode_pages_offset_1 + MODE_PAGE_CACHING_LEN;
 	mode_pages_offset_3 = mode_pages_offset_2 + MODE_PAGE_CONTROL_LEN;
 	mode_pages_offset_4 = mode_pages_offset_3 + MODE_PAGE_POW_CND_LEN;
+	mode_pages_offset_5 = mode_pages_offset_4 + MODE_PAGE_INF_EXC_LEN;
 
 	res = nvme_trans_fill_caching_page(ns, hdr, &resp[mode_pages_offset_1],
 					MODE_PAGE_CACHING_LEN);
@@ -1087,8 +1120,13 @@ static int nvme_trans_fill_all_pages(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 					MODE_PAGE_POW_CND_LEN);
 	if (res)
 		return res;
-	return nvme_trans_fill_inf_exc_page(ns, hdr, &resp[mode_pages_offset_4],
+	res = nvme_trans_fill_inf_exc_page(ns, hdr, &resp[mode_pages_offset_4],
 					MODE_PAGE_INF_EXC_LEN);
+	if (res)
+		return res;
+
+	return nvme_trans_fill_rw_err_recovery_page(ns, hdr,
+		&resp[mode_pages_offset_5], MODE_PAGE_RW_ERR_RECOVERY_LEN);
 }
 
 static inline int nvme_trans_get_blk_desc_len(u8 dbd, u8 llbaa)
@@ -1368,6 +1406,14 @@ static int nvme_trans_modesel_get_mp(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	unsigned dword11;
 
 	switch (page_code) {
+	case MODE_PAGE_RW_ERR_RECOVERY:
+		dword11 = mode_page[11];
+		dword11 |= (mode_page[10] << 8);
+		dword11 = dword11 / 100;
+		nvme_sc = nvme_set_features(dev, NVME_FEAT_ERR_RECOVERY,
+							dword11, 0, NULL);
+		res = nvme_trans_status_code(hdr, nvme_sc);
+		break;
 	case MODE_PAGE_CACHING:
 		dword11 = ((mode_page[2] & CACHING_MODE_PAGE_WCE_MASK) ? 1 : 0);
 		nvme_sc = nvme_set_features(dev, NVME_FEAT_VOLATILE_WC, dword11,
@@ -1435,7 +1481,8 @@ static int nvme_trans_modesel_data(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	do {
 		page_code = parm_list[index] & MODE_SELECT_PAGE_CODE_MASK;
 		mp_size = parm_list[index + 1] + 2;
-		if ((page_code != MODE_PAGE_CACHING) &&
+		if ((page_code != MODE_PAGE_RW_ERR_RECOVERY) &&
+		    (page_code != MODE_PAGE_CACHING) &&
 		    (page_code != MODE_PAGE_CONTROL) &&
 		    (page_code != MODE_PAGE_POWER_CONDITION)) {
 			res = nvme_trans_completion(hdr,
@@ -1991,6 +2038,12 @@ static int nvme_trans_mode_sense(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	}
 
 	switch (cmd[2] & MODE_SENSE_PAGE_CODE_MASK) {
+	case MODE_PAGE_RW_ERR_RECOVERY:
+		res = nvme_trans_mode_page_create(ns, hdr, cmd, alloc_len,
+					cdb10,
+					&nvme_trans_fill_rw_err_recovery_page,
+					MODE_PAGE_RW_ERR_RECOVERY_LEN);
+		break;
 	case MODE_PAGE_CACHING:
 		res = nvme_trans_mode_page_create(ns, hdr, cmd, alloc_len,
 						cdb10,
-- 
1.9.1
