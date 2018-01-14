From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 14 Jan 2018 20:40:55 +0900
Subject: [PATCH 2/2] nvme: pci: remove unnecessary initialization of local
 variable
Message-ID: <1515930055-20611-1-git-send-email-minwoo.im.dev@gmail.com>

No functional change with code clean-up.
Remove unnecessary initialization of local variable in HMB code.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fb392c5..3abe12c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1768,7 +1768,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 	dma_addr_t descs_dma;
 	int i = 0;
 	void **bufs;
-	u64 size = 0, tmp;
+	u64 size, tmp;
 
 	tmp = (preferred + chunk_size - 1);
 	do_div(tmp, chunk_size);
@@ -1851,7 +1851,7 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 	u64 preferred = (u64)dev->ctrl.hmpre * SZ_4K;
 	u64 min = (u64)dev->ctrl.hmmin * SZ_4K;
 	u32 enable_bits = NVME_HOST_MEM_ENABLE;
-	int ret = 0;
+	int ret;
 
 	preferred = min(preferred, max);
 	if (min > max) {
-- 
2.7.4
