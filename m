From: parav@mellanox.com (Parav Pandit)
Date: Tue,  7 Feb 2017 16:38:24 -0600
Subject: [PATCH] [PATCH] nvmet-rdma: Support 16K worth of inline data for
 write commands
Message-ID: <1486507104-23227-1-git-send-email-parav@mellanox.com>

This patch allows supporting 16Kbytes of inline data for write commands.

With null target below are the performance improvements achieved.
Workload: random write, 70-30 mixed IOs
null target: 250GB, 64 core CPU, single controller.
Queue depth: 256 commands

           cpu idle %        iops (K)            latency (usec)
           (higher better)   (higher better)     (lowe better)

Inline     16K       4K      16K       4K        16K       4K
size
io_size    random write      random write        random write
512        78        79      2349      2343      5.45      5.45
1K         78        78      2438      2417      5.78      5.29
2K         78        78      2437      2387      5.78      5.35
4K         78        79      2332      2274      5.75      5.62
8K         78        87      1308      711       11        21.65
16K        79        90      680       538       22        28.64
32K        80        95      337       333       47        47.41

           mix RW-30/70      mix RW-30/70        mix RW-30/70
512        78        78      2389      2349      5.43      5.45
1K         78        78      2250      2354      5.61      5.42
2K         79        78      2261      2294      5.62      5.60
4K         77        78      2180      2131      5.8       6.28
8K         78        79      1746      797       8.5       18.42
16K        78        86      943       628       15.90     23.76
32K        92        92      440       440       32        33.39

This is tested with modified Linux initiator that can support
16K worth of inline data.
Applications which has typical 8K or 16K block size will benefit most
out of this performance improvement.

Additionally when IOPs are throttled to 700K IOPs, cpu utilization and
latency numbers are same for both the inline size;
confirming that higher inline size is not consuming any extra CPU
for serving same number of IOPs.

           cpu idle %        iops (K)            latency (usec)
           (higher better)   (higher better)     (lowe better)

Inline     16K       4K      16K       4K       16K        4K
size
io_size    random write      random write        random write
4K         93        93      700       700       5.75      5.62
8K         86        87      700       700       11        21.65
16K        83        88      680       538       22        28.64
32K        94        94      337       333       47        47.41

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/target/rdma.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1a57ab3..8bfadea 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -33,9 +33,9 @@
 #include "nvmet.h"
 
 /*
- * We allow up to a page of inline data to go with the SQE
+ * We allow inline data to go with the SQE up to 16K or page size
  */
-#define NVMET_RDMA_INLINE_DATA_SIZE	PAGE_SIZE
+#define NVMET_RDMA_INLINE_DATA_SIZE	16384
 
 struct nvmet_rdma_cmd {
 	struct ib_sge		sge[2];
@@ -256,15 +256,16 @@ static int nvmet_rdma_alloc_cmd(struct nvmet_rdma_device *ndev,
 
 	if (!admin) {
 		c->inline_page = alloc_pages(GFP_KERNEL,
-				get_order(NVMET_RDMA_INLINE_DATA_SIZE));
+				get_order(nvmet_rdma_ops.sqe_inline_size));
 		if (!c->inline_page)
 			goto out_unmap_cmd;
 		c->sge[1].addr = ib_dma_map_page(ndev->device,
-				c->inline_page, 0, NVMET_RDMA_INLINE_DATA_SIZE,
+				c->inline_page, 0,
+				nvmet_rdma_ops.sqe_inline_size,
 				DMA_FROM_DEVICE);
 		if (ib_dma_mapping_error(ndev->device, c->sge[1].addr))
 			goto out_free_inline_page;
-		c->sge[1].length = NVMET_RDMA_INLINE_DATA_SIZE;
+		c->sge[1].length = nvmet_rdma_ops.sqe_inline_size;
 		c->sge[1].lkey = ndev->pd->local_dma_lkey;
 	}
 
@@ -279,7 +280,7 @@ static int nvmet_rdma_alloc_cmd(struct nvmet_rdma_device *ndev,
 out_free_inline_page:
 	if (!admin) {
 		__free_pages(c->inline_page,
-				get_order(NVMET_RDMA_INLINE_DATA_SIZE));
+				get_order(nvmet_rdma_ops.sqe_inline_size));
 	}
 out_unmap_cmd:
 	ib_dma_unmap_single(ndev->device, c->sge[0].addr,
@@ -296,9 +297,10 @@ static void nvmet_rdma_free_cmd(struct nvmet_rdma_device *ndev,
 {
 	if (!admin) {
 		ib_dma_unmap_page(ndev->device, c->sge[1].addr,
-				NVMET_RDMA_INLINE_DATA_SIZE, DMA_FROM_DEVICE);
+				nvmet_rdma_ops.sqe_inline_size,
+				DMA_FROM_DEVICE);
 		__free_pages(c->inline_page,
-				get_order(NVMET_RDMA_INLINE_DATA_SIZE));
+				get_order(nvmet_rdma_ops.sqe_inline_size));
 	}
 	ib_dma_unmap_single(ndev->device, c->sge[0].addr,
 				sizeof(*c->nvme_cmd), DMA_FROM_DEVICE);
@@ -592,7 +594,7 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 	if (!nvme_is_write(rsp->req.cmd))
 		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 
-	if (off + len > NVMET_RDMA_INLINE_DATA_SIZE) {
+	if (off + len > nvmet_rdma_ops.sqe_inline_size) {
 		pr_err("invalid inline data offset!\n");
 		return NVME_SC_SGL_INVALID_OFFSET | NVME_SC_DNR;
 	}
@@ -1475,7 +1477,6 @@ static void nvmet_rdma_remove_port(struct nvmet_port *port)
 static struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_RDMA,
-	.sqe_inline_size	= NVMET_RDMA_INLINE_DATA_SIZE,
 	.msdbd			= 1,
 	.has_keyed_sgls		= 1,
 	.add_port		= nvmet_rdma_add_port,
@@ -1486,6 +1487,13 @@ static void nvmet_rdma_remove_port(struct nvmet_port *port)
 
 static int __init nvmet_rdma_init(void)
 {
+	/* Currently limit inline size to 16K on systems which has page size
+	 * of 4K or less. For systems which has more than 4K page size,
+	 * continue to use PAGE_SIZE worth of inline data.
+	 */
+	nvmet_rdma_ops.sqe_inline_size =
+		round_up(NVMET_RDMA_INLINE_DATA_SIZE, PAGE_SIZE);
+
 	return nvmet_register_transport(&nvmet_rdma_ops);
 }
 
-- 
1.8.3.1
