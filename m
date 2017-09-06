From: hch@lst.de (Christoph Hellwig)
Date: Wed,  6 Sep 2017 15:55:32 +0200
Subject: [PATCH 4/4] nvme-pci: implement the HMB entry number and size
 limitations
In-Reply-To: <20170906135532.21358-1-hch@lst.de>
References: <20170906135532.21358-1-hch@lst.de>
Message-ID: <20170906135532.21358-5-hch@lst.de>

Adds support for the new Host Memory Buffer Minimum Descriptor Entry Size
and Host Memory Maximum Descriptors Entries field that were added in
TP 4002 HMB Enhancements.  These allow the controller to advertise
limits for the usual number of segments in the host memory buffer, as
well as a minimum usable per-segment size.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 2 ++
 drivers/nvme/host/nvme.h | 3 +++
 drivers/nvme/host/pci.c  | 6 +++++-
 include/linux/nvme.h     | 4 +++-
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 277a7a02cba5..407fc1c80d5b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1897,6 +1897,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		ctrl->cntlid = le16_to_cpu(id->cntlid);
 		ctrl->hmpre = le32_to_cpu(id->hmpre);
 		ctrl->hmmin = le32_to_cpu(id->hmmin);
+		ctrl->hmminds = le32_to_cpu(id->hmminds);
+		ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
 	}
 
 	kfree(id);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a19a587d60ed..432c543beaed 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -176,8 +176,11 @@ struct nvme_ctrl {
 	u64 ps_max_latency_us;
 	bool apst_enabled;
 
+	/* PCIe only: */
 	u32 hmpre;
 	u32 hmmin;
+	u32 hmminds;
+	u16 hmmaxd;
 
 	/* Fabrics only */
 	u16 sqsize;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 06ea46801578..ef9093f617ac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1628,6 +1628,10 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 	tmp = (preferred + chunk_size - 1);
 	do_div(tmp, chunk_size);
 	max_entries = tmp;
+
+	if (dev->ctrl.hmmaxd && dev->ctrl.hmmaxd < max_entries)
+		max_entries = dev->ctrl.hmmaxd;
+
 	descs = kcalloc(max_entries, sizeof(*descs), GFP_KERNEL);
 	if (!descs)
 		goto out;
@@ -1681,7 +1685,7 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 
 	/* start big and work our way down */
 	for (chunk_size = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
-	     chunk_size >= PAGE_SIZE * 2;
+	     chunk_size >= max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE * 2);
 	     chunk_size /= 2) {
 		if (!__nvme_alloc_host_mem(dev, preferred, chunk_size)) {
 			if (!min || dev->host_mem_size >= min)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 05560c2ecc83..c46f42269021 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -226,7 +226,9 @@ struct nvme_id_ctrl {
 	__le16			mntmt;
 	__le16			mxtmt;
 	__le32			sanicap;
-	__u8			rsvd332[180];
+	__le32			hmminds;
+	__le16			hmmaxd;
+	__u8			rsvd338[174];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
-- 
2.11.0
