Return-Path: <SRS0=+Irc=AJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20274C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jun 2020 10:37:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D816320768
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jun 2020 10:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZOz3qeof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D816320768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+sN/Fwx4ZfHbF6fEqGprgk7Rh8DufUlhU7wvypHdeEU=; b=ZOz3qeofFNTyCWjDCeNwu6k25M
	Ytpxbn9uaSt5Jl/hJJeWmOAP61zmrjDhTJSlQzBieNAwtRB9tTA/VddpA7jYQTbwwUhL/8lAr9Ynw
	OQuttcOEIbCR2bE7kBtAzw1UESBgygwXpFIdDip7HghklJO07qNdcH3hT+TInbPb6PK8zk9PbDDZm
	OYG6pplCs2V5iyGU7eS+hH2cAS9aQNdwtdU5YZ0TcKASlXONGl7mYb6u+HSExj1FGlRDv8Zmd21N/
	Qah6RXZyHhXUnJtQ1Q4P9B7B2hzp+QyLZPzdkQtt8pux8kbki36XozgTO2FgvWKNoF/IrkRtPOuEO
	GuOVsP6w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpUgs-0001RC-Id; Sun, 28 Jun 2020 10:37:38 +0000
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpUgp-0001Qo-PZ
 for linux-nvme@lists.infradead.org; Sun, 28 Jun 2020 10:37:36 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R531e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07484;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0U0v-6Et_1593340497; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U0v-6Et_1593340497) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 28 Jun 2020 18:34:57 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Subject: [RFC PATCH] nvme-pci: Move the sg table allocation/free into
 init/exit_request
Date: Sun, 28 Jun 2020 18:34:46 +0800
Message-Id: <4eedad1efab91f4529de19e14ba374da405aea3f.1593340208.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
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
Cc: baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Move the sg table allocation and free into the init_request() and
exit_request(), instead of allocating sg table when queuing requests,
which can benefit the IO performance.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b1d18f0..cf7c997 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -410,9 +410,25 @@ static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
 	iod->nvmeq = nvmeq;
 
 	nvme_req(req)->ctrl = &dev->ctrl;
+
+	iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
+	if (!iod->sg)
+		return -ENOMEM;
+
+	sg_init_table(iod->sg, NVME_MAX_SEGS);
 	return 0;
 }
 
+static void nvme_exit_request(struct blk_mq_tag_set *set, struct request *req,
+			      unsigned int hctx_idx)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_dev *dev = set->driver_data;
+
+	mempool_free(iod->sg, dev->iod_mempool);
+	iod->sg = NULL;
+}
+
 static int queue_irq_offset(struct nvme_dev *dev)
 {
 	/* if we have more than 1 vec, admin queue offsets us by 1 */
@@ -557,8 +573,6 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 		dma_pool_free(dev->prp_page_pool, addr, dma_addr);
 		dma_addr = next_dma_addr;
 	}
-
-	mempool_free(iod->sg, dev->iod_mempool);
 }
 
 static void nvme_print_sgl(struct scatterlist *sgl, int nents)
@@ -808,10 +822,6 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	}
 
 	iod->dma_len = 0;
-	iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
-	if (!iod->sg)
-		return BLK_STS_RESOURCE;
-	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
 	iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
 	if (!iod->nents)
 		goto out;
@@ -1557,6 +1567,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	.complete	= nvme_pci_complete_rq,
 	.init_hctx	= nvme_admin_init_hctx,
 	.init_request	= nvme_init_request,
+	.exit_request	= nvme_exit_request,
 	.timeout	= nvme_timeout,
 };
 
@@ -1566,6 +1577,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
 	.init_request	= nvme_init_request,
+	.exit_request	= nvme_exit_request,
 	.map_queues	= nvme_pci_map_queues,
 	.timeout	= nvme_timeout,
 	.poll		= nvme_poll,
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
