From: keith.busch@intel.com (Keith Busch)
Date: Wed, 12 Jul 2017 15:50:12 -0400
Subject: kernel BUG at nvme/host/pci.c
In-Reply-To: <458f2115-4a07-e23c-2f1f-a90a95668f74@pse-consulting.de>
References: <28fcb21a-35b6-61c1-29e0-9adcc954c98c@pse-consulting.de>
 <20170710190818.GA13671@localhost.localdomain>
 <64da8c4d-2d69-22fa-06a0-aa4f11903e39@pse-consulting.de>
 <20170711194523.GD4604@localhost.localdomain>
 <458f2115-4a07-e23c-2f1f-a90a95668f74@pse-consulting.de>
Message-ID: <20170712195012.GA8388@localhost.localdomain>

On Wed, Jul 12, 2017@08:06:29AM +0200, Andreas Pflug wrote:
> nomerges set to 1 on both devices, same BUG_ON.

Thanks for the info.

Could you possibly recreate with the patch below? This will simply
return IO error rather the panic, and show exactly how this invalid SGL
is constructed.

The block layer is considering all the cases I can think of that might
break NVMe, so these details should help explain how we got here.

I'll send this as a proper patch for upstream consideration as well.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c4343c4..8cb3e89 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -533,7 +533,7 @@ static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
 }
 #endif
 
-static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
+static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct dma_pool *pool;
@@ -550,7 +550,7 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 
 	length -= (page_size - offset);
 	if (length <= 0)
-		return true;
+		return BLK_STS_OK;
 
 	dma_len -= (page_size - offset);
 	if (dma_len) {
@@ -563,7 +563,7 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 
 	if (length <= page_size) {
 		iod->first_dma = dma_addr;
-		return true;
+		return BLK_STS_OK;
 	}
 
 	nprps = DIV_ROUND_UP(length, page_size);
@@ -579,7 +579,7 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 	if (!prp_list) {
 		iod->first_dma = dma_addr;
 		iod->npages = -1;
-		return false;
+		return BLK_STS_RESOURCE;
 	}
 	list[0] = prp_list;
 	iod->first_dma = prp_dma;
@@ -589,7 +589,7 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 			__le64 *old_prp_list = prp_list;
 			prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 			if (!prp_list)
-				return false;
+				return BLK_STS_RESOURCE;
 			list[iod->npages++] = prp_list;
 			prp_list[0] = old_prp_list[i - 1];
 			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
@@ -603,13 +603,29 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 			break;
 		if (dma_len > 0)
 			continue;
-		BUG_ON(dma_len < 0);
+		if (unlikely(dma_len < 0))
+			goto bad_sgl;
 		sg = sg_next(sg);
 		dma_addr = sg_dma_address(sg);
 		dma_len = sg_dma_len(sg);
 	}
 
-	return true;
+	return BLK_STS_OK;
+
+ bad_sgl:
+	if (WARN_ONCE(1, "Invalid SGL for payload:%d nents:%d\n",
+				blk_rq_payload_bytes(req), iod->nents)) {
+		for_each_sg(iod->sg, sg, iod->nents, i) {
+			dma_addr_t phys = sg_phys(sg);
+			printk("sg[%d] phys_addr:%pad offset:%d length:%d "
+			       "dma_address:%pad dma_length:%d\n", i, &phys,
+					sg->offset, sg->length,
+					&sg_dma_address(sg),
+					sg_dma_len(sg));
+		}
+	}
+	return BLK_STS_IOERR;
+
 }
 
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
@@ -631,7 +647,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				DMA_ATTR_NO_WARN))
 		goto out;
 
-	if (!nvme_setup_prps(dev, req))
+	ret = nvme_setup_prps(dev, req);
+	if (ret != BLK_STS_OK)
 		goto out_unmap;
 
 	ret = BLK_STS_IOERR;
--
