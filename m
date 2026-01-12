Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8345CC9EC8D
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=aDUZi0sW5KpVk8O9w7PsuWUSSr4NALJUTKZn+c+CrZ4=; b=k48ndog/iKkza/wIQeWSN1Xw7t
	hP8LZjZTbafbuDnB5lnJ6Oi4ZaA0xE3uO9Rb9+cW+3InNAX7gwemvVBWFPZXY3QITyWuQJ5fcHzSN
	JYbzaLvvtphuJEZYZ+CMtpPe4nWDST1QmOZnTwaYSz151i6NVfeEcuI03bDTC07u6cbiPgETdH/Pr
	0LQhM8IMnHrktfZymx84ALlKjlxJSJmxfO9dXFHfPBZ93+ML57XVTIQDYm0/Cu5dyMAIZXoAWZ4Sq
	7+xZuS38m5eH5zQwhKe+4hTl/Wb8iXCDnPuvc2xF75XltfG3dLjk80391d9McG5+foaSeVcfeuzaf
	uQDdLoWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfIUn-00000005TfX-1fSj;
	Mon, 12 Jan 2026 14:02:13 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfIUj-00000005TeR-17wF
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 14:02:11 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260112140201epoutp03498cc0e84c9425bf1116a2a8a417d01f~KAKcdbOA22245722457epoutp03S
	for <linux-nvme@lists.infradead.org>; Mon, 12 Jan 2026 14:02:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260112140201epoutp03498cc0e84c9425bf1116a2a8a417d01f~KAKcdbOA22245722457epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768226521;
	bh=aDUZi0sW5KpVk8O9w7PsuWUSSr4NALJUTKZn+c+CrZ4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=YjrbOqC3TLl8Sff/JNY29mWhOL7uX30swfkGCPEFv7q/ksbgZDnn96OCY9PyrCBey
	 xYcaadZqP/u8jZ0L7HRuJxGsgD/ojCIKCi2iWrkEgKvSWQBu7FCJUjCNMqUvDrwG4p
	 rqKiW3pZwOesHnBoDcudUEIcs4ppuh2eLWJ729s8=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260112140201epcas5p3842bfa747589247bb0e86c3f67670439~KAKcFJlIa1186011860epcas5p3l;
	Mon, 12 Jan 2026 14:02:01 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dqYw80p4rz2SSKZ; Mon, 12 Jan
	2026 14:02:00 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260112140159epcas5p35303b39d11d8379b8527026e72bf0f40~KAKaWWzx_1186011860epcas5p3g;
	Mon, 12 Jan 2026 14:01:59 +0000 (GMT)
Received: from green245.samsungds.net (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260112140158epsmtip1345f77e91c55ddbd72c57a69f44e0368~KAKZgQDIy2301023010epsmtip1d;
	Mon, 12 Jan 2026 14:01:58 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: nitheshshetty@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] block: remove unused dma_iova_state function parameter
Date: Mon, 12 Jan 2026 19:27:34 +0530
Message-Id: <20260112135736.1982406-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260112140159epcas5p35303b39d11d8379b8527026e72bf0f40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260112140159epcas5p35303b39d11d8379b8527026e72bf0f40
References: <CGME20260112140159epcas5p35303b39d11d8379b8527026e72bf0f40@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_060209_934969_D6C5AF22 
X-CRM114-Status: GOOD (  15.59  )
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
 include/linux/blk-mq-dma.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

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


