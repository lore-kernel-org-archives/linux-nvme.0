From: hch@lst.de (Christoph Hellwig)
Date: Fri,  8 May 2015 18:00:32 +0200
Subject: [PATCH 07/11] nvme: first round at deobsfucating the SCSI translation
 code
In-Reply-To: <1431100836-28112-1-git-send-email-hch@lst.de>
References: <1431100836-28112-1-git-send-email-hch@lst.de>
Message-ID: <1431100836-28112-8-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-scsi.c | 326 ++++++++++++----------------------------------
 1 file changed, 82 insertions(+), 244 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 163964c..4e89313 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -41,6 +41,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <asm/unaligned.h>
 #include <scsi/sg.h>
 #include <scsi/scsi.h>
 
@@ -55,49 +56,14 @@ static int sg_version_num = 30534;	/* 2 digits for each component */
 #define VPD_BLOCK_LIMITS				0xB0
 #define VPD_BLOCK_DEV_CHARACTERISTICS			0xB1
 
-/* CDB offsets */
-#define REPORT_LUNS_CDB_ALLOC_LENGTH_OFFSET		6
-#define REPORT_LUNS_SR_OFFSET				2
-#define READ_CAP_16_CDB_ALLOC_LENGTH_OFFSET		10
-#define REQUEST_SENSE_CDB_ALLOC_LENGTH_OFFSET		4
-#define REQUEST_SENSE_DESC_OFFSET			1
-#define REQUEST_SENSE_DESC_MASK				0x01
-#define DESCRIPTOR_FORMAT_SENSE_DATA_TYPE		1
-#define INQUIRY_EVPD_BYTE_OFFSET			1
-#define INQUIRY_PAGE_CODE_BYTE_OFFSET			2
-#define INQUIRY_EVPD_BIT_MASK				1
-#define INQUIRY_CDB_ALLOCATION_LENGTH_OFFSET		3
-#define START_STOP_UNIT_CDB_IMMED_OFFSET		1
-#define START_STOP_UNIT_CDB_IMMED_MASK			0x1
-#define START_STOP_UNIT_CDB_POWER_COND_MOD_OFFSET	3
-#define START_STOP_UNIT_CDB_POWER_COND_MOD_MASK		0xF
-#define START_STOP_UNIT_CDB_POWER_COND_OFFSET		4
-#define START_STOP_UNIT_CDB_POWER_COND_MASK		0xF0
-#define START_STOP_UNIT_CDB_NO_FLUSH_OFFSET		4
-#define START_STOP_UNIT_CDB_NO_FLUSH_MASK		0x4
-#define START_STOP_UNIT_CDB_START_OFFSET		4
-#define START_STOP_UNIT_CDB_START_MASK			0x1
-#define WRITE_BUFFER_CDB_MODE_OFFSET			1
-#define WRITE_BUFFER_CDB_MODE_MASK			0x1F
-#define WRITE_BUFFER_CDB_BUFFER_ID_OFFSET		2
-#define WRITE_BUFFER_CDB_BUFFER_OFFSET_OFFSET		3
-#define WRITE_BUFFER_CDB_PARM_LIST_LENGTH_OFFSET	6
-#define FORMAT_UNIT_CDB_FORMAT_PROT_INFO_OFFSET		1
-#define FORMAT_UNIT_CDB_FORMAT_PROT_INFO_MASK		0xC0
-#define FORMAT_UNIT_CDB_FORMAT_PROT_INFO_SHIFT		6
-#define FORMAT_UNIT_CDB_LONG_LIST_OFFSET		1
-#define FORMAT_UNIT_CDB_LONG_LIST_MASK			0x20
-#define FORMAT_UNIT_CDB_FORMAT_DATA_OFFSET		1
-#define FORMAT_UNIT_CDB_FORMAT_DATA_MASK		0x10
+/* format unit paramter list offsets */
 #define FORMAT_UNIT_SHORT_PARM_LIST_LEN			4
 #define FORMAT_UNIT_LONG_PARM_LIST_LEN			8
 #define FORMAT_UNIT_PROT_INT_OFFSET			3
 #define FORMAT_UNIT_PROT_FIELD_USAGE_OFFSET		0
 #define FORMAT_UNIT_PROT_FIELD_USAGE_MASK		0x07
-#define UNMAP_CDB_PARAM_LIST_LENGTH_OFFSET		7
 
 /* Misc. defines */
