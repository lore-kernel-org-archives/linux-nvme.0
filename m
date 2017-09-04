From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Tue,  5 Sep 2017 00:23:29 +0900
Subject: [PATCH 1/2] nvme-pci: avoid arrary index out of bounds in retry HMB
 allocation
In-Reply-To: <1504538610-15670-1-git-send-email-akinobu.mita@gmail.com>
References: <1504538610-15670-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1504538610-15670-2-git-send-email-akinobu.mita@gmail.com>

The array index which is used for addressing each chunk of host memory
buffer is decreased to -1 in the middle of retrying HMB allocation with
a smaller chunk size.  This results memory corruptions and the head of
host memory buffer descriptor entry is lost.

This fixes it by resetting the index before restarting HMB allocation.
And this also removes unnecessary conditional statements for retrying
decision.

Fixes: 87ad72a59a38 ("nvme-pci: implement host memory buffer support")
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 drivers/nvme/host/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ea892e7..7e71cc9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1614,13 +1614,15 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 	struct nvme_host_mem_buf_desc *descs;
 	u32 chunk_size, max_entries, len;
 	dma_addr_t descs_dma;
-	int i = 0;
+	int i;
 	void **bufs;
-	u64 size = 0, tmp;
+	u64 size, tmp;
 
 	/* start big and work our way down */
 	chunk_size = min(preferred, (u64)PAGE_SIZE << MAX_ORDER);
 retry:
+	i = 0;
+	size = 0;
 	tmp = (preferred + chunk_size - 1);
 	do_div(tmp, chunk_size);
 	max_entries = tmp;
@@ -1633,7 +1635,7 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 	if (!bufs)
 		goto out_free_descs;
 
-	for (size = 0; size < preferred; size += len) {
+	for (; size < preferred; size += len) {
 		dma_addr_t dma_addr;
 
 		len = min_t(u64, chunk_size, preferred - size);
@@ -1677,7 +1679,7 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 			descs_dma);
 out:
 	/* try a smaller chunk size if we failed early */
-	if (chunk_size >= PAGE_SIZE * 2 && (i == 0 || size < min)) {
+	if (chunk_size >= PAGE_SIZE * 2) {
 		chunk_size /= 2;
 		goto retry;
 	}
-- 
2.7.4
