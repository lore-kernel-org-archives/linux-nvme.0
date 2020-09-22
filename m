Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA82C2D0E2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6028A2395C
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PDehTF+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6028A2395C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SBwO2SBTZyv7MAYwc2Xsp8qAZItD8LUv3cG/6TbOre8=; b=PDehTF+oj2k1DF1GTlGEzAhS3b
	oiN+wAtRqDkQNs/VYpiOU8DQI5+aQqF8IPn9ulcZeobbA/uQ4uiYZg/RTJcAhNfqyhrQWewXEM0v2
	R74Cqih6lEGn+bgmdpFVtT6eiHoRXQVMYTVks0yJ/BDT9Ry3Zj2S8TTKt4W6eqy7fd2oRUPJlAK+K
	/hLwLrIU2MLrq0OQXNsnJa7GT4/l3QHpxBysSuuxAiEwPVYB25MHcd4A9YU4qdKCrJCY2Iui/KNIE
	ZEk6NhBjI+rXZe6nYI711UgEPYrPgliNetNxUpiwIMNEkjNo2nLMmHON5Q8YPNtX5lAmi/fiyNeh6
	1K9yiHdQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKhCl-0003qr-5l; Tue, 22 Sep 2020 12:15:31 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKhCU-0003lg-Na
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 12:15:18 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9D8ABAF3D;
 Tue, 22 Sep 2020 12:15:48 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/7] nvmet-fc: use feature flag for virtual LLDD
Date: Tue, 22 Sep 2020 14:14:58 +0200
Message-Id: <20200922121501.32851-5-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200922121501.32851-1-hare@suse.de>
References: <20200922121501.32851-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_081515_040156_58019E80 
X-CRM114-Status: GOOD (  20.58  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 James Smart <james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Virtual LLDDs like fcloop don't need to do DMA, but still
might want to expose a device. So add a new feature flag
to mark these LLDDs instead of relying on a non-existing
struct device.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fc.c       | 93 +++++++++++++++++++++++-------------------
 drivers/nvme/target/fcloop.c   |  2 +-
 include/linux/nvme-fc-driver.h |  2 +
 3 files changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 63f5deb3b68a..6f5784767d35 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -273,41 +273,50 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
  * in the scatter list, setting all dma addresses to 0.
  */
 
+static bool fc_lldd_is_virtual(struct nvmet_fc_tgtport *tgtport)
+{
+	return !!(tgtport->ops->target_features & NVMET_FCTGTFEAT_VIRTUAL_DMA);
+}
+
 static inline dma_addr_t
-fc_dma_map_single(struct device *dev, void *ptr, size_t size,
+fc_dma_map_single(struct nvmet_fc_tgtport *tgtport, void *ptr, size_t size,
 		enum dma_data_direction dir)
 {
-	return dev ? dma_map_single(dev, ptr, size, dir) : (dma_addr_t)0L;
+	if (fc_lldd_is_virtual(tgtport))
+		return (dma_addr_t)0L;
+	return dma_map_single(tgtport->dev, ptr, size, dir);
 }
 
 static inline int
-fc_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+fc_dma_mapping_error(struct nvmet_fc_tgtport *tgtport, dma_addr_t dma_addr)
 {
-	return dev ? dma_mapping_error(dev, dma_addr) : 0;
+	if (fc_lldd_is_virtual(tgtport))
+		return 0;
+	return dma_mapping_error(tgtport->dev, dma_addr);
 }
 
 static inline void
-fc_dma_unmap_single(struct device *dev, dma_addr_t addr, size_t size,
-	enum dma_data_direction dir)
+fc_dma_unmap_single(struct nvmet_fc_tgtport *tgtport, dma_addr_t addr,
+	size_t size, enum dma_data_direction dir)
 {
-	if (dev)
-		dma_unmap_single(dev, addr, size, dir);
+	if (!fc_lldd_is_virtual(tgtport))
+		dma_unmap_single(tgtport->dev, addr, size, dir);
 }
 
 static inline void
-fc_dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
-		enum dma_data_direction dir)
+fc_dma_sync_single_for_cpu(struct nvmet_fc_tgtport *tgtport, dma_addr_t addr,
+	size_t size, enum dma_data_direction dir)
 {
-	if (dev)
-		dma_sync_single_for_cpu(dev, addr, size, dir);
+	if (!fc_lldd_is_virtual(tgtport))
+		dma_sync_single_for_cpu(tgtport->dev, addr, size, dir);
 }
 
 static inline void
-fc_dma_sync_single_for_device(struct device *dev, dma_addr_t addr, size_t size,
-		enum dma_data_direction dir)
+fc_dma_sync_single_for_device(struct nvmet_fc_tgtport *tgtport, dma_addr_t addr,
+	size_t size, enum dma_data_direction dir)
 {
-	if (dev)
-		dma_sync_single_for_device(dev, addr, size, dir);
+	if (!fc_lldd_is_virtual(tgtport))
+		dma_sync_single_for_device(tgtport->dev, addr, size, dir);
 }
 
 /* pseudo dma_map_sg call */
@@ -329,18 +338,20 @@ fc_map_sg(struct scatterlist *sg, int nents)
 }
 
 static inline int