-#define NIBBLE_SHIFT					4
 #define FIXED_SENSE_DATA				0x70
 #define DESC_FORMAT_SENSE_DATA				0x72
 #define FIXED_SENSE_DATA_ADD_LENGTH			10
@@ -145,22 +111,7 @@ static int sg_version_num = 30534;	/* 2 digits for each component */
 #define IO_CDB_WP_MASK					0xE0
 #define IO_CDB_WP_SHIFT					5
 #define IO_CDB_FUA_MASK					0x8
-#define IO_6_CDB_LBA_OFFSET				0
 #define IO_6_CDB_LBA_MASK				0x001FFFFF
-#define IO_6_CDB_TX_LEN_OFFSET				4
-#define IO_6_DEFAULT_TX_LEN				256
-#define IO_10_CDB_LBA_OFFSET				2
-#define IO_10_CDB_TX_LEN_OFFSET				7
-#define IO_10_CDB_WP_OFFSET				1
-#define IO_10_CDB_FUA_OFFSET				1
-#define IO_12_CDB_LBA_OFFSET				2
-#define IO_12_CDB_TX_LEN_OFFSET				6
-#define IO_12_CDB_WP_OFFSET				1
-#define IO_12_CDB_FUA_OFFSET				1
-#define IO_16_CDB_FUA_OFFSET				1
-#define IO_16_CDB_WP_OFFSET				1
-#define IO_16_CDB_LBA_OFFSET				2
-#define IO_16_CDB_TX_LEN_OFFSET				10
 
 /* Mode Sense/Select defines */
 #define MODE_PAGE_INFO_EXCEP				0x1C
@@ -176,23 +127,14 @@ static int sg_version_num = 30534;	/* 2 digits for each component */
 #define MODE_PAGE_INF_EXC_LEN				0x0C
 #define MODE_PAGE_ALL_LEN				0x54
 #define MODE_SENSE6_MPH_SIZE				4
-#define MODE_SENSE6_ALLOC_LEN_OFFSET			4
-#define MODE_SENSE_PAGE_CONTROL_OFFSET			2
 #define MODE_SENSE_PAGE_CONTROL_MASK			0xC0
 #define MODE_SENSE_PAGE_CODE_OFFSET			2
 #define MODE_SENSE_PAGE_CODE_MASK			0x3F
-#define MODE_SENSE_LLBAA_OFFSET				1
 #define MODE_SENSE_LLBAA_MASK				0x10
 #define MODE_SENSE_LLBAA_SHIFT				4
-#define MODE_SENSE_DBD_OFFSET				1
 #define MODE_SENSE_DBD_MASK				8
 #define MODE_SENSE_DBD_SHIFT				3
 #define MODE_SENSE10_MPH_SIZE				8
-#define MODE_SENSE10_ALLOC_LEN_OFFSET			7
-#define MODE_SELECT_CDB_PAGE_FORMAT_OFFSET		1
-#define MODE_SELECT_CDB_SAVE_PAGES_OFFSET		1
-#define MODE_SELECT_6_CDB_PARAM_LIST_LENGTH_OFFSET	4
-#define MODE_SELECT_10_CDB_PARAM_LIST_LENGTH_OFFSET	7
 #define MODE_SELECT_CDB_PAGE_FORMAT_MASK		0x10
 #define MODE_SELECT_CDB_SAVE_PAGES_MASK			0x1
 #define MODE_SELECT_6_BD_OFFSET				3
@@ -218,14 +160,11 @@ static int sg_version_num = 30534;	/* 2 digits for each component */
 #define LOG_PAGE_SUPPORTED_LOG_PAGES_LENGTH		0x07
 #define LOG_PAGE_INFORMATIONAL_EXCEPTIONS_PAGE		0x2F
 #define LOG_PAGE_TEMPERATURE_PAGE			0x0D
-#define LOG_SENSE_CDB_SP_OFFSET				1
 #define LOG_SENSE_CDB_SP_NOT_ENABLED			0
-#define LOG_SENSE_CDB_PC_OFFSET				2
 #define LOG_SENSE_CDB_PC_MASK				0xC0
 #define LOG_SENSE_CDB_PC_SHIFT				6
 #define LOG_SENSE_CDB_PC_CUMULATIVE_VALUES		1
 #define LOG_SENSE_CDB_PAGE_CODE_MASK			0x3F
