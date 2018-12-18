From: yupeng0921@gmail.com (yupeng)
Date: Mon, 17 Dec 2018 20:51:37 -0800
Subject: [PATCH v4 1/2] export trace.c helper functions to other modules
Message-ID: <20181218045138.4282-1-yupeng0921@gmail.com>

Export bellow three functions:
nvme_trace_parse_admin_cmd
nvme_trace_parse_nvm_cmd
nvme_trace_disk_name
Thus any other modules which depends on nvme-core could use the trace
events in trace.h

Signed-off-by: yupeng <yupeng0921 at gmail.com>
---
 drivers/nvme/host/trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 25b0e310f4a8..8ca7079ed2bc 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -113,6 +113,7 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
 		return nvme_trace_common(p, cdw10);
 	}
 }
+EXPORT_SYMBOL_GPL(nvme_trace_parse_admin_cmd);
 
 const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 				     u8 opcode, u8 *cdw10)
@@ -128,6 +129,7 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 		return nvme_trace_common(p, cdw10);
 	}
 }
+EXPORT_SYMBOL_GPL(nvme_trace_parse_nvm_cmd);
 
 const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 {
@@ -139,3 +141,4 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nvme_trace_disk_name);
-- 
2.17.1
