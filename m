Return-Path: <SRS0=qz9S=AR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A8AC433DF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2020 23:59:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72F020823
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2020 23:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0Fb9qLbK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lfytxwj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72F020823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1JZvLxZx91zEWB6d9BFEgKDA/p5RdsLv25DIOX/UeQ8=; b=0Fb9qLbKNn73q2UZG7e6ClYY2E
	MQ/+VKS4VjICY4VqSNw6kfJq2mh25FkvZR4alGe5vqnHnUIsAzgkEOuycGGW3Og0c24CXNITNH7+V
	f5exnoouVV/RSclGdTKxuYCEpwjk+E80K8OfDaTiDsYG3QeB6eJBOseyUalKmCuv/wykv2jW3Hlyt
	FG8wzfXALGKSGfvYRNtkzCVNF4M6dZiRK2TV62g1YUme73l/I//XIK0uactz/EojVk0HwPnfLNX3H
	rmjNL60MNnzQQUL2NiwJ87f/SNOkoD4C0Jgi9RZXTAZrzoVhuSkykQozFMDI6uQfd8ElnwlNTNQDf
	1fKZtzBg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsb1L-0000Yu-EN; Mon, 06 Jul 2020 23:59:35 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsb1H-0000YU-Vz
 for linux-nvme@lists.infradead.org; Mon, 06 Jul 2020 23:59:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594079973; x=1625615973;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rxtULAXllvYwscNa+gyNSPAEm9SX2NfLgHrOoJBHlSU=;
 b=Lfytxwj1qsRJqAf3t1Dwdjn1fU6E/65vi/GfvnjgyAeY5CK5CGXxbsbR
 gtOpLb+roleL8SajLMj8b4x0dePaoNJ9Y4/OBJdz1ebDkvaoWFocNeSre
 5VuPCGVihkuQWRN5hJwrg5W2g3ITSEyitWdvg0jujiQPjfbaLy5ORYe1p
 IYvl57zRIy2WEIn4YnEn9knrso0Eyc6GpHaS1tz9k34g1xxqKNS/EUydI
 mULx6Iho5fBkbduIQIvnhm9OtFSb+lkuYdWB4yGTKOQ2teVbuFvPfPM3r
 fktdoVD+eEt91YjY6Ik9p/Erp2b5bYwqnH9An2epXqGM0OlnA3f+v7nK2 Q==;
IronPort-SDR: PtpLt+ZgcvZTSeANoINxF63WASq4p7uDSCR3kBdSNBhH/zypMtTM48H/qdHUvBIvWmM/pON1Jv
 o+rlSlYCkZSHb7LVeQ7gkLm/lamkxu8LQwtO8AdagjANv8oT65uF5qjTRVxe8j/Wl8hQggGQI4
 79b7XwBdUpAI8lGb6Dqo0hI34ZMObyzhxf1pnHXWOwh9pz+6Vml90CYmPVEEeWGnrUUGI+uDN0
 kVMYiOGlNm7a7MWhYq2rGTf47NWx8+KdP7IiwZOLN9mWXX60YVCfFpQMcnpKjyFc0f1Dx43FhW
 mFs=
X-IronPort-AV: E=Sophos;i="5.75,321,1589212800"; 
 d="scan'208,223";a="244790329"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 07:59:48 +0800
IronPort-SDR: V9QhLwL74aRNNz9nA+Fvo8kZ1jIAFGtiMRdpblOFAvCHJNv8S/V26c4T0x1B3g+8dAdRuc0Tz1
 hRPKuBEfZaro6Sx9nL7zC0Hh/evShbgdo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 16:47:33 -0700
IronPort-SDR: sgD9+0IAXfn3o5ZlU/s5MyBwkkYqFFr0auERCgyuSk4uKI4pmCzoMC/ooWCtj6+l8PwlPdGC2H
 WFaRP3Ffpy7A==
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2020 16:59:27 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH RFC] nvme-pci: remove the unsed code in alloc_size
Date: Mon,  6 Jul 2020 15:53:05 -0700
Message-Id: <20200706225305.14892-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200706_195932_238959_741680B5 
X-CRM114-Status: GOOD (  14.05  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From the initial implementation of NVMe SGL kernel support
commit a7a7cbe353a5 ("nvme-pci: add SGL support") with addition of the
commit 943e942e6266 ("nvme-pci: limit max IO size and segments to avoid
high order allocations") now there is only caller left for
nvme_pci_iod_alloc_size() which statically passes true for last
parameter that calculates allocation size based on SGL since we need
size of biggest command supported for mempool allocation.

This patch removes the helper functions nvme_pci_iod_alloc_size() and
nvme_npages() used for allocation size calculation and open codes it
into nvme_probe().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Hi,

We can get rid of unused code with this patch, would like to get some
feedback, Tagging it as an RFC since I've only tested fio verification
and did not test all the cases with sgl and prp.

If we decided to get it I can put more effort on this.

Regards,
Chaitanya
---
 drivers/nvme/host/pci.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 07ac28d7d66c..aad8cc176219 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -341,18 +341,6 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
 	return true;
 }
 
-/*
- * Will slightly overestimate the number of pages needed.  This is OK
- * as it only leads to a small amount of wasted memory for the lifetime of
- * the I/O.
- */
-static int nvme_npages(unsigned size, struct nvme_dev *dev)
-{
-	unsigned nprps = DIV_ROUND_UP(size + dev->ctrl.page_size,
-				      dev->ctrl.page_size);
-	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
-}
-
 /*
  * Calculates the number of pages needed for the SGL segments. For example a 4k
  * page can accommodate 256 SGL descriptors.
@@ -362,19 +350,6 @@ static int nvme_pci_npages_sgl(unsigned int num_seg)
 	return DIV_ROUND_UP(num_seg * sizeof(struct nvme_sgl_desc), PAGE_SIZE);
 }
 
-static unsigned int nvme_pci_iod_alloc_size(struct nvme_dev *dev,
-		unsigned int size, unsigned int nseg, bool use_sgl)
-{
-	size_t alloc_size;
-
-	if (use_sgl)
-		alloc_size = sizeof(__le64 *) * nvme_pci_npages_sgl(nseg);
-	else
-		alloc_size = sizeof(__le64 *) * nvme_npages(size, dev);
-
-	return alloc_size + sizeof(struct scatterlist) * nseg;
-}
-
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
@@ -2814,8 +2789,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * Double check that our mempool alloc size will cover the biggest
 	 * command we support.
 	 */
-	alloc_size = nvme_pci_iod_alloc_size(dev, NVME_MAX_KB_SZ,
-						NVME_MAX_SEGS, true);
+	alloc_size = sizeof(__le64 *) * nvme_pci_npages_sgl(NVME_MAX_SEGS) +
+		sizeof(struct scatterlist) * NVME_MAX_SEGS;
+
 	WARN_ON_ONCE(alloc_size > PAGE_SIZE);
 
 	dev->iod_mempool = mempool_create_node(1, mempool_kmalloc,
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