-#define LOG_SENSE_CDB_ALLOC_LENGTH_OFFSET		7
 #define REMAINING_INFO_EXCP_PAGE_LENGTH			0x8
 #define LOG_INFO_EXCP_PAGE_LENGTH			0xC
 #define REMAINING_TEMP_PAGE_LENGTH			0xC
@@ -275,77 +214,11 @@ static int sg_version_num = 30534;	/* 2 digits for each component */
 #define SCSI_ASCQ_POWER_LOSS_EXPECTED			0x08
 #define SCSI_ASCQ_INVALID_LUN_ID			0x09
 
-/**
- * DEVICE_SPECIFIC_PARAMETER in mode parameter header (see sbc2r16) to
- * enable DPOFUA support type 0x10 value.
- */
-#define DEVICE_SPECIFIC_PARAMETER			0
-#define VPD_ID_DESCRIPTOR_LENGTH sizeof(VPD_IDENTIFICATION_DESCRIPTOR)
-
-/* MACROs to extract information from CDBs */
-
-#define GET_OPCODE(cdb)		cdb[0]
-
-#define GET_U8_FROM_CDB(cdb, index) (cdb[index] << 0)
-
-#define GET_U16_FROM_CDB(cdb, index) ((cdb[index] << 8) | (cdb[index + 1] << 0))
-
-#define GET_U24_FROM_CDB(cdb, index) ((cdb[index] << 16) | \
-(cdb[index + 1] <<  8) | \
-(cdb[index + 2] <<  0))
-
-#define GET_U32_FROM_CDB(cdb, index) ((cdb[index] << 24) | \
-(cdb[index + 1] << 16) | \
-(cdb[index + 2] <<  8) | \
-(cdb[index + 3] <<  0))
-
-#define GET_U64_FROM_CDB(cdb, index) ((((u64)cdb[index]) << 56) | \
-(((u64)cdb[index + 1]) << 48) | \
-(((u64)cdb[index + 2]) << 40) | \
-(((u64)cdb[index + 3]) << 32) | \
-(((u64)cdb[index + 4]) << 24) | \
-(((u64)cdb[index + 5]) << 16) | \
-(((u64)cdb[index + 6]) <<  8) | \
-(((u64)cdb[index + 7]) <<  0))
-
-/* Inquiry Helper Macros */
-#define GET_INQ_EVPD_BIT(cdb) \
-((GET_U8_FROM_CDB(cdb, INQUIRY_EVPD_BYTE_OFFSET) &		\
-INQUIRY_EVPD_BIT_MASK) ? 1 : 0)
-
-#define GET_INQ_PAGE_CODE(cdb)					\
-(GET_U8_FROM_CDB(cdb, INQUIRY_PAGE_CODE_BYTE_OFFSET))
-
-#define GET_INQ_ALLOC_LENGTH(cdb)				\
-(GET_U16_FROM_CDB(cdb, INQUIRY_CDB_ALLOCATION_LENGTH_OFFSET))
-
-/* Report LUNs Helper Macros */
-#define GET_REPORT_LUNS_ALLOC_LENGTH(cdb)			\
-(GET_U32_FROM_CDB(cdb, REPORT_LUNS_CDB_ALLOC_LENGTH_OFFSET))
-
-/* Read Capacity Helper Macros */
-#define GET_READ_CAP_16_ALLOC_LENGTH(cdb)			\
-(GET_U32_FROM_CDB(cdb, READ_CAP_16_CDB_ALLOC_LENGTH_OFFSET))
-
-#define IS_READ_CAP_16(cdb)					\
-((cdb[0] == SERVICE_ACTION_IN_16 && cdb[1] == SAI_READ_CAPACITY_16) ? 1 : 0)
-
-/* Request Sense Helper Macros */
-#define GET_REQUEST_SENSE_ALLOC_LENGTH(cdb)			\
-(GET_U8_FROM_CDB(cdb, REQUEST_SENSE_CDB_ALLOC_LENGTH_OFFSET))
-
-/* Mode Sense Helper Macros */
-#define GET_MODE_SENSE_DBD(cdb)					\
-((GET_U8_FROM_CDB(cdb, MODE_SENSE_DBD_OFFSET) & MODE_SENSE_DBD_MASK) >>	\
-MODE_SENSE_DBD_SHIFT)
-
-#define GET_MODE_SENSE_LLBAA(cdb)				\
-((GET_U8_FROM_CDB(cdb, MODE_SENSE_LLBAA_OFFSET) &		\
-MODE_SENSE_LLBAA_MASK) >> MODE_SENSE_LLBAA_SHIFT)
-
-#define GET_MODE_SENSE_MPH_SIZE(cdb10)				\
-(cdb10 ? MODE_SENSE10_MPH_SIZE : MODE_SENSE6_MPH_SIZE)
-
+/* copied from drivers/usb/gadget/function/storage_common.h */
+static inline u32 get_unaligned_be24(u8 *buf)
+{
+	return 0xffffff & (u32) get_unaligned_be32(buf - 1);
+}
 
 /* Struct to gather data that needs to be extracted from a SCSI CDB.
    Not conforming to any particular CDB variant, but compatible with all. */
