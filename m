From: hch@lst.de (Christoph Hellwig)
Date: Wed,  9 Mar 2016 17:54:37 +0100
Subject: [PATCH] nvme: add a constant for the identify payload size
Message-ID: <1457542477-25191-1-git-send-email-hch@lst.de>

The NVMe spec specifies a hardcoded payload length of 4k for all
types of Identify commands.  Use a constant instead of hardcoded
values that can be confused for the page size.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c     | 5 +++--
 drivers/nvme/host/lightnvm.c | 2 +-
 drivers/nvme/host/pci.c      | 4 ++--
 include/linux/nvme.h         | 2 ++
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4304be0..64d8ede 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -302,7 +302,8 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.cns = cpu_to_le32(2);
 	c.identify.nsid = cpu_to_le32(nsid);
-	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list, 0x1000);
+	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list,
+			NVME_IDENTIFY_DATA_SIZE);
 }
 
 int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
@@ -1294,7 +1295,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 	unsigned i, j, nsid, prev = 0, num_lists = DIV_ROUND_UP(nn, 1024);
 	int ret = 0;
 
-	ns_list = kzalloc(0x1000, GFP_KERNEL);
+	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
 	if (!ns_list)
 		return -ENOMEM;
 
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index d4f81f0..da236f0 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -239,7 +239,7 @@ static inline void _nvme_nvm_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_erase_blk) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_id_group) != 960);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_addr_format) != 128);
-	BUILD_BUG_ON(sizeof(struct nvme_nvm_id) != 4096);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_id) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_bb_tbl) != 512);
 }
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e9f18e1..1d1c6d1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -172,8 +172,8 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
-	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != 4096);
-	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
+	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
+	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 }
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index a55986f..b0909ad 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -153,6 +153,8 @@ struct nvme_lbaf {
 	__u8			rp;
 };
 
+#define NVME_IDENTIFY_DATA_SIZE	0x1000
+
 struct nvme_id_ns {
 	__le64			nsze;
 	__le64			ncap;
-- 
2.1.4
