From: jsmart2021@gmail.com (James Smart)
Date: Fri, 02 Dec 2016 00:28:39 -0800
Subject: [PATCH v6 2/7] nvme-fabrics: Add FC transport error codes to
 nvme.h
Message-ID: <584130b7.vb8EHhNEU42ULpEY%jsmart2021@gmail.com>


Add FC transport error codes to nvme.h

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 include/linux/nvme.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5bf1d2d..3d1c6f1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -993,6 +993,19 @@ enum {
 	NVME_SC_UNWRITTEN_BLOCK		= 0x287,
 
 	NVME_SC_DNR			= 0x4000,
+
+
+	/*
+	 * FC Transport-specific error status values for NVME commands
+	 *
+	 * Transport-specific status code values must be in the range 0xB0..0xBF
+	 */
+
+	/* Generic FC failure - catchall */
+	NVME_SC_FC_TRANSPORT_ERROR	= 0x00B0,
+
+	/* I/O failure due to FC ABTS'd */
+	NVME_SC_FC_TRANSPORT_ABORTED	= 0x00B1,
 };
 
 struct nvme_completion {
-- 
2.5.0