@@ -1333,9 +1206,10 @@ static int nvme_trans_mode_page_create(struct nvme_ns *ns,
 	u16 mode_pages_offset_1;
 	u16 blk_desc_len, blk_desc_offset, mode_data_length;
 
-	dbd = GET_MODE_SENSE_DBD(cmd);
-	llbaa = GET_MODE_SENSE_LLBAA(cmd);
-	mph_size = GET_MODE_SENSE_MPH_SIZE(cdb10);
+	dbd = (cmd[1] & MODE_SENSE_DBD_MASK) >> MODE_SENSE_DBD_SHIFT;
+	llbaa = (cmd[1] & MODE_SENSE_LLBAA_MASK) >> MODE_SENSE_LLBAA_SHIFT;
+	mph_size = cdb10 ? MODE_SENSE10_MPH_SIZE : MODE_SENSE6_MPH_SIZE;
+
 	blk_desc_len = nvme_trans_get_blk_desc_len(dbd, llbaa);
 
 	resp_size = mph_size + blk_desc_len + mode_pages_tot_len;
@@ -1895,46 +1769,39 @@ static inline void nvme_trans_get_io_cdb6(u8 *cmd,
 {
 	cdb_info->fua = 0;
 	cdb_info->prot_info = 0;
-	cdb_info->lba = GET_U32_FROM_CDB(cmd, IO_6_CDB_LBA_OFFSET) &
-					IO_6_CDB_LBA_MASK;
-	cdb_info->xfer_len = GET_U8_FROM_CDB(cmd, IO_6_CDB_TX_LEN_OFFSET);
+	cdb_info->lba = get_unaligned_be32(&cmd[0]) & IO_6_CDB_LBA_MASK;
+	cdb_info->xfer_len = cmd[4];
 
 	/* sbc3r27 sec 5.32 - TRANSFER LEN of 0 implies a 256 Block transfer */
 	if (cdb_info->xfer_len == 0)
-		cdb_info->xfer_len = IO_6_DEFAULT_TX_LEN;
+		cdb_info->xfer_len = 256;
 }
 
 static inline void nvme_trans_get_io_cdb10(u8 *cmd,
 					struct nvme_trans_io_cdb *cdb_info)
 {
-	cdb_info->fua = GET_U8_FROM_CDB(cmd, IO_10_CDB_FUA_OFFSET) &
-					IO_CDB_FUA_MASK;
-	cdb_info->prot_info = GET_U8_FROM_CDB(cmd, IO_10_CDB_WP_OFFSET) &
-					IO_CDB_WP_MASK >> IO_CDB_WP_SHIFT;
-	cdb_info->lba = GET_U32_FROM_CDB(cmd, IO_10_CDB_LBA_OFFSET);
-	cdb_info->xfer_len = GET_U16_FROM_CDB(cmd, IO_10_CDB_TX_LEN_OFFSET);
+	cdb_info->fua = cmd[1] & IO_CDB_FUA_MASK;
+	cdb_info->prot_info = cmd[1] & IO_CDB_WP_MASK >> IO_CDB_WP_SHIFT;
+	cdb_info->lba = get_unaligned_be32(&cmd[2]);
+	cdb_info->xfer_len = get_unaligned_be16(&cmd[7]);
 }
 
 static inline void nvme_trans_get_io_cdb12(u8 *cmd,
 					struct nvme_trans_io_cdb *cdb_info)
 {
-	cdb_info->fua = GET_U8_FROM_CDB(cmd, IO_12_CDB_FUA_OFFSET) &
-					IO_CDB_FUA_MASK;
-	cdb_info->prot_info = GET_U8_FROM_CDB(cmd, IO_12_CDB_WP_OFFSET) &
-					IO_CDB_WP_MASK >> IO_CDB_WP_SHIFT;
-	cdb_info->lba = GET_U32_FROM_CDB(cmd, IO_12_CDB_LBA_OFFSET);
-	cdb_info->xfer_len = GET_U32_FROM_CDB(cmd, IO_12_CDB_TX_LEN_OFFSET);
+	cdb_info->fua = cmd[1] & IO_CDB_FUA_MASK;
+	cdb_info->prot_info = cmd[1] & IO_CDB_WP_MASK >> IO_CDB_WP_SHIFT;
+	cdb_info->lba = get_unaligned_be32(&cmd[2]);
+	cdb_info->xfer_len = get_unaligned_be32(&cmd[6]);
 }
 
 static inline void nvme_trans_get_io_cdb16(u8 *cmd,
 					struct nvme_trans_io_cdb *cdb_info)
 {
-	cdb_info->fua = GET_U8_FROM_CDB(cmd, IO_16_CDB_FUA_OFFSET) &
-					IO_CDB_FUA_MASK;
-	cdb_info->prot_info = GET_U8_FROM_CDB(cmd, IO_16_CDB_WP_OFFSET) &
-					IO_CDB_WP_MASK >> IO_CDB_WP_SHIFT;
-	cdb_info->lba = GET_U64_FROM_CDB(cmd, IO_16_CDB_LBA_OFFSET);
-	cdb_info->xfer_len = GET_U32_FROM_CDB(cmd, IO_16_CDB_TX_LEN_OFFSET);
+	cdb_info->fua = cmd[1] & IO_CDB_FUA_MASK;
+	cdb_info->prot_info = cmd[1] & IO_CDB_WP_MASK >> IO_CDB_WP_SHIFT;
+	cdb_info->lba = get_unaligned_be64(&cmd[2]);
+	cdb_info->xfer_len = get_unaligned_be32(&cmd[10]);
 }
 
 static inline u32 nvme_trans_io_get_num_cmds(struct sg_io_hdr *hdr,
@@ -2147,9 +2014,9 @@ static int nvme_trans_inquiry(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	int alloc_len;
 	u8 *inq_response;
 
-	evpd = GET_INQ_EVPD_BIT(cmd);
-	page_code = GET_INQ_PAGE_CODE(cmd);
-	alloc_len = GET_INQ_ALLOC_LENGTH(cmd);
+	evpd = cmd[1] & 0x01;
+	page_code = cmd[2];
+	alloc_len = get_unaligned_be16(&cmd[3]);
 
 	inq_response = kmalloc(max(alloc_len, STANDARD_INQUIRY_LENGTH),
 				GFP_KERNEL);
@@ -2212,27 +2079,25 @@ static int nvme_trans_log_sense(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 {
 	int res;
 	u16 alloc_len;
-	u8 sp;
 	u8 pc;
 	u8 page_code;
 
-	sp = GET_U8_FROM_CDB(cmd, LOG_SENSE_CDB_SP_OFFSET);
-	if (sp != LOG_SENSE_CDB_SP_NOT_ENABLED) {
+	if (cmd[1] != LOG_SENSE_CDB_SP_NOT_ENABLED) {
 		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
 					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
 					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
 		goto out;
 	}
-	pc = GET_U8_FROM_CDB(cmd, LOG_SENSE_CDB_PC_OFFSET);
-	page_code = pc & LOG_SENSE_CDB_PAGE_CODE_MASK;
-	pc = (pc & LOG_SENSE_CDB_PC_MASK) >> LOG_SENSE_CDB_PC_SHIFT;
+
+	page_code = cmd[2] & LOG_SENSE_CDB_PAGE_CODE_MASK;
+	pc = (cmd[2] & LOG_SENSE_CDB_PC_MASK) >> LOG_SENSE_CDB_PC_SHIFT;
 	if (pc != LOG_SENSE_CDB_PC_CUMULATIVE_VALUES) {
 		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
 					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
 					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
 		goto out;
 	}
-	alloc_len = GET_U16_FROM_CDB(cmd, LOG_SENSE_CDB_ALLOC_LENGTH_OFFSET);
+	alloc_len = get_unaligned_be16(&cmd[7]);
 	switch (page_code) {
 	case LOG_PAGE_SUPPORTED_LOG_PAGES_PAGE:
 		res = nvme_trans_log_supp_pages(ns, hdr, alloc_len);
@@ -2262,18 +2127,13 @@ static int nvme_trans_mode_select(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	u8 page_format;
 	u8 save_pages;
 
-	page_format = GET_U8_FROM_CDB(cmd, MODE_SELECT_CDB_PAGE_FORMAT_OFFSET);
-	page_format &= MODE_SELECT_CDB_PAGE_FORMAT_MASK;
+	page_format = cmd[1] & MODE_SELECT_CDB_PAGE_FORMAT_MASK;
+	save_pages = cmd[1] & MODE_SELECT_CDB_SAVE_PAGES_MASK;
 
-	save_pages = GET_U8_FROM_CDB(cmd, MODE_SELECT_CDB_SAVE_PAGES_OFFSET);
-	save_pages &= MODE_SELECT_CDB_SAVE_PAGES_MASK;
-
-	if (GET_OPCODE(cmd) == MODE_SELECT) {
-		parm_list_len = GET_U8_FROM_CDB(cmd,
-				MODE_SELECT_6_CDB_PARAM_LIST_LENGTH_OFFSET);
+	if (cmd[0] == MODE_SELECT) {
+		parm_list_len = cmd[4];
 	} else {
-		parm_list_len = GET_U16_FROM_CDB(cmd,
-				MODE_SELECT_10_CDB_PARAM_LIST_LENGTH_OFFSET);
+		parm_list_len = cmd[7];
 		cdb10 = 1;
 	}
 
@@ -2295,29 +2155,23 @@ static int nvme_trans_mode_sense(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	int res = 0;
 	u16 alloc_len;
 	u8 cdb10 = 0;
-	u8 page_code;
-	u8 pc;
 
-	if (GET_OPCODE(cmd) == MODE_SENSE) {
-		alloc_len = GET_U8_FROM_CDB(cmd, MODE_SENSE6_ALLOC_LEN_OFFSET);
+	if (cmd[0] == MODE_SENSE) {
+		alloc_len = cmd[4];
 	} else {
-		alloc_len = GET_U16_FROM_CDB(cmd,
-						MODE_SENSE10_ALLOC_LEN_OFFSET);
+		alloc_len = get_unaligned_be16(&cmd[7]);
 		cdb10 = 1;
 	}
 
-	pc = GET_U8_FROM_CDB(cmd, MODE_SENSE_PAGE_CONTROL_OFFSET) &
-						MODE_SENSE_PAGE_CONTROL_MASK;
-	if (pc != MODE_SENSE_PC_CURRENT_VALUES) {
+	if ((cmd[2] & MODE_SENSE_PAGE_CONTROL_MASK) !=
+			MODE_SENSE_PC_CURRENT_VALUES) {
 		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
 					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
 					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
 		goto out;
 	}
 
-	page_code = GET_U8_FROM_CDB(cmd, MODE_SENSE_PAGE_CODE_OFFSET) &
-					MODE_SENSE_PAGE_CODE_MASK;
-	switch (page_code) {
+	switch (cmd[2] & MODE_SENSE_PAGE_CODE_MASK) {
 	case MODE_PAGE_CACHING:
 		res = nvme_trans_mode_page_create(ns, hdr, cmd, alloc_len,
 						cdb10,
@@ -2360,24 +2214,25 @@ static int nvme_trans_mode_sense(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 }
 
 static int nvme_trans_read_capacity(struct nvme_ns *ns, struct sg_io_hdr *hdr,
-							u8 *cmd)
+							u8 *cmd, u8 cdb16)
 {
 	int res;
 	int nvme_sc;
-	u32 alloc_len = READ_CAP_10_RESP_SIZE;
-	u32 resp_size = READ_CAP_10_RESP_SIZE;
+	u32 alloc_len;
+	u32 resp_size;
 	u32 xfer_len;
-	u8 cdb16;
 	struct nvme_dev *dev = ns->dev;
 	dma_addr_t dma_addr;
 	void *mem;
 	struct nvme_id_ns *id_ns;
 	u8 *response;
 
-	cdb16 = IS_READ_CAP_16(cmd);
 	if (cdb16) {
-		alloc_len = GET_READ_CAP_16_ALLOC_LENGTH(cmd);
+		alloc_len = get_unaligned_be32(&cmd[10]);
 		resp_size = READ_CAP_16_RESP_SIZE;
+	} else {
+		alloc_len = READ_CAP_10_RESP_SIZE;
+		resp_size = READ_CAP_10_RESP_SIZE;
 	}
 
 	mem = dma_alloc_coherent(dev->dev, sizeof(struct nvme_id_ns),
@@ -2417,7 +2272,6 @@ static int nvme_trans_report_luns(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	int res;
 	int nvme_sc;
 	u32 alloc_len, xfer_len, resp_size;
-	u8 select_report;
 	u8 *response;
 	struct nvme_dev *dev = ns->dev;
 	dma_addr_t dma_addr;
@@ -2427,17 +2281,14 @@ static int nvme_trans_report_luns(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	u8 lun_id_offset = REPORT_LUNS_FIRST_LUN_OFFSET;
 	__be32 tmp_len;
 
-	alloc_len = GET_REPORT_LUNS_ALLOC_LENGTH(cmd);
-	select_report = GET_U8_FROM_CDB(cmd, REPORT_LUNS_SR_OFFSET);
-
-	if ((select_report != ALL_LUNS_RETURNED) &&
-	    (select_report != ALL_WELL_KNOWN_LUNS_RETURNED) &&
-	    (select_report != RESTRICTED_LUNS_RETURNED)) {
-		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+	switch (cmd[2]) {
+	default:
+		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
 					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
 					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-		goto out;
-	} else {
+	case ALL_LUNS_RETURNED:
+	case ALL_WELL_KNOWN_LUNS_RETURNED:
+	case RESTRICTED_LUNS_RETURNED:
 		/* NVMe Controller Identify */
 		mem = dma_alloc_coherent(dev->dev, sizeof(struct nvme_id_ctrl),
 					&dma_addr, GFP_KERNEL);
@@ -2454,6 +2305,7 @@ static int nvme_trans_report_luns(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		ll_length = le32_to_cpu(id_ctrl->nn) * LUN_ENTRY_SIZE;
 		resp_size = ll_length + LUN_DATA_HEADER_SIZE;
 
+		alloc_len = get_unaligned_be32(&cmd[6]);
 		if (alloc_len < resp_size) {
 			res = nvme_trans_completion(hdr,
 					SAM_STAT_CHECK_CONDITION,
@@ -2500,9 +2352,8 @@ static int nvme_trans_request_sense(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	u8 desc_format;
 	u8 *response;
 
-	alloc_len = GET_REQUEST_SENSE_ALLOC_LENGTH(cmd);
-	desc_format = GET_U8_FROM_CDB(cmd, REQUEST_SENSE_DESC_OFFSET);
-	desc_format &= REQUEST_SENSE_DESC_MASK;
+	desc_format = cmd[1] & 0x01;
+	alloc_len = cmd[4];
 
 	resp_size = ((desc_format) ? (DESC_FMT_SENSE_DATA_SIZE) :
 					(FIXED_FMT_SENSE_DATA_SIZE));
@@ -2512,7 +2363,7 @@ static int nvme_trans_request_sense(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		goto out;
 	}
 
-	if (desc_format == DESCRIPTOR_FORMAT_SENSE_DATA_TYPE) {
+	if (desc_format) {
 		/* Descriptor Format Sense Data */
 		response[0] = DESC_FORMAT_SENSE_DATA;
 		response[1] = NO_SENSE;
@@ -2559,17 +2410,11 @@ static int nvme_trans_start_stop(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	struct nvme_command c;
 	u8 immed, pcmod, pc, no_flush, start;
 
-	immed = GET_U8_FROM_CDB(cmd, START_STOP_UNIT_CDB_IMMED_OFFSET);
-	pcmod = GET_U8_FROM_CDB(cmd, START_STOP_UNIT_CDB_POWER_COND_MOD_OFFSET);
-	pc = GET_U8_FROM_CDB(cmd, START_STOP_UNIT_CDB_POWER_COND_OFFSET);
-	no_flush = GET_U8_FROM_CDB(cmd, START_STOP_UNIT_CDB_NO_FLUSH_OFFSET);
-	start = GET_U8_FROM_CDB(cmd, START_STOP_UNIT_CDB_START_OFFSET);
-
-	immed &= START_STOP_UNIT_CDB_IMMED_MASK;
-	pcmod &= START_STOP_UNIT_CDB_POWER_COND_MOD_MASK;
-	pc = (pc & START_STOP_UNIT_CDB_POWER_COND_MASK) >> NIBBLE_SHIFT;
-	no_flush &= START_STOP_UNIT_CDB_NO_FLUSH_MASK;
-	start &= START_STOP_UNIT_CDB_START_MASK;
+	immed = cmd[1] & 0x01;
+	pcmod = cmd[3] & 0x0f;
+	pc = (cmd[4] & 0xf0) >> 4;
+	no_flush = cmd[4] & 0x04;
+	start = cmd[4] & 0x01;
 
 	if (immed != 0) {
 		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
@@ -2614,16 +2459,9 @@ static int nvme_trans_format_unit(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	u8 nvme_pf_code = 0;
 	u8 format_prot_info, long_list, format_data;
 
-	format_prot_info = GET_U8_FROM_CDB(cmd,
-				FORMAT_UNIT_CDB_FORMAT_PROT_INFO_OFFSET);
-	long_list = GET_U8_FROM_CDB(cmd, FORMAT_UNIT_CDB_LONG_LIST_OFFSET);
-	format_data = GET_U8_FROM_CDB(cmd, FORMAT_UNIT_CDB_FORMAT_DATA_OFFSET);
-
-	format_prot_info = (format_prot_info &
-				FORMAT_UNIT_CDB_FORMAT_PROT_INFO_MASK) >>
-				FORMAT_UNIT_CDB_FORMAT_PROT_INFO_SHIFT;
-	long_list &= FORMAT_UNIT_CDB_LONG_LIST_MASK;
-	format_data &= FORMAT_UNIT_CDB_FORMAT_DATA_MASK;
+	format_prot_info = (cmd[1] & 0xc0) >> 6;
+	long_list = cmd[1] & 0x20;
+	format_data = cmd[1] & 0x10;
 
 	if (format_data != 0) {
 		if (format_prot_info != 0) {
@@ -2686,8 +2524,7 @@ static int nvme_trans_write_buffer(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	u32 buffer_offset, parm_list_length;
 	u8 buffer_id, mode;
 
-	parm_list_length =
-		GET_U24_FROM_CDB(cmd, WRITE_BUFFER_CDB_PARM_LIST_LENGTH_OFFSET);
+	parm_list_length = get_unaligned_be24(&cmd[6]);
 	if (parm_list_length % BYTES_TO_DWORDS != 0) {
 		/* NVMe expects Firmware file to be a whole number of DWORDS */
 		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
@@ -2695,17 +2532,15 @@ static int nvme_trans_write_buffer(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
 		goto out;
 	}
-	buffer_id = GET_U8_FROM_CDB(cmd, WRITE_BUFFER_CDB_BUFFER_ID_OFFSET);
+	buffer_id = cmd[2];
 	if (buffer_id > NVME_MAX_FIRMWARE_SLOT) {
 		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
 					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
 					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
 		goto out;
 	}
-	mode = GET_U8_FROM_CDB(cmd, WRITE_BUFFER_CDB_MODE_OFFSET) &
-						WRITE_BUFFER_CDB_MODE_MASK;
-	buffer_offset =
-		GET_U24_FROM_CDB(cmd, WRITE_BUFFER_CDB_BUFFER_OFFSET_OFFSET);
+	mode = cmd[1] & 0x1f;
+	buffer_offset = get_unaligned_be24(&cmd[3]);
 
 	switch (mode) {
 	case DOWNLOAD_SAVE_ACTIVATE:
@@ -2759,7 +2594,7 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	u16 ndesc, list_len;
 	dma_addr_t dma_addr;
 
-	list_len = GET_U16_FROM_CDB(cmd, UNMAP_CDB_PARAM_LIST_LENGTH_OFFSET);
+	list_len = get_unaligned_be16(&cmd[7]);
 	if (!list_len)
 		return -EINVAL;
 
@@ -2853,13 +2688,16 @@ static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr *hdr)
 		retcode = nvme_trans_mode_sense(ns, hdr, cmd);
 		break;
 	case READ_CAPACITY:
-		retcode = nvme_trans_read_capacity(ns, hdr, cmd);
+		retcode = nvme_trans_read_capacity(ns, hdr, cmd, 0);
 		break;
 	case SERVICE_ACTION_IN_16:
-		if (IS_READ_CAP_16(cmd))
-			retcode = nvme_trans_read_capacity(ns, hdr, cmd);
-		else
+		switch (cmd[1]) {
+		case SAI_READ_CAPACITY_16:
+			retcode = nvme_trans_read_capacity(ns, hdr, cmd, 1);
+			break;
+		default:
 			goto out;
+		}
 		break;
 	case REPORT_LUNS:
 		retcode = nvme_trans_report_luns(ns, hdr, cmd);
-- 
1.9.1
