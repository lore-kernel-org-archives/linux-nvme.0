Return-Path: <SRS0=QPGu=A4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6397DC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 00:52:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27450207BC
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 00:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JpIos7a6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TJwq0s51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27450207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Em4/t1TfLGIGF7Pmf4O1zjbw+Ww+zzvOkA7e6aU9g7g=; b=JpIos7a6FYJGtcjX0n+diXGwP
	6Fg8LT8QcdkOFreHUEyAqDEz/vO2f3gLUXoPpEybpVbH7PlSuwrzt8/FxLhiBP0Z9r2yUjVUh9og6
	RHPt7h0k9JXvi3EWaRgwPEpted/bR1GNJpWrU5wtjoSVrGN2EK2G7OPrpQGYoQ7TY82T+VBian97U
	o0952lKYtaPprXYBLae2moGEbm5qx5untBcSU/NkQfESy6+TVUD6WlTwlt3txUi9ipWmSVnunoBLK
	R7Gek9kwOBFjv0gKVx+OK8bN1vk96+aa2/Fl3oA0nynTtlOePOzu8hAAFL/apJytIzZJJgDXqMJx2
	5T2F+NQpA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwEbR-0008DM-F1; Fri, 17 Jul 2020 00:51:53 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwEbP-0008Cr-1z
 for linux-nvme@lists.infradead.org; Fri, 17 Jul 2020 00:51:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594947111; x=1626483111;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DJJihHeyQS3ACn1G3IC2JUELJMB+RyIys6TkpFFIR+Y=;
 b=TJwq0s510EM2P3sXQdOoZAlhvnqNmBJgkB08jJqkRCh//Eg8iI+ClW3G
 UU/QabKjilLZrZzzEFZTuhn0YKNXyO7B16cP8EhqJ0w49LLkVUPGPKHHH
 VKJZlOYBduSV4v7eL/rGjFHOvfLwgsfC+9XwLFLctSwHit1x37j+EatX5
 HBY/62KcEq7kvMqogUBVQVICRt548tBzSwBWMBKT7OvaGAKOgPFym51lj
 YYiZHigc9ZXuObK4EI8Lu3+vssENuAVm9QuAtAZr+Fu00OH1QPYioStmE
 hMuovXnF4tw30GBhNJOk5rSFOECiwv4HVNpGdM6U+6DQX+6M/cIzk/xG3 w==;
IronPort-SDR: WXPlbjQpT2hr1SNOJBjnRJCK93zYNHw2i0mg721qdYdPVrPgEcdsHMI9LP3fIxVuL8y8qAsA1H
 1HLEdxtVyiCrf1O+UJFxp3DnlnrJf+F5iJSUm5fnbiLJ1QvJBiN/vKfUo8xP+LMv05JpHySihG
 arRkMZbAXkQquKqFlsaOd6OHfgPMIy+b8b9Yj4kzAzJIrFzkYZy8oEsh5JcIoNbLRfmlZWJnY1
 +ClVRYxujZVvqj0vbOV+6c4aRP30OQJVOyuNpPOyjZqFCpSDAKgv257o7sAs1moXEpUcFnZey2
 5eE=
X-IronPort-AV: E=Sophos;i="5.75,361,1589212800"; d="scan'208";a="251928110"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 08:51:49 +0800
IronPort-SDR: +DJCTcNGoLA/R65g9fScQxBtEeuXLYOVrJI2wTZz6c3AIDAyLlUKkgPsJoSIL4VzfcMEQBwViw
 RQnnaYdfCkeGWpMzNvaUGNOaLT3peqwBo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2020 17:40:12 -0700
IronPort-SDR: mQHBbpUa41QxlGNT45oTf/e4tYN7o28TYw1QNmfNoOehgcXaiS5o55f02qrVbUn6KEyXDkt6e0
 Z+HfazOFnOjw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 17:51:49 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH V4 1/3] nvme-core: replace ctrl page size with a macro
