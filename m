Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA38C9EC8D
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F8XIfRGmzdb5XWDs6wzAnnRSl2u/PNPN8Ha1qyK76Ks=; b=d6fEZ6/+WB0Do3Nk2skW/Wtrfb
	uELRQ8Fz+U+2f3BDuU8yEI40lWS86ykTeqffCH+ZEogkOtyfbd7tyHTPhLon2L+Y7G0nFcw+3tuOh
	YlXMS6PTUwIZyLdQ+Lb3LU1AF1Nm9x9sGN78zapr3qPP+tinlvlBiSig99U5Cj6ZjihefpY8bkRHi
	Wygtu+/pVal11kekRWZlEH5i5iBtCsLO0kSlycm0l/mqNG9PFIoikU9HTMyOC4PHAqyzBrvAaKmi1
	cYK0/ecUYUxWqxg7F/tlOzGsiBjEfieEmcqFAEmuVvRM7pLRsjqUvXbV+Ia3CR7q3FCy/9vUkQNpI
	MSp4vLcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfIUs-00000005ThJ-16YB;
	Mon, 12 Jan 2026 14:02:18 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfIUp-00000005TfV-2W1p
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 14:02:17 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260112140210epoutp02190552ad3fc921a9f1c84638e8a498e7~KAKkrYNZi0383003830epoutp02u
	for <linux-nvme@lists.infradead.org>; Mon, 12 Jan 2026 14:02:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260112140210epoutp02190552ad3fc921a9f1c84638e8a498e7~KAKkrYNZi0383003830epoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768226530;
	bh=F8XIfRGmzdb5XWDs6wzAnnRSl2u/PNPN8Ha1qyK76Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgJMsC+9MrSRiaIWGKRtv9yZ1FTj9wU0jqNftNmvU/q0jpR4gitZvcc+IeWGJBgiN
	 7ApUvmmGIO0hvEjZGqWqj1ZeE77WiYu21fWcLoRO/SfThpYd8wIqcKT5J6A8QZZcAL
	 OAm5wTWpVopxxAtf66lhAy/11LpPeNI58qBfx+AQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260112140209epcas5p34a75489e5b704a71f6f1e2d5abfe17f3~KAKkHukyi3268932689epcas5p3c;
	Mon, 12 Jan 2026 14:02:09 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.92]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dqYwJ75Pqz6B9m6; Mon, 12 Jan
	2026 14:02:08 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d~KAKiseA2t2139421394epcas5p4s;
	Mon, 12 Jan 2026 14:02:08 +0000 (GMT)
Received: from green245.samsungds.net (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260112140203epsmtip102e49e4a80ba13f22199a3e119f3dc9b~KAKeY6_X02303823038epsmtip1h;
	Mon, 12 Jan 2026 14:02:02 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: nitheshshetty@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme: blk_rq_dma_map_iter_next is no longer using iova
 state
Date: Mon, 12 Jan 2026 19:27:35 +0530
Message-Id: <20260112135736.1982406-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260112135736.1982406-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d
References: <20260112135736.1982406-1-nj.shetty@samsung.com>
	<CGME20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_060215_812566_A075E51E 
X-CRM114-Status: GOOD (  14.11  )
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
 drivers/nvme/host/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

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
-- 
2.39.5


