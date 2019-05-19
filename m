From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Mon, 20 May 2019 00:06:55 +0900
Subject: [PATCH v4 4/7] nvme: add basic facilities to get telemetry log page
In-Reply-To: <1558278418-5702-1-git-send-email-akinobu.mita@gmail.com>
References: <1558278418-5702-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1558278418-5702-5-git-send-email-akinobu.mita@gmail.com>

This adds the required facilities to get telemetry log page.  The telemetry
log page structure and identifier are copied from nvme-cli.

We need a facility to check log page attributes in order to know the
controller supports the telemetry log pages and log page offset field for
the Get Log Page command.  The telemetry data area could be larger than
maximum data transfer size, so we may need to split into multiple transfers
with incremental page offset.

Cc: Johannes Berg <johannes at sipsolutions.net>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Minwoo Im <minwoo.im.dev at gmail.com>
Cc: Kenneth Heitke <kenneth.heitke at intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
* v4
- Add nvme_get_telemetry_log() to nvme core module.
- Copy struct nvme_telemetry_log_page_hdr from the latest nvme-cli

 drivers/nvme/host/core.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  3 +++
 include/linux/nvme.h     | 32 ++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7da80f3..d352145 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2464,6 +2464,7 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
 
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
+EXPORT_SYMBOL_GPL(nvme_get_log);
 
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
 {
@@ -2484,6 +2485,62 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
+static int nvme_get_log_blocks(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page,
+			       u8 lsp, void *buf, size_t bytes, loff_t offset)
+{
+	loff_t pos = 0;
+	u32 chunk_size;
+
+	if (check_mul_overflow(ctrl->max_hw_sectors, 512u, &chunk_size))
+		chunk_size = UINT_MAX;
+
+	while (pos < bytes) {
+		size_t size = min_t(size_t, bytes - pos, chunk_size);
+		int ret;
+
+		if ((offset + pos) &&
+		    !(ctrl->lpa & NVME_CTRL_LPA_EXTENDED_DATA))
+			return -EINVAL;
+
+		ret = nvme_get_log(ctrl, nsid, log_page, lsp, buf + pos, size,
+				   offset + pos);
+		if (ret)
+			return ret;
+
+		pos += size;
+	}
+
+	return 0;
+}
+
+int nvme_get_telemetry_log(struct nvme_ctrl *ctrl, struct bio_vec *bvecs,
+			   size_t bytes)
+{
+	struct bvec_iter iter = {
+		.bi_size = bytes,
+	};
+	size_t offset = 0;
+
+	while (iter.bi_size) {
+		struct bio_vec bvec = mp_bvec_iter_bvec(bvecs, iter);
+		size_t size = min(iter.bi_size, bvec.bv_len);
+		void *buf = page_address(bvec.bv_page) + bvec.bv_offset;
+		int ret;
+
+		ret = nvme_get_log_blocks(ctrl, NVME_NSID_ALL,
+					  NVME_LOG_TELEMETRY_CTRL, 0, buf, size,
+					  offset);
+		if (ret)
+			return ret;
+
+		offset += size;
+		bvec_iter_advance(bvecs, &iter, size);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_get_telemetry_log);
+
 /*
  * Initialize the cached copies of the Identify data and various controller
  * register in our nvme_ctrl structure.  This should be called as soon as
@@ -2587,6 +2644,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	} else
 		ctrl->shutdown_timeout = shutdown_timeout;
 
+	ctrl->lpa = id->lpa;
 	ctrl->npss = id->npss;
 	ctrl->apsta = id->apsta;
 	prev_apst_enabled = ctrl->apst_enabled;
@@ -3899,6 +3957,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_telemetry_log_page_hdr) != 512);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5ee75b5..56bba7a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -195,6 +195,7 @@ struct nvme_ctrl {
 	u32 vs;
 	u32 sgls;
 	u16 kas;
+	u8 lpa;
 	u8 npss;
 	u8 apsta;
 	u32 oaes;
@@ -466,6 +467,8 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
 		void *log, size_t size, u64 offset);
+int nvme_get_telemetry_log(struct nvme_ctrl *ctrl, struct bio_vec *bvecs,
+			   size_t bytes);
 
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 8028ada..658ac75 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -294,6 +294,8 @@ enum {
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
 	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
+	NVME_CTRL_LPA_EXTENDED_DATA		= 1 << 2,
+	NVME_CTRL_LPA_TELEMETRY_LOG		= 1 << 3,
 };
 
 struct nvme_lbaf {
@@ -396,6 +398,35 @@ enum {
 	NVME_NIDT_UUID		= 0x03,
 };
 
+/**
+ * struct nvme_telemetry_log_page_hdr - structure for telemetry log page
+ * @lpi: Log page identifier
+ * @iee_oui: IEEE OUI Identifier
+ * @dalb1: Data area 1 last block
+ * @dalb2: Data area 2 last block
+ * @dalb3: Data area 3 last block
+ * @ctrlavail: Controller initiated data available
+ * @ctrldgn: Controller initiated telemetry Data Generation Number
+ * @rsnident: Reason Identifier
+ * @telemetry_dataarea: Contains telemetry data block
+ *
+ * This structure can be used for both telemetry host-initiated log page
+ * and controller-initiated log page.
+ */
+struct nvme_telemetry_log_page_hdr {
+	__u8	lpi;
+	__u8	rsvd[4];
+	__u8	iee_oui[3];
+	__le16	dalb1;
+	__le16	dalb2;
+	__le16	dalb3;
+	__u8	rsvd1[368];
+	__u8	ctrlavail;
+	__u8	ctrldgn;
+	__u8	rsnident[128];
+	__u8	telemetry_dataarea[0];
+};
+
 struct nvme_smart_log {
 	__u8			critical_warning;
 	__u8			temperature[2];
@@ -832,6 +863,7 @@ enum {
 	NVME_LOG_FW_SLOT	= 0x03,
 	NVME_LOG_CHANGED_NS	= 0x04,
 	NVME_LOG_CMD_EFFECTS	= 0x05,
+	NVME_LOG_TELEMETRY_CTRL	= 0x08,
 	NVME_LOG_ANA		= 0x0c,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
-- 
2.7.4