Date: Thu, 16 Jul 2020 17:51:37 -0700
Message-Id: <20200717005139.18923-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200717005139.18923-1-chaitanya.kulkarni@wdc.com>
References: <20200717005139.18923-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_205151_332754_30D6B53B 
X-CRM114-Status: GOOD (  19.83  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Saving the nvme controller's page size was from a time when the driver
tried to use different sized pages, but this value is always set to
a constant, and has been this way for some time. Remove the 'page_size'
field and replace its usage with the constant value.

This also lets the compiler make some micro-optimizations in the io
path, and that's always a good thing.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 19 +++++-----------
 drivers/nvme/host/nvme.h |  9 +++++++-
 drivers/nvme/host/pci.c  | 47 ++++++++++++++++++++--------------------
 3 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f49085bcaa42..1d7c7afb1348 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2345,12 +2345,7 @@ EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
 
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 {
-	/*
-	 * Default to a 4K page size, with the intention to update this
-	 * path in the future to accomodate architectures with differing
-	 * kernel and IO page sizes.
-	 */
-	unsigned dev_page_min, page_shift = 12;
+	unsigned dev_page_min;
 	int ret;
 
 	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
@@ -2360,20 +2355,18 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	}
 	dev_page_min = NVME_CAP_MPSMIN(ctrl->cap) + 12;
 
-	if (page_shift < dev_page_min) {
+	if (NVME_CTRL_PAGE_SHIFT < dev_page_min) {
 		dev_err(ctrl->device,
 			"Minimum device page size %u too large for host (%u)\n",
-			1 << dev_page_min, 1 << page_shift);
+			1 << dev_page_min, 1 << NVME_CTRL_PAGE_SHIFT);
 		return -ENODEV;
 	}
 
-	ctrl->page_size = 1 << page_shift;
-
 	if (NVME_CAP_CSS(ctrl->cap) & NVME_CAP_CSS_CSI)
 		ctrl->ctrl_config = NVME_CC_CSS_CSI;
 	else
 		ctrl->ctrl_config = NVME_CC_CSS_NVM;
-	ctrl->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
+	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
 	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
@@ -2423,13 +2416,13 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 
 	if (ctrl->max_hw_sectors) {
 		u32 max_segments =
-			(ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1;
+			(ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
 
 		max_segments = min_not_zero(max_segments, ctrl->max_segments);
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
-	blk_queue_virt_boundary(q, ctrl->page_size - 1);
+	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
 	blk_queue_dma_alignment(q, 7);
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
 		vwc = true;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 13ca90bcd352..2ee91a3dd8e0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -37,6 +37,14 @@ extern unsigned int admin_timeout;
 #define  NVME_INLINE_METADATA_SG_CNT  1
 #endif
 
+/*
+ * Default to a 4K page size, with the intention to update this
+ * path in the future to accommodate architectures with differing
+ * kernel and IO page sizes.
+ */
+#define NVME_CTRL_PAGE_SHIFT	12
+#define NVME_CTRL_PAGE_SIZE	(1 << NVME_CTRL_PAGE_SHIFT)
+
 extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
@@ -234,7 +242,6 @@ struct nvme_ctrl {
 	u32 queue_count;
 
 	u64 cap;
-	u32 page_size;
 	u32 max_hw_sectors;
 	u32 max_segments;
 	u32 max_integrity_segments;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 45e94f016ec2..b092df266501 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -348,8 +348,8 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
  */
 static int nvme_npages(unsigned size, struct nvme_dev *dev)
 {
-	unsigned nprps = DIV_ROUND_UP(size + dev->ctrl.page_size,
-				      dev->ctrl.page_size);
+	unsigned nprps = DIV_ROUND_UP(size + NVME_CTRL_PAGE_SIZE,
+						NVME_CTRL_PAGE_SIZE);
 	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
 }
 
@@ -515,7 +515,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	const int last_prp = dev->ctrl.page_size / sizeof(__le64) - 1;
+	const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
 	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
 	int i;
 
@@ -582,34 +582,33 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	struct scatterlist *sg = iod->sg;
 	int dma_len = sg_dma_len(sg);
 	u64 dma_addr = sg_dma_address(sg);
-	u32 page_size = dev->ctrl.page_size;
-	int offset = dma_addr & (page_size - 1);
+	int offset = dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
 	__le64 *prp_list;
 	void **list = nvme_pci_iod_list(req);
 	dma_addr_t prp_dma;
 	int nprps, i;
 
-	length -= (page_size - offset);
+	length -= (NVME_CTRL_PAGE_SIZE - offset);
 	if (length <= 0) {
 		iod->first_dma = 0;
 		goto done;
 	}
 
-	dma_len -= (page_size - offset);
+	dma_len -= (NVME_CTRL_PAGE_SIZE - offset);
 	if (dma_len) {
-		dma_addr += (page_size - offset);
+		dma_addr += (NVME_CTRL_PAGE_SIZE - offset);
 	} else {
 		sg = sg_next(sg);
 		dma_addr = sg_dma_address(sg);
 		dma_len = sg_dma_len(sg);
 	}
 
-	if (length <= page_size) {
+	if (length <= NVME_CTRL_PAGE_SIZE) {
 		iod->first_dma = dma_addr;
 		goto done;
 	}
 
-	nprps = DIV_ROUND_UP(length, page_size);
+	nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
 	if (nprps <= (256 / 8)) {
 		pool = dev->prp_small_pool;
 		iod->npages = 0;
@@ -628,7 +627,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	iod->first_dma = prp_dma;
 	i = 0;
 	for (;;) {
-		if (i == page_size >> 3) {
+		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
 			__le64 *old_prp_list = prp_list;
 			prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 			if (!prp_list)
@@ -639,9 +638,9 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 			i = 1;
 		}
 		prp_list[i++] = cpu_to_le64(dma_addr);
-		dma_len -= page_size;
-		dma_addr += page_size;
-		length -= page_size;
+		dma_len -= NVME_CTRL_PAGE_SIZE;
+		dma_addr += NVME_CTRL_PAGE_SIZE;
+		length -= NVME_CTRL_PAGE_SIZE;
 		if (length <= 0)
 			break;
 		if (dma_len > 0)
@@ -751,8 +750,8 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 		struct bio_vec *bv)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	unsigned int offset = bv->bv_offset & (dev->ctrl.page_size - 1);
-	unsigned int first_prp_len = dev->ctrl.page_size - offset;
+	unsigned int offset = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
+	unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - offset;
 
 	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
@@ -794,7 +793,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (bv.bv_offset + bv.bv_len <= dev->ctrl.page_size * 2)
+			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
@@ -1396,12 +1395,12 @@ static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 {
 	int q_depth = dev->q_depth;
 	unsigned q_size_aligned = roundup(q_depth * entry_size,
-					  dev->ctrl.page_size);
+					  NVME_CTRL_PAGE_SIZE);
 
 	if (q_size_aligned * nr_io_queues > dev->cmb_size) {
 		u64 mem_per_q = div_u64(dev->cmb_size, nr_io_queues);
 
-		mem_per_q = round_down(mem_per_q, dev->ctrl.page_size);
+		mem_per_q = round_down(mem_per_q, NVME_CTRL_PAGE_SIZE);
 		q_depth = div_u64(mem_per_q, entry_size);
 
 		/*
@@ -1816,6 +1815,7 @@ static inline void nvme_release_cmb(struct nvme_dev *dev)
 
 static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
 {
+	u32 host_mem_size = dev->host_mem_size >> NVME_CTRL_PAGE_SHIFT;
 	u64 dma_addr = dev->host_mem_descs_dma;
 	struct nvme_command c;
 	int ret;
@@ -1824,8 +1824,7 @@ static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
 	c.features.opcode	= nvme_admin_set_features;
 	c.features.fid		= cpu_to_le32(NVME_FEAT_HOST_MEM_BUF);
 	c.features.dword11	= cpu_to_le32(bits);
-	c.features.dword12	= cpu_to_le32(dev->host_mem_size >>
-					      ilog2(dev->ctrl.page_size));
+	c.features.dword12	= cpu_to_le32(host_mem_size);
 	c.features.dword13	= cpu_to_le32(lower_32_bits(dma_addr));
 	c.features.dword14	= cpu_to_le32(upper_32_bits(dma_addr));
 	c.features.dword15	= cpu_to_le32(dev->nr_host_mem_descs);
@@ -1845,7 +1844,7 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 
 	for (i = 0; i < dev->nr_host_mem_descs; i++) {
 		struct nvme_host_mem_buf_desc *desc = &dev->host_mem_descs[i];
-		size_t size = le32_to_cpu(desc->size) * dev->ctrl.page_size;
+		size_t size = le32_to_cpu(desc->size) * NVME_CTRL_PAGE_SIZE;
 
 		dma_free_attrs(dev->dev, size, dev->host_mem_desc_bufs[i],
 			       le64_to_cpu(desc->addr),
@@ -1897,7 +1896,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 			break;
 
 		descs[i].addr = cpu_to_le64(dma_addr);
-		descs[i].size = cpu_to_le32(len / dev->ctrl.page_size);
+		descs[i].size = cpu_to_le32(len / NVME_CTRL_PAGE_SIZE);
 		i++;
 	}
 
@@ -1913,7 +1912,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 
 out_free_bufs:
 	while (--i >= 0) {
-		size_t size = le32_to_cpu(descs[i].size) * dev->ctrl.page_size;
+		size_t size = le32_to_cpu(descs[i].size) * NVME_CTRL_PAGE_SIZE;
 
 		dma_free_attrs(dev->dev, size, bufs[i],
 			       le64_to_cpu(descs[i].addr),
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
