From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Sep 2017 22:03:17 +0200
Subject: [PATCH 1/2] nvme-pci: avoid arrary index out of bounds in
 retry HMB allocation
In-Reply-To: <1504538610-15670-2-git-send-email-akinobu.mita@gmail.com>
References: <1504538610-15670-1-git-send-email-akinobu.mita@gmail.com>
 <1504538610-15670-2-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20170904200317.GA16423@lst.de>

Hmm.  I think I did a clear beginners mistake in that code in
mixing up two loops.  Can you try the version below that just
adds a new function to separate the loops (and also gets rid of
the weird early fail heuristic):

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 74a124a06264..324b995a46ed 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1614,17 +1614,15 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 	dev->host_mem_descs = NULL;
 }
 
-static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
+static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
+		u32 chunk_size)
 {
 	struct nvme_host_mem_buf_desc *descs;
-	u32 chunk_size, max_entries, len;
+	u32 max_entries, len;
 	int i = 0;
 	void **bufs;
 	u64 size = 0, tmp;
 
-	/* start big and work our way down */
-	chunk_size = min(preferred, (u64)PAGE_SIZE << MAX_ORDER);
-retry:
 	tmp = (preferred + chunk_size - 1);
 	do_div(tmp, chunk_size);
 	max_entries = tmp;
@@ -1650,15 +1648,9 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 		i++;
 	}
 
-	if (!size || (min && size < min)) {
-		dev_warn(dev->ctrl.device,
-			"failed to allocate host memory buffer.\n");
+	if (!size)
 		goto out_free_bufs;
-	}
 
-	dev_info(dev->ctrl.device,
-		"allocated %lld MiB host memory buffer.\n",
-		size >> ilog2(SZ_1M));
 	dev->nr_host_mem_descs = i;
 	dev->host_mem_size = size;
 	dev->host_mem_descs = descs;
@@ -1677,15 +1669,28 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 out_free_descs:
 	kfree(descs);
 out:
-	/* try a smaller chunk size if we failed early */
-	if (chunk_size >= PAGE_SIZE * 2 && (i == 0 || size < min)) {
-		chunk_size /= 2;
-		goto retry;
-	}
 	dev->host_mem_descs = NULL;
 	return -ENOMEM;
 }
 
+static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
+{
+	u32 chunk_size;
+
+	/* start big and work our way down */
+	for (chunk_size = min_t(u64, preferred, PAGE_SIZE << MAX_ORDER);
+	     chunk_size >= PAGE_SIZE * 2;
+	     chunk_size /= 2) {
+		if (!__nvme_alloc_host_mem(dev, preferred, chunk_size)) {
+			if (!min || dev->host_mem_size >= min)
+				return 0;
+			nvme_free_host_mem(dev);
+		}
+	}
+
+	return -ENOMEM;
+}
+
 static void nvme_setup_host_mem(struct nvme_dev *dev)
 {
 	u64 max = (u64)max_host_mem_size_mb * SZ_1M;
@@ -1713,8 +1718,15 @@ static void nvme_setup_host_mem(struct nvme_dev *dev)
 	}
 
 	if (!dev->host_mem_descs) {
-		if (nvme_alloc_host_mem(dev, min, preferred))
+		if (nvme_alloc_host_mem(dev, min, preferred)) {
+			dev_warn(dev->ctrl.device,
+				"failed to allocate host memory buffer.\n");
 			return;
+		}
+
+		dev_info(dev->ctrl.device,
+			"allocated %lld MiB host memory buffer.\n",
+			dev->host_mem_size >> ilog2(SZ_1M));
 	}
 
 	if (nvme_set_host_mem(dev, enable_bits))
