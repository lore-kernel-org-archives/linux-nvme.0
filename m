From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon,  6 May 2019 00:22:01 +0900
Subject: [PATCH] nvme-trace: Add fabrics command opcode name
Message-ID: <20190505152201.23830-1-minwoo.im.dev@gmail.com>

Opcode 0x7F is for fabrics commands.  We can also print it out
"nvme_fabrics_command" instead of 0x7f in raw.

Before this patch:
  cmd=(0x7f cdw10=00 00 00 00 1f 00 00 00 98 3a 00 00 ......

After this patch:
  cmd=(nvme_fabrics_command cdw10=00 00 00 00 1f 00 00 00 98 3a 00 00 ....

It would be nicer if trace can show which command in fabrics commands
are now being excuted, but not for this time.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/trace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 97d3c77365b8..f91580bf2e2f 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -37,6 +37,7 @@
 		nvme_admin_opcode_name(nvme_admin_directive_send),	\
 		nvme_admin_opcode_name(nvme_admin_directive_recv),	\
 		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
+		nvme_admin_opcode_name(nvme_fabrics_command),		\
 		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
 		nvme_admin_opcode_name(nvme_admin_security_send),	\
 		nvme_admin_opcode_name(nvme_admin_security_recv),	\
-- 
2.17.1
