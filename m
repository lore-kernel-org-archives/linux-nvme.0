From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 17:05:40 +0200
Subject: [PATCH] NVMe: fix type warning on 32-bit
Message-ID: <2271255.ypbMPZa6tA@wuerfel>

A recent change to the ioctl handling caused a new harmless
warning in the NVMe driver on all 32-bit machines:

drivers/block/nvme-core.c: In function 'nvme_submit_io':
drivers/block/nvme-core.c:1794:29: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

In order to shup up that warning, this introduces a new
temporary variable that uses a double cast to extract
the pointer from an __u64 structure member.

Signed-off-by: Arnd Bergmann <arnd at arndb.de>
Fixes: a67a95134ff ("NVMe: Meta data handling through submit io ioctl")

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 85b8036deaa3..683dff272562 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1750,6 +1750,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	struct nvme_iod *iod;
 	dma_addr_t meta_dma = 0;
 	void *meta = NULL;
+	void __user *metadata;
 
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
@@ -1763,6 +1764,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 		meta_len = 0;
 	}
 
+	metadata = (void __user *)(unsigned long)io.metadata;
+
 	write = io.opcode & 1;
 
 	switch (io.opcode) {
@@ -1786,13 +1789,13 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	if (meta_len) {
 		meta = dma_alloc_coherent(&dev->pci_dev->dev, meta_len,
 						&meta_dma, GFP_KERNEL);
+
 		if (!meta) {
 			status = -ENOMEM;
 			goto unmap;
 		}
 		if (write) {
-			if (copy_from_user(meta, (void __user *)io.metadata,
-								meta_len)) {
+			if (copy_from_user(meta, metadata, meta_len)) {
 				status = -EFAULT;
 				goto unmap;
 			}
@@ -1819,8 +1822,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	nvme_free_iod(dev, iod);
 	if (meta) {
 		if (status == NVME_SC_SUCCESS && !write) {
-			if (copy_to_user((void __user *)io.metadata, meta,
-								meta_len))
+			if (copy_to_user(metadata, meta, meta_len))
 				status = -EFAULT;
 		}
 		dma_free_coherent(&dev->pci_dev->dev, meta_len, meta, meta_dma);
