From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 12 Jun 2019 21:45:30 +0900
Subject: [PATCH V8 2/5] nvme: trace: move opcode symbol print to nvme.h
In-Reply-To: <20190612124533.10299-1-minwoo.im.dev@gmail.com>
References: <20190612124533.10299-1-minwoo.im.dev@gmail.com>
Message-ID: <20190612124533.10299-3-minwoo.im.dev@gmail.com>

The following patches are going to provide the target-side trace which
might need these kind of macros.  It would be great if it can be shared
between host and target side both.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/trace.h | 44 --------------------------------------
 include/linux/nvme.h      | 45 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index e71502d141ed..62ee29107c32 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -16,50 +16,6 @@
 
 #include "nvme.h"
 
-#define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
-#define show_admin_opcode_name(val)					\
-	__print_symbolic(val,						\
-		nvme_admin_opcode_name(nvme_admin_delete_sq),		\
-		nvme_admin_opcode_name(nvme_admin_create_sq),		\
-		nvme_admin_opcode_name(nvme_admin_get_log_page),	\
-		nvme_admin_opcode_name(nvme_admin_delete_cq),		\
-		nvme_admin_opcode_name(nvme_admin_create_cq),		\
-		nvme_admin_opcode_name(nvme_admin_identify),		\
-		nvme_admin_opcode_name(nvme_admin_abort_cmd),		\
-		nvme_admin_opcode_name(nvme_admin_set_features),	\
-		nvme_admin_opcode_name(nvme_admin_get_features),	\
-		nvme_admin_opcode_name(nvme_admin_async_event),		\
-		nvme_admin_opcode_name(nvme_admin_ns_mgmt),		\
-		nvme_admin_opcode_name(nvme_admin_activate_fw),		\
-		nvme_admin_opcode_name(nvme_admin_download_fw),		\
-		nvme_admin_opcode_name(nvme_admin_ns_attach),		\
-		nvme_admin_opcode_name(nvme_admin_keep_alive),		\
-		nvme_admin_opcode_name(nvme_admin_directive_send),	\
-		nvme_admin_opcode_name(nvme_admin_directive_recv),	\
-		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
-		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
-		nvme_admin_opcode_name(nvme_admin_security_send),	\
-		nvme_admin_opcode_name(nvme_admin_security_recv),	\
-		nvme_admin_opcode_name(nvme_admin_sanitize_nvm))
-
-#define nvme_opcode_name(opcode)	{ opcode, #opcode }
-#define show_nvm_opcode_name(val)				\
-	__print_symbolic(val,					\
-		nvme_opcode_name(nvme_cmd_flush),		\
-		nvme_opcode_name(nvme_cmd_write),		\
-		nvme_opcode_name(nvme_cmd_read),		\
-		nvme_opcode_name(nvme_cmd_write_uncor),		\
-		nvme_opcode_name(nvme_cmd_compare),		\
-		nvme_opcode_name(nvme_cmd_write_zeroes),	\
-		nvme_opcode_name(nvme_cmd_dsm),			\
-		nvme_opcode_name(nvme_cmd_resv_register),	\
-		nvme_opcode_name(nvme_cmd_resv_report),		\
-		nvme_opcode_name(nvme_cmd_resv_acquire),	\
-		nvme_opcode_name(nvme_cmd_resv_release))
-
-#define show_opcode_name(qid, opcode)					\
-	(qid ? show_nvm_opcode_name(opcode) : show_admin_opcode_name(opcode))
-
 const char *nvme_trace_parse_admin_cmd(struct trace_seq *p, u8 opcode,
 		u8 *cdw10);
 const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7080923e78d1..86b3d04baf20 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -562,6 +562,22 @@ enum nvme_opcode {
 	nvme_cmd_resv_release	= 0x15,
 };
 
+#define nvme_opcode_name(opcode)	{ opcode, #opcode }
+#define show_nvm_opcode_name(val)				\
+	__print_symbolic(val,					\
+		nvme_opcode_name(nvme_cmd_flush),		\
+		nvme_opcode_name(nvme_cmd_write),		\
+		nvme_opcode_name(nvme_cmd_read),		\
+		nvme_opcode_name(nvme_cmd_write_uncor),		\
+		nvme_opcode_name(nvme_cmd_compare),		\
+		nvme_opcode_name(nvme_cmd_write_zeroes),	\
+		nvme_opcode_name(nvme_cmd_dsm),			\
+		nvme_opcode_name(nvme_cmd_resv_register),	\
+		nvme_opcode_name(nvme_cmd_resv_report),		\
+		nvme_opcode_name(nvme_cmd_resv_acquire),	\
+		nvme_opcode_name(nvme_cmd_resv_release))
+
+
 /*
  * Descriptor subtype - lower 4 bits of nvme_(keyed_)sgl_desc identifier
  *
@@ -794,6 +810,35 @@ enum nvme_admin_opcode {
 	nvme_admin_sanitize_nvm		= 0x84,
 };
 
+#define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
+#define show_admin_opcode_name(val)					\
+	__print_symbolic(val,						\
+		nvme_admin_opcode_name(nvme_admin_delete_sq),		\
+		nvme_admin_opcode_name(nvme_admin_create_sq),		\
+		nvme_admin_opcode_name(nvme_admin_get_log_page),	\
+		nvme_admin_opcode_name(nvme_admin_delete_cq),		\
+		nvme_admin_opcode_name(nvme_admin_create_cq),		\
+		nvme_admin_opcode_name(nvme_admin_identify),		\
+		nvme_admin_opcode_name(nvme_admin_abort_cmd),		\
+		nvme_admin_opcode_name(nvme_admin_set_features),	\
+		nvme_admin_opcode_name(nvme_admin_get_features),	\
+		nvme_admin_opcode_name(nvme_admin_async_event),		\
+		nvme_admin_opcode_name(nvme_admin_ns_mgmt),		\
+		nvme_admin_opcode_name(nvme_admin_activate_fw),		\
+		nvme_admin_opcode_name(nvme_admin_download_fw),		\
+		nvme_admin_opcode_name(nvme_admin_ns_attach),		\
+		nvme_admin_opcode_name(nvme_admin_keep_alive),		\
+		nvme_admin_opcode_name(nvme_admin_directive_send),	\
+		nvme_admin_opcode_name(nvme_admin_directive_recv),	\
+		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
+		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
+		nvme_admin_opcode_name(nvme_admin_security_send),	\
+		nvme_admin_opcode_name(nvme_admin_security_recv),	\
+		nvme_admin_opcode_name(nvme_admin_sanitize_nvm))
+
+#define show_opcode_name(qid, opcode)					\
+	(qid ? show_nvm_opcode_name(opcode) : show_admin_opcode_name(opcode))
+
 enum {
 	NVME_QUEUE_PHYS_CONTIG	= (1 << 0),
 	NVME_CQ_IRQ_ENABLED	= (1 << 1),
-- 
2.21.0
