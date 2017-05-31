From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 31 May 2017 15:32:16 +0200
Subject: [PATCH v1 6/7] nvme: change magic 4096 to SZ_4K
In-Reply-To: <cover.1496237370.git.jthumshirn@suse.de>
References: <cover.1496237370.git.jthumshirn@suse.de>
Message-ID: <9d231ec2f7b34221685a305ecb02d9da884b9c08.1496237370.git.jthumshirn@suse.de>

Change the magic 4096 or 0x1000 to SZ_4K so it's easier to spot typos.

The magic numbers in the BUILD_BUG_ON() calls are left in place as
there are no defines used for the other sizes as well.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c        | 4 ++--
 drivers/nvme/host/pci.c         | 6 +++---
 drivers/nvme/target/admin-cmd.c | 4 ++--
 drivers/nvme/target/discovery.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4de162e4e13e..fb7542be733d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -715,7 +715,7 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.cns = NVME_ID_CNS_NS_ACTIVE_LIST;
 	c.identify.nsid = cpu_to_le32(nsid);
-	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list, 0x1000);
+	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list, SZ_4K);
 }
 
 int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
@@ -2262,7 +2262,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 	unsigned i, j, nsid, prev = 0, num_lists = DIV_ROUND_UP(nn, 1024);
 	int ret = 0;
 
-	ns_list = kzalloc(0x1000, GFP_KERNEL);
+	ns_list = kzalloc(SZ_4K, GFP_KERNEL);
 	if (!ns_list)
 		return -ENOMEM;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d52701df7245..4060ab02e76e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1516,7 +1516,7 @@ static inline void nvme_release_cmb(struct nvme_dev *dev)
 
 static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
 {
-	return 4096 + ((nr_io_queues + 1) * 8 * dev->db_stride);
+	return SZ_4K + ((nr_io_queues + 1) * 8 * dev->db_stride);
 }
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)
@@ -1553,7 +1553,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 				return -ENOMEM;
 			size = db_bar_size(dev, nr_io_queues);
 		} while (1);
-		dev->dbs = dev->bar + 4096;
+		dev->dbs = dev->bar + SZ_4K;
 		adminq->q_db = dev->dbs;
 	}
 
@@ -1732,7 +1732,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
-	dev->dbs = dev->bar + 4096;
+	dev->dbs = dev->bar + SZ_4K;
 
 	/*
 	 * Temporary fix for the Apple controller found in the MacBook8,1 and
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f53cab51b090..1a0bf35340ef 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -336,7 +336,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 {
-	static const int buf_size = 4096;
+	static const int buf_size = SZ_4K;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_ns *ns;
 	u32 min_nsid = le32_to_cpu(req->cmd->identify.nsid);
@@ -564,7 +564,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		}
 		break;
 	case nvme_admin_identify:
-		req->data_len = 4096;
+		req->data_len = SZ_4K;
 		switch (cmd->identify.cns) {
 		case NVME_ID_CNS_NS:
 			req->execute = nvmet_execute_identify_ns;
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 1aaf597e81fc..0450abc37837 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -185,7 +185,7 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
 	case nvme_admin_identify:
-		req->data_len = 4096;
+		req->data_len = SZ_4K;
 		switch (cmd->identify.cns) {
 		case NVME_ID_CNS_CTRL:
 			req->execute =
-- 
2.12.0
