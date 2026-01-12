Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCC5C9EC8D
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 14:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=1Nwy38gzNTR9aM/4Tkn5EF8sUONjKB4ojmLE6vwCAvk=; b=Zo5YLNBYc119rdDOYt98l8weM9
	ROOax0stx19nGDMgcTj25N07c12YunTV9+7Aq3lR9ns/5C2E48TUOPIKxuoET+ST/TeVpBoFZ1V82
	xWg/SXyQjmN7fihcnwRzwcaxkBtFQZNlkeZin9NsO6BJz7ZQcOhbUg0nDyIyI8pjJmSZkgfZ91l84
	guiQA0XnkESRr2jDdE7evj7rC7Xgn/Jm6OxXzQxuliy4vlqQfSCqxPKSBVKiY4CqCowPqcrc4IUn8
	SW3BarEwJOjEqrP7/IIXmocTLqtt8YUbaBu/v/Q/zLNeZS1b9fWNIb2JhjGZEQjwjOmwy1sd8z2L5
	3kpKbaUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfJ80-00000005YcW-2XqT;
	Mon, 12 Jan 2026 14:42:44 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfJ7v-00000005Ybm-49G2
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 14:42:42 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260112144232epoutp02a53896dce6a3152117142de5102dd317~KAt0K09a90382303823epoutp02P
	for <linux-nvme@lists.infradead.org>; Mon, 12 Jan 2026 14:42:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260112144232epoutp02a53896dce6a3152117142de5102dd317~KAt0K09a90382303823epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768228952;
	bh=1Nwy38gzNTR9aM/4Tkn5EF8sUONjKB4ojmLE6vwCAvk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=PwMQznoF7DhOkSKRckq31O4FWCHTUf/uEXpbUZeZ5nEIZkBg8wHYC+EnCBNfOqDqh
	 mp7unvcMOqwZX3K4PqAmPOX3eyDU/4EE2kX3Z1oTUdozE4Rw/gHnyH8PkGn2tTaeCu
	 YcDED1qZi7FNlxV++SKwS3Y9WsgZrVYl3Uf4wlCc=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260112144231epcas5p4f7f81ae95ac8bd20631d34a53cb7a215~KAtz6gsGa1469114691epcas5p4L;
	Mon, 12 Jan 2026 14:42:31 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dqZpt6B18z3hhT3; Mon, 12 Jan
	2026 14:42:30 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260112144230epcas5p34403fd2f51e32c77ad4de7bac8c98a18~KAtyQ4Juy2690926909epcas5p3j;
	Mon, 12 Jan 2026 14:42:30 +0000 (GMT)
Received: from green245.samsungds.net (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260112144228epsmtip1781bb113d9d4b9fdc8aba7f85b6ad24b~KAtxDr_lZ1455814558epsmtip1x;
	Mon, 12 Jan 2026 14:42:28 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
	Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: nitheshshetty@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH] block, nvme: remove unused dma_iova_state function
 parameter
Date: Mon, 12 Jan 2026 20:08:08 +0530
Message-Id: <20260112143810.2046599-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260112144230epcas5p34403fd2f51e32c77ad4de7bac8c98a18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260112144230epcas5p34403fd2f51e32c77ad4de7bac8c98a18
References: <CGME20260112144230epcas5p34403fd2f51e32c77ad4de7bac8c98a18@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_064241_471590_CA373BBE 
X-CRM114-Status: GOOD (  17.19  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DMA IOVA state is not used inside blk_rq_dma_map_iter_next

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-mq-dma.c         | 3 +--
 drivers/nvme/host/pci.c    | 5 ++---
 include/linux/blk-mq-dma.h | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 752060d7261cb..3c87779cdc19d 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -233,7 +233,6 @@ EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
  * blk_rq_dma_map_iter_next - map the next DMA segment for a request
  * @req:	request to map
  * @dma_dev:	device to map to
- * @state:	DMA IOVA state
  * @iter:	block layer DMA iterator
  *
  * Iterate to the next mapping after a previous call to
@@ -248,7 +247,7 @@ EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
  * returned in @iter.status.
  */
 bool blk_rq_dma_map_iter_next(struct request *req, struct device *dma_dev,
-		struct dma_iova_state *state, struct blk_dma_iter *iter)
+		struct blk_dma_iter *iter)
 {
 	struct phys_vec vec;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3b528369f5454..065555576d2f9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -823,7 +823,7 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 
 	if (iter->len)
 		return true;
-	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
+	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
 		return false;
 	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
 		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
@@ -1010,8 +1010,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 		}
 		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
-	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, &iod->dma_state,
-				iter));
+	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
 	nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma, mapped);
 	if (unlikely(iter->status))
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index cb88fc791fbd1..214c181ff2c9c 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -28,7 +28,7 @@ struct blk_dma_iter {
 bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
 		struct dma_iova_state *state, struct blk_dma_iter *iter);
 bool blk_rq_dma_map_iter_next(struct request *req, struct device *dma_dev,
-		struct dma_iova_state *state, struct blk_dma_iter *iter);
+		struct blk_dma_iter *iter);
 
 /**
  * blk_rq_dma_map_coalesce - were all segments coalesced?
-- 
2.39.5


