Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D7AC4727F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D9A21531
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F8Ksi2OO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="laKMVB2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D9A21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XodIAlbSH2xnPPY4cllmOdFC269HNfhGLIaGqA4O23Y=; b=F8Ksi2OOTpel7KnQpdNp633xB
	N57XbE9e2HC25euqAzDLnTeuy5JQrYSXijNs3eNprsa+QkmLzLdQTuBEO8DadKRJ9GbOTD7gobGG9
	CsDZfNj+zJ3bULyinlVdjVmjIgBnDETBKQ4tvBbU1ZDd0s3iKDUvqQSl8ruTzC9IiXit1taTSxFJj
	o5H8Qdqp9DDDEyaEUBwEdz2CothgxjgSSO30PDuHe4hWoY2szof0iXYkkeF284ueGK4IJdHfIcgxQ
	bkS7ktSAXHAS+UmquRXg/IkmW13X4xleECcHnSH3/9Uq7v4FI+NHh7JAljFJ/GRP+GaVdSgHllkrC
	RiZo8qSzA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsNb-0002YV-Dh; Mon, 28 Sep 2020 12:35:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNE-0002O4-Ms
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=EpEep95tKSO1dG/GLLlrNUOjKYbhaQEWTMttHVmAxAI=; b=laKMVB2kpFy+b6RAwzroNJ5Z+b
 LZpRlTxu/H5STCFqqpalHJbO6uYs5Crij96s1yxkqnskkZFsMQ/EmpiKVrxwWaZsR1vXrtAgSELaj
 Y2dnJzWxfZU27+cPI+A1oqMQ+MKq4AU970qVQKuiUFppltkKuKehmGLwvKl2nAj5wi05ZxC/nESaB
 DbUEyhr4KnKYdhbpaai21SXX8Tjjc/g8YUy/2llHw+0neelklIdJa5IlJ9qIo2bDdNRKSZZTDgLUz
 jAj55E/o2NHPn2W1JXj/Wmt/1123hnbzliR5F0tTfUwz+dvF37zOTjHNO6nwezIZ7ep0BoXogvX8+
 XU/oJbJQ==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsND-0004lB-Fc; Mon, 28 Sep 2020 12:35:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 11/20] nvme: clean up the check for too large logic block sizes
Date: Mon, 28 Sep 2020 14:34:53 +0200
Message-Id: <20200928123502.435373-12-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use a single statement to set both the capacity and fake block size
instead of two.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 82cd03c0ba21ba..0114fe47de3571 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2017,8 +2017,12 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	unsigned short bs = 1 << ns->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
 
+	/*
+	 * The block layer can't support LBA sizes larger than the page size
+	 * yet, so catch this early and don't allow block I/O.
+	 */
 	if (ns->lba_shift > PAGE_SHIFT) {
-		/* unsupported block size, set capacity to 0 later */
+		capacity = 0;
 		bs = (1 << 9);
 	}
 
@@ -2055,13 +2059,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
-	/*
-	 * The block layer can't support LBA sizes larger than the page size
-	 * yet, so catch this early and don't allow block I/O.
-	 */
-	if (ns->lba_shift > PAGE_SHIFT)
-		capacity = 0;
-
 	/*
 	 * Register a metadata profile for PI, or the plain non-integrity NVMe
 	 * metadata masquerading as Type 0 if supported, otherwise reject block
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
