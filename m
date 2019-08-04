From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun,  4 Aug 2019 16:50:48 +0900
Subject: [PATCH 2/4] nvme: trace: support for Get LBA Status opcode parsed
In-Reply-To: <20190804075050.14642-1-minwoo.im.dev@gmail.com>
References: <20190804075050.14642-1-minwoo.im.dev@gmail.com>
Message-ID: <20190804075050.14642-3-minwoo.im.dev@gmail.com>

This patch adds Get LBA Status command's opcode to the macro that is
used by the trace feature.  Now we can see "get_lba_status" instead of
the opcode value itself.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 include/linux/nvme.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index a01277501eae..32c25b46ae63 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -841,7 +841,8 @@ enum nvme_admin_opcode {
 		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
 		nvme_admin_opcode_name(nvme_admin_security_send),	\
 		nvme_admin_opcode_name(nvme_admin_security_recv),	\
-		nvme_admin_opcode_name(nvme_admin_sanitize_nvm))
+		nvme_admin_opcode_name(nvme_admin_sanitize_nvm),	\
+		nvme_admin_opcode_name(nvme_admin_get_lba_status))
 
 enum {
 	NVME_QUEUE_PHYS_CONTIG	= (1 << 0),
-- 
2.17.1
