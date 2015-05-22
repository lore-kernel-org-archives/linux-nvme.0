From: hch@lst.de (Christoph Hellwig)
Date: Fri, 22 May 2015 11:12:43 +0200
Subject: [PATCH 6/9] nvme: simplify and cleanup the READ/WRITE SCSI CDB
 parsing code
In-Reply-To: <1432285966-31770-1-git-send-email-hch@lst.de>
References: <1432285966-31770-1-git-send-email-hch@lst.de>
Message-ID: <1432285966-31770-7-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-scsi.c | 78 +++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 54 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 9fe0a2c..b119143 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -107,12 +107,6 @@ static int sg_version_num = 30534;	/* 2 digits for each component */
 #define EXTENDED_INQUIRY_DATA_PAGE_LENGTH		0x3C
 #define RESERVED_FIELD					0
 
-/* SCSI READ/WRITE Defines */
-#define IO_CDB_WP_MASK					0xE0
-#define IO_CDB_WP_SHIFT					5
-#define IO_CDB_FUA_MASK					0x8
-#define IO_6_CDB_LBA_MASK				0x001FFFFF
-
 /* Mode Sense/Select defines */
 #define MODE_PAGE_INFO_EXCEP				0x1C
 #define MODE_PAGE_CACHING				0x08
@@ -1763,48 +1757,6 @@ static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	return res;
 }
 
-/* Read/Write Helper Functions */
-
-static inline void nvme_trans_get_io_cdb6(u8 *cmd,
-					struct nvme_trans_io_cdb *cdb_info)
-{
-	cdb_info->fua = 0;
-	cdb_info->prot_info = 0;
-	cdb_info->lba = get_unaligned_be32(&cmd[0]) & IO_6_CDB_LBA_MASK;
-	cdb_info->xfer_len = cmd[4];
-
-	/* sbc3r27 sec 5.32 - TRANSFER LEN of 0 implies a 256 Block transfer */
-	if (cdb_info->xfer_len == 0)
-		cdb_info->xfer_len = 256;
-}
-
-static inline void nvme_trans_get_io_cdb10(u8 *cmd,
-					struct nvme_trans_io_cdb *cdb_info)
-{
-	cdb_info->fua = cmd[1] & IO_CDB_FUA_MASK;
-	cdb_info->prot_info = cmd[1] & IO_CDB_WP_MASK >> IO_CDB_WP_SHIFT;
-	cdb_info->lba = get_unaligned_be32(&cmd[2]);
-	cdb_info->xfer_len = get_unaligned_be16(&cmd[7]);
-}
-
-static inline void nvme_trans_get_io_cdb12(u8 *cmd,
-					struct nvme_trans_io_cdb *cdb_info)
-{
-	cdb_info->fua = cmd[1] & IO_CDB_FUA_MASK;
-	cdb_info->prot_info = cmd[1] & IO_CDB_WP_MASK >> IO_CDB_WP_SHIFT;
-	cdb_info->lba = get_unaligned_be32(&cmd[2]);
-	cdb_info->xfer_len = get_unaligned_be32(&cmd[6]);
-}
-
-static inline void nvme_trans_get_io_cdb16(u8 *cmd,
-					struct nvme_trans_io_cdb *cdb_info)
-{
-	cdb_info->fua = cmd[1] & IO_CDB_FUA_MASK;
-	cdb_info->prot_info = cmd[1] & IO_CDB_WP_MASK >> IO_CDB_WP_SHIFT;
-	cdb_info->lba = get_unaligned_be64(&cmd[2]);
-	cdb_info->xfer_len = get_unaligned_be32(&cmd[10]);
-}
-
 static inline u32 nvme_trans_io_get_num_cmds(struct sg_io_hdr *hdr,
 					struct nvme_trans_io_cdb *cdb_info,
 					u32 max_blocks)
@@ -1929,7 +1881,7 @@ static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 is_write,
 							u8 *cmd)
 {
 	int res = 0;
-	struct nvme_trans_io_cdb cdb_info;
+	struct nvme_trans_io_cdb cdb_info = { 0, };
 	u8 opcode = cmd[0];
 	u64 xfer_bytes;
 	u64 sum_iov_len = 0;
@@ -1937,23 +1889,41 @@ static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 is_write,
 	int i;
 	size_t not_copied;
 
-	/* Extract Fields from CDB */
+	/*
+	 * The FUA and WPROTECT fields are not supported in 6-byte CDBs,
+	 * but always in the same place for all others.
+	 */
+	switch (opcode) {
+	case WRITE_6:
+	case READ_6:
+		break;
+	default:
+		cdb_info.fua = cmd[1] & 0x8;
+		cdb_info.prot_info = (cmd[1] & 0xe0) >> 5;
+	}
+
 	switch (opcode) {
 	case WRITE_6:
 	case READ_6:
-		nvme_trans_get_io_cdb6(cmd, &cdb_info);
+		cdb_info.lba = get_unaligned_be24(&cmd[1]);
+		cdb_info.xfer_len = cmd[4];
+		if (cdb_info.xfer_len == 0)
+			cdb_info.xfer_len = 256;
 		break;
 	case WRITE_10:
 	case READ_10:
-		nvme_trans_get_io_cdb10(cmd, &cdb_info);
+		cdb_info.lba = get_unaligned_be32(&cmd[2]);
+		cdb_info.xfer_len = get_unaligned_be16(&cmd[7]);
 		break;
 	case WRITE_12:
 	case READ_12:
-		nvme_trans_get_io_cdb12(cmd, &cdb_info);
+		cdb_info.lba = get_unaligned_be32(&cmd[2]);
+		cdb_info.xfer_len = get_unaligned_be32(&cmd[6]);
 		break;
 	case WRITE_16:
 	case READ_16:
-		nvme_trans_get_io_cdb16(cmd, &cdb_info);
+		cdb_info.lba = get_unaligned_be64(&cmd[2]);
+		cdb_info.xfer_len = get_unaligned_be32(&cmd[10]);
 		break;
 	default:
 		/* Will never really reach here */
-- 
1.9.1
