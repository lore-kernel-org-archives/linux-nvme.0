From: tomwu@mellanox.com (Tom Wu)
Date: Thu,  4 Jul 2019 10:19:54 +0000
Subject: [PATCH] nvme: add delete completion and submission queue to admin
 cmds tracer
Message-ID: <1562235594-7847-1-git-send-email-tomwu@mellanox.com>

The trace log for 'delete I/O submission queue' and 'delete I/O
completion queue' command will look like as below:

kworker/u49:1-3438  [003] ....  6693.070865: nvme_setup_cmd: nvme0: qid=0, cmdid=11, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_delete_sq sqid=1)
kworker/u49:1-3438  [003] ....  6693.071171: nvme_setup_cmd: nvme0: qid=0, cmdid=8, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_delete_cq cqid=24)

Signed-off-by: Tom Wu <tomwu at mellanox.com>
Reviewed-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/trace.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 5f24ea7..a19978f 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -7,6 +7,17 @@
 #include <asm/unaligned.h>
 #include "trace.h"
 
+static const char *nvme_trace_delete_sq(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u16 sqid = get_unaligned_le16(cdw10);
+
+	trace_seq_printf(p, "sqid=%u", sqid);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *nvme_trace_create_sq(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -23,6 +34,17 @@ static const char *nvme_trace_create_sq(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvme_trace_delete_cq(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u16 cqid = get_unaligned_le16(cdw10);
+
+	trace_seq_printf(p, "cqid=%u", cqid);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *nvme_trace_create_cq(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -107,8 +129,12 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
 				       u8 opcode, u8 *cdw10)
 {
 	switch (opcode) {
+	case nvme_admin_delete_sq:
+		return nvme_trace_delete_sq(p, cdw10);
 	case nvme_admin_create_sq:
 		return nvme_trace_create_sq(p, cdw10);
+	case nvme_admin_delete_cq:
+		return nvme_trace_delete_cq(p, cdw10);
 	case nvme_admin_create_cq:
 		return nvme_trace_create_cq(p, cdw10);
 	case nvme_admin_identify:
-- 
1.8.4.3
