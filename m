From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 14 Jan 2018 20:40:40 +0900
Subject: [PATCH 1/2] nvme: pci: replace magic number with readable size macro
 in hmb code
Message-ID: <1515930040-20561-1-git-send-email-minwoo.im.dev@gmail.com>

Those three identify fields(hmpre, hmmin, hmminds) have size in 4KB
units.

Replace magic numbers with human-readable size macro.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d53550e..fb392c5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1833,7 +1833,7 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 
 	/* start big and work our way down */
 	for (chunk_size = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
-	     chunk_size >= max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE * 2);
+	     chunk_size >= max_t(u32, dev->ctrl.hmminds * SZ_4K, PAGE_SIZE * 2);
 	     chunk_size /= 2) {
 		if (!__nvme_alloc_host_mem(dev, preferred, chunk_size)) {
 			if (!min || dev->host_mem_size >= min)
@@ -1848,8 +1848,8 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 static int nvme_setup_host_mem(struct nvme_dev *dev)
 {
 	u64 max = (u64)max_host_mem_size_mb * SZ_1M;
-	u64 preferred = (u64)dev->ctrl.hmpre * 4096;
-	u64 min = (u64)dev->ctrl.hmmin * 4096;
+	u64 preferred = (u64)dev->ctrl.hmpre * SZ_4K;
+	u64 min = (u64)dev->ctrl.hmmin * SZ_4K;
 	u32 enable_bits = NVME_HOST_MEM_ENABLE;
 	int ret = 0;
 
-- 
2.7.4
