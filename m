Return-Path: <SRS0=NJ67=AU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068E9C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2020 23:40:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98CF20672
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2020 23:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zFm2HnEU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZNnp141W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98CF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LPisNz3+VBTDdZ8TaIkidjQGq5UctQc1t1UNkTuuPpc=; b=zFm2HnEUe1U4oXW6QiIqVHYIZ
	CgemTuNGxfGJnW2nZOsEdRQqHSz27ny6CF2d6dSjSbZED75s0YEgNC135PvEqANZlCugcO1obIUFF
	9+Etdu55ql4sB0HQYgf2WzXauFTxeei7jKqlloSiSiqE3SP4ekhXXSOf8f3kjp1LdRj2Fh/KMBoFV
	1qLnRq515eUo5twViLC9v3reiO8gkU/O7QVg+EwbXtU/U3le19Q+V9dWFOOd6tC+XA0/Epa9ScjpE
	upcHmKwtzh/ZLGBDVCQxqPK5NXmSFTyltNNn9RyFkoUBHlqQ38IoCdq1Qp/UzrpIue2XUIpymS/WX
	kcvtMLYXA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtg9c-0003lR-1e; Thu, 09 Jul 2020 23:40:36 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtg9Y-0003k7-5x
 for linux-nvme@lists.infradead.org; Thu, 09 Jul 2020 23:40:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594338041; x=1625874041;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MiOw1Qy7CI+IrZPIRIhZgaXOuUyQ/48hyxby5tsq8zQ=;
 b=ZNnp141WTmaVVzMlSQGaogjnD17Qj7g9GVcNE7bEv9iQwZJgjzP0V0+L
 qnTkS3DxgrNuWsMSozMbZHEqSbsZFTvR0oIaBs7RQrxLB9AWAoxfCjkf0
 s70HsSHYg5gJykzO9w4be+Be7jLTJUNKrbw/35nmrxKCv1FdduBqHXHcb
 xJPdr7C1IyveZX7ST6qKfXiU9ENeZIcfgBBeUuz5zG92iplBm2XV9p3pV
 2Jiz9o7MpQEn9lUbiLqECVJoS61pBmS5pFA0M0deKZ813C4wUJF2bm1/C
 oqbRebZsMJXt+AW7VOvfY3JrrpWKSi0g1Qz11RiUxR4uDNhb5qJFwBb7Q g==;
IronPort-SDR: nessE6vGtLlCyZJXwqTMFnsGqlq3E1u98H3t7/eC+xQeICY0xT7ntPdMc+hBAI7IAqmLw2mXiS
 5CVbTD2v6VairEQq3TlIby2UmXFFqp2hWBHK1r2N4cj1yv9o7AWZ0rj5MneBiDg3F5KulTvcG6
 KU6LI29Uw8rrLjTVvkaaO5YDOtQP6Tk6QRx+RvVmHE7/ziMJC5OW1PLx+9IUYEm1pbo+ZAOvTe
 AfOLjsplRC5YxHyRBr0rati4QSj2PRUOkGt2pN03P8jbdLRx3Bjb6JaIzqj4CcamBqBQDBM2NO
 H9I=
X-IronPort-AV: E=Sophos;i="5.75,332,1589212800"; d="scan'208";a="245096144"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2020 07:40:35 +0800
IronPort-SDR: PmCl9uY/w/U3j6JZ+zRhVLn9AOtoYRH4LAVR2aqTWW1PGBfW9NaeJROaE4zSaibxy8uVaVkSam
 KTW7e5r7+0KwWyBHUwxhzh7jbtzUMsxTs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 16:28:30 -0700
IronPort-SDR: Zdb2K16OiwmHp8lDRD1eiDPra9ZPtyi4x5BQKxmAmaYG3fTxwqAQ91s445++VHAE8q1hzkpw/h
 FfrakwyDhLPA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2020 16:40:28 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH V2 1/2] nvme-core: replace ctrl page size with a macro
Date: Thu,  9 Jul 2020 16:40:24 -0700
Message-Id: <20200709234025.10673-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200709234025.10673-1-chaitanya.kulkarni@wdc.com>
References: <20200709234025.10673-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200709_194032_525020_CB76403A 
X-CRM114-Status: GOOD (  20.24  )
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

In nvme_probe() when calculating mempool size nvme_npages uses
dev->ctrl.page_size which is initialized in the following code path:-

Ctx insmod :
nvme_probe()
 nvme_reset_ctrl()
  queue_work(nvme_reset_work()

Ctx Workqueue :
nvme_reset_work()
 nvme_pci_configure_admin_queue()
  nvme_enable_ctrl()
   ctrl->page_size = 1 << NVME_CTRL_PAGE_SHIFT.

When nvme_pci_iod_alloc_size() is called with false as last argument it
results in following oops since dev->ctrl.page_size used before we set
it in the nvme_enable_ctrl() in above path :-

Entering kdb (current=0xffff88881fc0c980, pid 339) on processor 0 Oops: (null)
due to oops @ 0xffffffffa05f1723
CPU: 0 PID: 339 Comm: kworker/0:2 Tainted: G        W  OE     5.8.0-rc1nvme-5.9+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.4Workqueue: events work_for_cpu_fn
RIP: 0010:nvme_probe+0x263/0x502 [nvme]
Code: 00 00 66 41 81 7c 24 3c 4d 14 0f 84 98 01 00 00 3d 0f 1e 01 00 0f 84 aa 01 00 00 8b 8b a0 0c 00 2
RSP: 0018:ffffc90000d9bdd8 EFLAGS: 00010246
RAX: 0000000000000fff RBX: ffff8887da128000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000246
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffff8887c29f5570 R12: ffff888813c37000
R13: 0000000000000202 R14: 0000000fffffffe0 R15: ffff888813c370b0
FS:  0000000000000000(0000) GS:ffff88880fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f23185131a0 CR3: 0000000811c54000 CR4: 00000000003406f0
Call Trace:
 local_pci_probe+0x42/0x80
 work_for_cpu_fn+0x16/0x20
 process_one_work+0x24e/0x5a0
 ? __schedule+0x353/0x840
 worker_thread+0x1d5/0x380
 ? process_one_work+0x5a0/0x5a0
 kthread+0x135/0x150
 ? kthread_create_on_node+0x60/0x60
 ret_from_fork+0x22/0x30

This patch removes the dev->ctrl.page_size variable and replaces with
the macro which avoids above oops.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 19 ++++++-----------
 drivers/nvme/host/nvme.h |  9 +++++++-
 drivers/nvme/host/pci.c  | 45 ++++++++++++++++++++--------------------
 3 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3d00ea4e7146..b9b4aa7b53ce 100644
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
index 13ca90bcd352..25dae702e0a2 100644
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
+#define NVME_CTRL_PAGE_SIZE	4096
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
index 45e94f016ec2..68f7c090cf51 100644
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
@@ -1825,7 +1824,7 @@ static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
 	c.features.fid		= cpu_to_le32(NVME_FEAT_HOST_MEM_BUF);
 	c.features.dword11	= cpu_to_le32(bits);
 	c.features.dword12	= cpu_to_le32(dev->host_mem_size >>
-					      ilog2(dev->ctrl.page_size));
+					      ilog2(NVME_CTRL_PAGE_SIZE));
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
