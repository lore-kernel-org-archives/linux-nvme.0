From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 6 Jul 2017 12:26:52 +0300
Subject: [PATCH] nvme-pci: compile warnings in nvme_alloc_host_mem()
Message-ID: <20170706092651.dshe5uxn665icxma@mwanda>

"i" should be signed or it could cause a forever loop on the cleanup
path. "size" can be used uninitialized.

Fixes: 87ad72a59a38 ("nvme-pci: implement host memory buffer support")
Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>
---
Presumably Arnd already sent a patch for this, but it's been hanging
around linux-next for a while and I want to mark it as dealt with.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0ae864b63411..a40675947893 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1585,9 +1585,10 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 {
 	struct nvme_host_mem_buf_desc *descs;
-	u32 chunk_size, max_entries, i = 0;
+	u32 chunk_size, max_entries;
+	int i = 0;
 	void **bufs;
-	u64 size, tmp;
+	u64 size = 0, tmp;
 
 	/* start big and work our way down */
 	chunk_size = min(preferred, (u64)PAGE_SIZE << MAX_ORDER);