-fc_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir)
+fc_dma_map_sg(struct nvmet_fc_tgtport *tgtport, struct scatterlist *sg,
+	int nents, enum dma_data_direction dir)
 {
-	return dev ? dma_map_sg(dev, sg, nents, dir) : fc_map_sg(sg, nents);
+	if (fc_lldd_is_virtual(tgtport))
+		return fc_map_sg(sg, nents);
+	return dma_map_sg(tgtport->dev, sg, nents, dir);
 }
 
 static inline void
-fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir)
+fc_dma_unmap_sg(struct nvmet_fc_tgtport *tgtport, struct scatterlist *sg,
+	int nents, enum dma_data_direction dir)
 {
-	if (dev)
-		dma_unmap_sg(dev, sg, nents, dir);
+	if (!fc_lldd_is_virtual(tgtport))
+		dma_unmap_sg(tgtport->dev, sg, nents, dir);
 }
 
 
@@ -368,7 +379,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	fc_dma_unmap_single(tgtport->dev, lsreq->rqstdma,
+	fc_dma_unmap_single(tgtport, lsreq->rqstdma,
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
@@ -391,10 +402,10 @@ __nvmet_fc_send_ls_req(struct nvmet_fc_tgtport *tgtport,
 	lsop->req_queued = false;
 	INIT_LIST_HEAD(&lsop->lsreq_list);
 
-	lsreq->rqstdma = fc_dma_map_single(tgtport->dev, lsreq->rqstaddr,
+	lsreq->rqstdma = fc_dma_map_single(tgtport, lsreq->rqstaddr,
 				  lsreq->rqstlen + lsreq->rsplen,
 				  DMA_BIDIRECTIONAL);
-	if (fc_dma_mapping_error(tgtport->dev, lsreq->rqstdma))
+	if (fc_dma_mapping_error(tgtport, lsreq->rqstdma))
 		return -EFAULT;
 
 	lsreq->rspdma = lsreq->rqstdma + lsreq->rqstlen;
@@ -420,7 +431,7 @@ __nvmet_fc_send_ls_req(struct nvmet_fc_tgtport *tgtport,
 	lsop->req_queued = false;
 	list_del(&lsop->lsreq_list);
 	spin_unlock_irqrestore(&tgtport->lock, flags);
-	fc_dma_unmap_single(tgtport->dev, lsreq->rqstdma,
+	fc_dma_unmap_single(tgtport, lsreq->rqstdma,
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 	return ret;
@@ -555,10 +566,10 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 
 		iod->rspbuf = (union nvmefc_ls_responses *)&iod->rqstbuf[1];
 
-		iod->rspdma = fc_dma_map_single(tgtport->dev, iod->rspbuf,
+		iod->rspdma = fc_dma_map_single(tgtport, iod->rspbuf,
 						sizeof(*iod->rspbuf),
 						DMA_TO_DEVICE);
-		if (fc_dma_mapping_error(tgtport->dev, iod->rspdma))
+		if (fc_dma_mapping_error(tgtport, iod->rspdma))
 			goto out_fail;
 	}
 
@@ -568,7 +579,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 	kfree(iod->rqstbuf);
 	list_del(&iod->ls_rcv_list);
 	for (iod--, i--; i >= 0; iod--, i--) {
-		fc_dma_unmap_single(tgtport->dev, iod->rspdma,
+		fc_dma_unmap_single(tgtport, iod->rspdma,
 				sizeof(*iod->rspbuf), DMA_TO_DEVICE);
 		kfree(iod->rqstbuf);
 		list_del(&iod->ls_rcv_list);
@@ -586,7 +597,7 @@ nvmet_fc_free_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 	int i;
 
 	for (i = 0; i < NVMET_LS_CTX_COUNT; iod++, i++) {
-		fc_dma_unmap_single(tgtport->dev,
+		fc_dma_unmap_single(tgtport,
 				iod->rspdma, sizeof(*iod->rspbuf),
 				DMA_TO_DEVICE);
 		kfree(iod->rqstbuf);
@@ -640,12 +651,12 @@ nvmet_fc_prep_fcp_iodlist(struct nvmet_fc_tgtport *tgtport,
 		list_add_tail(&fod->fcp_list, &queue->fod_list);
 		spin_lock_init(&fod->flock);
 
-		fod->rspdma = fc_dma_map_single(tgtport->dev, &fod->rspiubuf,
+		fod->rspdma = fc_dma_map_single(tgtport, &fod->rspiubuf,
 					sizeof(fod->rspiubuf), DMA_TO_DEVICE);
-		if (fc_dma_mapping_error(tgtport->dev, fod->rspdma)) {
+		if (fc_dma_mapping_error(tgtport, fod->rspdma)) {
 			list_del(&fod->fcp_list);
 			for (fod--, i--; i >= 0; fod--, i--) {
-				fc_dma_unmap_single(tgtport->dev, fod->rspdma,
+				fc_dma_unmap_single(tgtport, fod->rspdma,
 						sizeof(fod->rspiubuf),
 						DMA_TO_DEVICE);
 				fod->rspdma = 0L;
@@ -666,7 +677,7 @@ nvmet_fc_destroy_fcp_iodlist(struct nvmet_fc_tgtport *tgtport,
 
 	for (i = 0; i < queue->sqsize; fod++, i++) {
 		if (fod->rspdma)
-			fc_dma_unmap_single(tgtport->dev, fod->rspdma,
+			fc_dma_unmap_single(tgtport, fod->rspdma,
 				sizeof(fod->rspiubuf), DMA_TO_DEVICE);
 	}
 }
@@ -730,7 +741,7 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tgt_queue *queue,
 	struct nvmet_fc_defer_fcp_req *deferfcp;
 	unsigned long flags;
 
-	fc_dma_sync_single_for_cpu(tgtport->dev, fod->rspdma,
+	fc_dma_sync_single_for_cpu(tgtport, fod->rspdma,
 				sizeof(fod->rspiubuf), DMA_TO_DEVICE);
 
 	fcpreq->nvmet_fc_private = NULL;
@@ -1925,7 +1936,7 @@ nvmet_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
 	struct nvmet_fc_ls_iod *iod = lsrsp->nvme_fc_private;
 	struct nvmet_fc_tgtport *tgtport = iod->tgtport;
 
-	fc_dma_sync_single_for_cpu(tgtport->dev, iod->rspdma,
+	fc_dma_sync_single_for_cpu(tgtport, iod->rspdma,
 				sizeof(*iod->rspbuf), DMA_TO_DEVICE);
 	nvmet_fc_free_ls_iod(tgtport, iod);
 	nvmet_fc_tgtport_put(tgtport);
@@ -1937,7 +1948,7 @@ nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 {
 	int ret;
 
-	fc_dma_sync_single_for_device(tgtport->dev, iod->rspdma,
+	fc_dma_sync_single_for_device(tgtport, iod->rspdma,
 				  sizeof(*iod->rspbuf), DMA_TO_DEVICE);
 
 	ret = tgtport->ops->xmt_ls_rsp(&tgtport->fc_target_port, iod->lsrsp);
@@ -2091,7 +2102,7 @@ nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 
 	fod->data_sg = sg;
 	fod->data_sg_cnt = nent;
-	fod->data_sg_cnt = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
+	fod->data_sg_cnt = fc_dma_map_sg(fod->tgtport, sg, nent,
 				((fod->io_dir == NVMET_FCP_WRITE) ?
 					DMA_FROM_DEVICE : DMA_TO_DEVICE));
 				/* note: write from initiator perspective */
@@ -2109,7 +2120,7 @@ nvmet_fc_free_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 	if (!fod->data_sg || !fod->data_sg_cnt)
 		return;
 
-	fc_dma_unmap_sg(fod->tgtport->dev, fod->data_sg, fod->data_sg_cnt,
+	fc_dma_unmap_sg(fod->tgtport, fod->data_sg, fod->data_sg_cnt,
 				((fod->io_dir == NVMET_FCP_WRITE) ?
 					DMA_FROM_DEVICE : DMA_TO_DEVICE));
 	sgl_free(fod->data_sg);
@@ -2193,7 +2204,7 @@ nvmet_fc_prep_fcp_rsp(struct nvmet_fc_tgtport *tgtport,
 		fod->fcpreq->rsplen = sizeof(*ersp);
 	}
 
-	fc_dma_sync_single_for_device(tgtport->dev, fod->rspdma,
+	fc_dma_sync_single_for_device(tgtport, fod->rspdma,
 				  sizeof(fod->rspiubuf), DMA_TO_DEVICE);
 }
 
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index e56f323fa7d4..2ccb941efb21 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1043,7 +1043,7 @@ static struct nvmet_fc_target_template tgttemplate = {
 	.max_dif_sgl_segments	= FCLOOP_SGL_SEGS,
 	.dma_boundary		= FCLOOP_DMABOUND_4G,
 	/* optional features */
-	.target_features	= 0,
+	.target_features	= NVMET_FCTGTFEAT_VIRTUAL_DMA,
 	/* sizes of additional private data for data structures */
 	.target_priv_sz		= sizeof(struct fcloop_tport),
 	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 2a38f2b477a5..675c7ef6df17 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -707,6 +707,8 @@ enum {
 		 * sequence in one LLDD operation. Errors during Data
 		 * sequence transmit must not allow RSP sequence to be sent.
 		 */
+	NVMET_FCTGTFEAT_VIRTUAL_DMA = (1 << 1),
+		/* Bit 1: Virtual LLDD with no DMA support */
 };
 
 
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
