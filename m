From: keith.busch@intel.com (Keith Busch)
Date: Fri, 15 Sep 2017 11:44:01 -0400
Subject: [PATCH] nvme/pci: Print invalid SGL only once
In-Reply-To: <20170915151713.GD8878@localhost.localdomain>
References: <1505415974-13489-1-git-send-email-keith.busch@intel.com>
 <20170915145553.GA1147@lst.de>
 <20170915151713.GD8878@localhost.localdomain>
Message-ID: <20170915154401.GE8878@localhost.localdomain>

I should have known Linux had a macro to do something "once". Is the
following more acceptable?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index df96562..8a7bbe2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/once.h>
 #include <linux/pci.h>
 #include <linux/poison.h>
 #include <linux/t10-pi.h>
@@ -539,6 +540,20 @@ static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
 }
 #endif
 
+static void nvme_print_sgl(struct scatterlist *sgl, int nents)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sgl, sg, nents, i) {
+		dma_addr_t phys = sg_phys(sg);
+		pr_warn("sg[%d] phys_addr:%pad offset:%d length:%d "
+			"dma_address:%pad dma_length:%d\n",
+			i, &phys, sg->offset, sg->length, &sg_dma_address(sg),
+			sg_dma_len(sg));
+	}
+}
+
 static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -619,19 +634,10 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 	return BLK_STS_OK;
 
  bad_sgl:
-	if (WARN_ONCE(1, "Invalid SGL for payload:%d nents:%d\n",
-				blk_rq_payload_bytes(req), iod->nents)) {
-		for_each_sg(iod->sg, sg, iod->nents, i) {
-			dma_addr_t phys = sg_phys(sg);
-			pr_warn("sg[%d] phys_addr:%pad offset:%d length:%d "
-			       "dma_address:%pad dma_length:%d\n", i, &phys,
-					sg->offset, sg->length,
-					&sg_dma_address(sg),
-					sg_dma_len(sg));
-		}
-	}
+	WARN(DO_ONCE(nvme_print_sgl, iod->sg, iod->nents),
+		"Invalid SGL for payload:%d nents:%d\n",
+			blk_rq_payload_bytes(req), iod->nents);
 	return BLK_STS_IOERR;
-
 }
 
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
--
