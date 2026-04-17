Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB59F4368B
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/AzM7p18opdrIRbQiJ7D1n4Cz94lVxIsTHGwVc/LYY8=; b=EABtm0gIGVM0hh4YXexv+AQevg
	+il9OGTdXMUGrZNgsVvvCpADEEq3VhgDfAcypgf4tPPSR8Pc95hOeCCiCGTtEP7WB3QRCBhcln4DV
	3bf9kv36l2AV5wBZ4wPk2hC5IuHmUX0yznxlbSNoRx7N6YOuUvBRhy1fxhcZIGJ98eVzkUk9c8MXz
	ey9PIwlVtphhxYbTUPn7FpAeVxnXZM05Uo8XEUwSBTlUkN1O/ymAJ2503PWuBQmKKhNDuvQgRkfzQ
	hFjfY5yPrQYLteWX68wdgjqqvYAPGBzjtc2nyygcL0xpF4l7pAef2PA4PK3C3lcmkwpVEPmagIYmW
	AaNpzqBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDgj8-00000003vgG-3KY0;
	Fri, 17 Apr 2026 10:47:10 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDgj4-00000003vez-2Jrg
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 10:47:08 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260417104658epoutp046148d9b6c5687fb0d7b71f4feb84044a~nHyRV74Tv0967509675epoutp04J
	for <linux-nvme@lists.infradead.org>; Fri, 17 Apr 2026 10:46:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260417104658epoutp046148d9b6c5687fb0d7b71f4feb84044a~nHyRV74Tv0967509675epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776422818;
	bh=/AzM7p18opdrIRbQiJ7D1n4Cz94lVxIsTHGwVc/LYY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bctg9cIq0eRdtKQNdQWMtNWAu3WDjSWIs/TtvZIRuKuIOOCbFHLCuNjyH8Dy2oLYl
	 a9F0sMEQ1wj/t4fhZZwESkBmHj4AanyZnEbZEyuoCiR0BClBcvqhXMNUcRt/tUi11z
	 h2ztlaNXeyyhMB/YusOn3LhFTgJ/HtdipcPM+evA=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260417104658epcas5p3f24729feff0e9b8e24512c70182dbace~nHyQhq_rX2126821268epcas5p3B;
	Fri, 17 Apr 2026 10:46:58 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.86]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fxs5F0MqJz6B9m5; Fri, 17 Apr
	2026 10:46:57 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260417104656epcas5p1d1b8733d39ab67f94114159c03ad41a0~nHyPMaw9l1400214002epcas5p1u;
	Fri, 17 Apr 2026 10:46:56 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260417104654epsmtip2a8d99659d3a44407c3d070e0caf7cc46~nHyNY8MHv3196031960epsmtip2G;
	Fri, 17 Apr 2026 10:46:54 +0000 (GMT)
Date: Fri, 17 Apr 2026 16:12:16 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	kmodukuri@nvidia.com
Subject: Re: [PATCH V3 3/3] nvme-multipath: enable PCI P2PDMA for multipath
 devices
Message-ID: <20260417104216.3tdvmfq43uok2ulu@green245.gost>
MIME-Version: 1.0
In-Reply-To: <20260416212633.72650-4-kch@nvidia.com>
X-CMS-MailID: 20260417104656epcas5p1d1b8733d39ab67f94114159c03ad41a0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----njBzzhCGtS-aHlIth.2Pj0w1Th4tsb8PwJn50ZNtPKFt4kYn=_21b21_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260417104656epcas5p1d1b8733d39ab67f94114159c03ad41a0
References: <20260416212633.72650-1-kch@nvidia.com>
	<20260416212633.72650-4-kch@nvidia.com>
	<CGME20260417104656epcas5p1d1b8733d39ab67f94114159c03ad41a0@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_034707_250042_A03EFE2D 
X-CRM114-Status: GOOD (  10.17  )
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

------njBzzhCGtS-aHlIth.2Pj0w1Th4tsb8PwJn50ZNtPKFt4kYn=_21b21_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 16/04/26 02:26PM, Chaitanya Kulkarni wrote:
>From: Kiran Kumar Modukuri <kmodukuri@nvidia.com>
>
>NVMe multipath does not expose BLK_FEAT_PCI_P2PDMA on the head disk
>even when all underlying controllers support it.
>
>Set BLK_FEAT_PCI_P2PDMA unconditionally in nvme_mpath_alloc_disk()
>alongside the other features.  nvme_update_ns_info_block() already
>calls queue_limits_stack_bdev() to stack each path's limits onto the
>head disk, which routes through blk_stack_limits().  The core now
>clears BLK_FEAT_PCI_P2PDMA automatically if any path (e.g., FC) does
>not support it, consistent with how BLK_FEAT_NOWAIT and BLK_FEAT_POLL
>are handled.
>
>Signed-off-by: Kiran Kumar Modukuri <kmodukuri@nvidia.com>
>Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>---
> drivers/nvme/host/multipath.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>index ba00f0b72b85..957e39c4795d 100644
>--- a/drivers/nvme/host/multipath.c
>+++ b/drivers/nvme/host/multipath.c
>@@ -734,7 +734,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
> 	blk_set_stacking_limits(&lim);
> 	lim.dma_alignment = 3;
> 	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
>-		BLK_FEAT_POLL | BLK_FEAT_ATOMIC_WRITES;
>+		BLK_FEAT_POLL | BLK_FEAT_ATOMIC_WRITES | BLK_FEAT_PCI_P2PDMA;
> 	if (head->ids.csi == NVME_CSI_ZNS)
> 		lim.features |= BLK_FEAT_ZONED;

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------njBzzhCGtS-aHlIth.2Pj0w1Th4tsb8PwJn50ZNtPKFt4kYn=_21b21_
Content-Type: text/plain; charset="utf-8"


------njBzzhCGtS-aHlIth.2Pj0w1Th4tsb8PwJn50ZNtPKFt4kYn=_21b21_--

