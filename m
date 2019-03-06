From: keith.busch@intel.com (Keith Busch)
Date: Wed,  6 Mar 2019 15:03:44 -0700
Subject: [PATCH] nvme/trace: Fix cdw10 buffer overrun
Message-ID: <20190306220344.1733-1-keith.busch@intel.com>

The field is defined to be a 24 byte array, we don't need to multiply
the sizeof() that field by the number of dwords it covers.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 244d7c177e5a..97d3c77365b8 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -108,7 +108,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__entry->metadata = le64_to_cpu(cmd->common.metadata);
 		__assign_disk_name(__entry->disk, req->rq_disk);
 		memcpy(__entry->cdw10, &cmd->common.cdw10,
-			6 * sizeof(__entry->cdw10));
+			sizeof(__entry->cdw10));
 	    ),
 	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
 		      __entry->ctrl_id, __print_disk_name(__entry->disk),
-- 
2.14.4
