Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64803C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 09:01:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392FA206C3
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 09:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MgI7ZDUo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pGlUJrbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392FA206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Sa1l40bPFAgqbcuyBjeogvs4YcR79MG5VeKHcmb5oT0=; b=MgI7ZDUoOztEWxv1xDij97luV
	SWtgVpSYQNyz1FFbDBlx7psIbRb/8kfVsw7bkVRG6y+olsWruJ2TeQUGHDXivq7sJ5qwS1mB9P1Ua
	S2YTryvaeBA2OZSc1YFD9sHe0s7ABNfqiuKhwNqCc/yHHUem+GQHf4NvPXwFjaEjaoSC1LbonER6I
	QeCsGW+CuOCcmzfYAVIQD5PMKvc0HGopsPaF9A4ii+rl2LfZD245L56K06kLrMYK3TOLPzFe8g1Md
	pPn3NSMgzcCkGYlyvaUdLB9gzj1hkJ/tPvWLRntvloQc1gM+CH7DiaDO66o0sS2HlPZ3tc0MHJwj1
	qFHfGVEUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqYcL-0005gC-JC; Wed, 01 Jul 2020 09:01:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqYbD-000520-9R
 for linux-nvme@merlin.infradead.org; Wed, 01 Jul 2020 09:00:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=llOojDD3lqJfk9XWeWL9pqlJf45UocCmu2uEUE0dVqA=; b=pGlUJrbOxh0JwXeTwQoJpYf2F/
 Wj1CCsNV+D84p9IQoC65j7VZnlNqsrYsLYThDSTFAmKMsEUR9St/lgE0ZmSPIQQCuP7dgvSl2ZuCN
 qmHjB/58qr1vtBaiVphQaEP9vrD2GonVUZUsFfMDwdCYWZmTuiqkDgguyEU9GJPldWF1NUiFWd5Tm
 PuuqBh6fEuRMCrVHN8SIXYmkZ8bhrPxFnV6RVSwro1PKig0pS+Kd1OL4Q1S+1+uAY1tH2+UawdfXw
 RbbQhCUERQ3oGJvZGCbwR4bKQ7UF6Akd/eN6H9X2jHLGH0eeFYrqjDeKzOU7MKgBYWr9GW+QGURtd
 0nPrWjmA==;
Received: from [2001:4bb8:184:76e3:ea38:596b:3e9e:422a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqYbC-0008Ex-2b; Wed, 01 Jul 2020 09:00:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/20] block: remove the NULL queue check in
 generic_make_request_checks
Date: Wed,  1 Jul 2020 10:59:41 +0200
Message-Id: <20200701085947.3354405-15-hch@lst.de>
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

All registers disks must have a valid queue pointer, so don't bother to
log a warning for that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 95dca74534ff73..37435d0d433564 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -973,22 +973,12 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 static noinline_for_stack bool
 generic_make_request_checks(struct bio *bio)
 {
-	struct request_queue *q;
+	struct request_queue *q = bio->bi_disk->queue;
 	int nr_sectors = bio_sectors(bio);
 	blk_status_t status = BLK_STS_IOERR;
-	char b[BDEVNAME_SIZE];
 
 	might_sleep();
 
-	q = bio->bi_disk->queue;
-	if (unlikely(!q)) {
-		printk(KERN_ERR
-		       "generic_make_request: Trying to access "
-			"nonexistent block-device %s (%Lu)\n",
-			bio_devname(bio, b), (long long)bio->bi_iter.bi_sector);
-		goto end_io;
-	}
-
 	/*
 	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
 	 * if queue is not a request based queue.
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
