Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECFEC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 08:59:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E1020775
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 08:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MzKsbMiT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cG9uWeax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E1020775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Tt7Z4JfC0Jrcaw8n3+onANjXb4EiQTR6Uxx/zG/0AtI=; b=MzKsbMiT1e15/qBSLxPy9L+I8
	UR8fs76/RiRtNoymPv3poTFsx2usN7NKDXnTGnAmWaIW6ysaRjZMM7KA1fMpY5uv2XBYXReIuClJr
	uNJK8UprsaOd+PsuSKSMH30+cdmYllQzCx/LMjbB1vHSuKWEMHaXIP3RV1gCDfpRU4edt/flfKbhZ
	gUn4+NmJGDJ3lRtWyVS1WLDG8mJTYL2nwKzI2/4pCmEkrEJmTGzjB0PXWpxxdbl08mCnhXdfAqfR5
	cMk6vVZCZUhEZbJDcS3UV2taXm4xskuDJMchr6z6IatNmHmVJ15IbJ/+62KRihr/vJwz/yXYiv/1g
	ASsQrZJng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqYaz-0004uz-Kx; Wed, 01 Jul 2020 08:59:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqYaw-0004tX-IB
 for linux-nvme@merlin.infradead.org; Wed, 01 Jul 2020 08:59:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=nyRpegl2g2GPLIzpDQmlwzdY5HJ2Dd3E7fu8tgbKXsw=; b=cG9uWeaxaNO/1MVPIWmhvQXLAG
 iSkoMG+mDqCp5Fas05hxeEwDFJzbgUVjvM+qHyRdAModBVUY6niFiW0rnnavhFRNyz1pykeOhxkhZ
 NZVGVYHrmpq04hvVgiUtI5yX1wM+7igRvEMydnCoRQeuacqPuZqBQw3s5pqynfJWw1cXYywN0/bxi
 7SwIJoZIPt4nm/r/GiOvJKRN2dJAAkG6ZSJj5j6m8j6Tra0NHETrtGEustOMES2x9BE2MEDdvPFxf
 /+IEWPO5yHD5avrdkfbZhwAa30i/liOzJ70LhshoWEaD5sgYOPmU7O855Wq//djMSdTtULqhfhiaU
 2SXkVv7Q==;
Received: from [2001:4bb8:184:76e3:ea38:596b:3e9e:422a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqYav-00087h-DT; Wed, 01 Jul 2020 08:59:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/20] drbd: stop using ->queuedata
Date: Wed,  1 Jul 2020 10:59:30 +0200
Message-Id: <20200701085947.3354405-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701085947.3354405-1-hch@lst.de>
References: <20200701085947.3354405-1-hch@lst.de>
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
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Instead of setting up the queuedata as well just use one private data
field.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_main.c | 1 -
 drivers/block/drbd/drbd_req.c  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 45fbd526c453bc..26f4e0aa7393b4 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2805,7 +2805,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	if (!q)
 		goto out_no_q;
 	device->rq_queue = q;
-	q->queuedata   = device;
 
 	disk = alloc_disk(1);
 	if (!disk)
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index c80a2f1c3c2a73..3f09b2ab977822 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1595,7 +1595,7 @@ void do_submit(struct work_struct *ws)
 
 blk_qc_t drbd_make_request(struct request_queue *q, struct bio *bio)
 {
-	struct drbd_device *device = (struct drbd_device *) q->queuedata;
+	struct drbd_device *device = bio->bi_disk->private_data;
 	unsigned long start_jif;
 
 	blk_queue_split(q, &bio);
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
