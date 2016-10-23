From: james.smart@broadcom.com (James Smart)
Date: Sun, 23 Oct 2016 12:31:06 -0700
Subject: [PATCH v3 2/7] nvme-fabrics: Add FC transport error codes to
 nvme.h
Message-ID: <580d0ffa.P8ZUhj3iv4ynik6T%james.smart@broadcom.com>


Add FC transport error codes to nvme.h

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 include/linux/nvme.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7676557..4bfaaae 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -943,6 +943,26 @@ enum {
 	NVME_SC_ACCESS_DENIED		= 0x286,
 
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
+
+	/* IU format error */
+	NVME_SC_FC_FORMAT		= 0x00B2,
+
+	/* NVME Completion did not contain original CMDID */
+	NVME_SC_FC_CMDID_MISMATCH	= 0x00B3,
+
 };
 
 struct nvme_completion {
-- 
2.5.0
