From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 25 Sep 2018 10:22:26 -0600
Subject: [PATCH v7 08/13] IB/core: Ensure we map P2P memory correctly in
 rdma_rw_ctx_[init|destroy]()
In-Reply-To: <20180925162231.4354-1-logang@deltatee.com>
References: <20180925162231.4354-1-logang@deltatee.com>
Message-ID: <20180925162231.4354-9-logang@deltatee.com>

In order to use PCI P2P memory the pci_p2pmem_map_sg() function must be
called to map the correct PCI bus address.

To do this, check the first page in the scatter list to see if it is P2P
memory or not. At the moment, scatter lists that contain P2P memory must
be homogeneous so if the first page is P2P the entire SGL should be P2P.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/infiniband/core/rw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 683e6d11a564..d22c4a2ebac6 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -12,6 +12,7 @@
  */
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
+#include <linux/pci-p2pdma.h>
 #include <rdma/mr_pool.h>
 #include <rdma/rw.h>
 
@@ -280,7 +281,11 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
 	struct ib_device *dev = qp->pd->device;
 	int ret;
 
-	ret = ib_dma_map_sg(dev, sg, sg_cnt, dir);
+	if (is_pci_p2pdma_page(sg_page(sg)))
+		ret = pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
+	else
+		ret = ib_dma_map_sg(dev, sg, sg_cnt, dir);
+
 	if (!ret)
 		return -ENOMEM;
 	sg_cnt = ret;
@@ -602,7 +607,9 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
 		break;
 	}
 
-	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+	/* P2PDMA contexts do not need to be unmapped */
+	if (!is_pci_p2pdma_page(sg_page(sg)))
+		ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
 
-- 
2.19.0
