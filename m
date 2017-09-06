From: hch@lst.de (Christoph Hellwig)
Date: Wed,  6 Sep 2017 15:55:31 +0200
Subject: [PATCH 3/4] nvme-pci: propagate (some) errors from host memory buffer
 setup
In-Reply-To: <20170906135532.21358-1-hch@lst.de>
References: <20170906135532.21358-1-hch@lst.de>
Message-ID: <20170906135532.21358-4-hch@lst.de>

We want to catch command execution errors when resetting the device, so
propagate errors from the Set Features when setting up the host memory
buffer.  We keep ignoring memory allocation failures, as the spec
clearly says that the controller must work without a host memory buffer.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Cc: stable at vger.kernel.org
---
 drivers/nvme/host/pci.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6d2acf06c180..06ea46801578 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1693,12 +1693,13 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 	return -ENOMEM;
 }
 
-static void nvme_setup_host_mem(struct nvme_dev *dev)
+static int nvme_setup_host_mem(struct nvme_dev *dev)
 {
 	u64 max = (u64)max_host_mem_size_mb * SZ_1M;
 	u64 preferred = (u64)dev->ctrl.hmpre * 4096;
 	u64 min = (u64)dev->ctrl.hmmin * 4096;
 	u32 enable_bits = NVME_HOST_MEM_ENABLE;
+	int ret = 0;
 
 	preferred = min(preferred, max);
 	if (min > max) {
@@ -1706,7 +1707,7 @@ static void nvme_setup_host_mem(struct nvme_dev *dev)
 			"min host memory (%lld MiB) above limit (%d MiB).\n",
 			min >> ilog2(SZ_1M), max_host_mem_size_mb);
 		nvme_free_host_mem(dev);
-		return;
+		return 0;
 	}
 
 	/*
@@ -1723,7 +1724,7 @@ static void nvme_setup_host_mem(struct nvme_dev *dev)
 		if (nvme_alloc_host_mem(dev, min, preferred)) {
 			dev_warn(dev->ctrl.device,
 				"failed to allocate host memory buffer.\n");
-			return;
+			return 0; /* controller must work without HMB */
 		}
 
 		dev_info(dev->ctrl.device,
@@ -1731,8 +1732,10 @@ static void nvme_setup_host_mem(struct nvme_dev *dev)
 			dev->host_mem_size >> ilog2(SZ_1M));
 	}
 
-	if (nvme_set_host_mem(dev, enable_bits))
+	ret = nvme_set_host_mem(dev, enable_bits);
+	if (ret)
 		nvme_free_host_mem(dev);
+	return ret;
 }
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)
@@ -2176,8 +2179,11 @@ static void nvme_reset_work(struct work_struct *work)
 				 "unable to allocate dma for dbbuf\n");
 	}
 
-	if (dev->ctrl.hmpre)
-		nvme_setup_host_mem(dev);
+	if (dev->ctrl.hmpre) {
+		result = nvme_setup_host_mem(dev);
+		if (result < 0)
+			goto out;
+	}
 
 	result = nvme_setup_io_queues(dev);
 	if (result)
-- 
2.11.0
