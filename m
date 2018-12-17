From: yupeng0921@gmail.com (yupeng)
Date: Mon, 17 Dec 2018 00:06:04 -0800
Subject: [PATCH v3 1/2] share nvme trace event helper functions with other
 modules
Message-ID: <20181217080605.16867-1-yupeng0921@gmail.com>

Currently the trace.c/trace.h could only be used by nvme-core. This
patch moves __assign_disk_name to genhd.h, exports nvme_trace_disk_name to
other modules. Thus other nvme modules could also trace disk name.

Signed-off-by: yupeng <yupeng0921 at gmail.com>
---
 drivers/nvme/host/trace.c |  2 ++
 drivers/nvme/host/trace.h | 10 ----------
 include/linux/genhd.h     |  8 ++++++++
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 25b0e310f4a8..99a132a34403 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -139,3 +139,5 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 
 	return ret;
 }
+
+EXPORT_SYMBOL_GPL(nvme_trace_disk_name);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 196d5bd56718..23f3fcf04fb6 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -82,16 +82,6 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name);
 #define __print_disk_name(name)				\
 	nvme_trace_disk_name(p, name)
 
-#ifndef TRACE_HEADER_MULTI_READ
-static inline void __assign_disk_name(char *name, struct gendisk *disk)
-{
-	if (disk)
-		memcpy(name, disk->disk_name, DISK_NAME_LEN);
-	else
-		memset(name, 0, DISK_NAME_LEN);
-}
-#endif
-
 TRACE_EVENT(nvme_setup_cmd,
 	    TP_PROTO(struct request *req, struct nvme_command *cmd),
 	    TP_ARGS(req, cmd),
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 70fc838e6773..468ab3143d77 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -749,6 +749,14 @@ static inline void blk_integrity_add(struct gendisk *disk) { }
 static inline void blk_integrity_del(struct gendisk *disk) { }
 #endif	/* CONFIG_BLK_DEV_INTEGRITY */
 
+static inline void __assign_disk_name(char *name, struct gendisk *disk)
+{
+	if (disk)
+		memcpy(name, disk->disk_name, DISK_NAME_LEN);
+	else
+		memset(name, 0, DISK_NAME_LEN);
+}
+
 #else /* CONFIG_BLOCK */
 
 static inline void printk_all_partitions(void) { }
-- 
2.17.1
