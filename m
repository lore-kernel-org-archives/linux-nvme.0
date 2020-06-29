Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A63EC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:40:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7080D20672
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qoAP6IqH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ge8U7tfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7080D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3er5K+lCfKHgVV3Rm4JyBbBXKL4Rf5PHT0ovY4EOXKs=; b=qoAP6IqHSE6SGYXs0RQTCnq4n
	x+4YJsrxr+FxI3q9YkdOr5poKG4LbjQDCdO0UKwvoIVrL6QaarTJJTHS7n7pB+7EsV++yeCjVAGkH
	BCff5pK/Eq7wlSDB+6dgY4MfWRSlfQTJ/uIIXhdTbHcaYZoV3Lo8ICmpbCj+9zFpjJHIOUBcZ3ObP
	Lsik0U/Kno0Eft76avtcCj2byEj2x2RMncl25eEP/Nh3H0/ai+jWFnae68cdYU9GqZlZQSKlL4XdX
	+b9PtEOEtWiX3HxZ0cjR0xrgDsmJ1eOwx86sgCnfTyDTTavvePddpmfk9baqaUzbdS6QtD2byAGmE
	/+cy/57tA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpzdN-0003xV-7h; Mon, 29 Jun 2020 19:40:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpzdD-0003uI-DG
 for linux-nvme@merlin.infradead.org; Mon, 29 Jun 2020 19:39:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=mXzFKc+c1347jb3Dn9ppL+M5YgGcOuGfnfqDijAsZ3Y=; b=Ge8U7tfkj6TJq59wba22lmgv3c
 aAemZb5IgwaUNQOae1JEUBdtcswQzq0bY+RkjL+cTiX7JQaRw0wKApdyej6KuRrwQcPRWgxraeMMA
 TRAiHmd4zKY6MICuQtRpDg7hYKpnFjf/7DtIwALc7xQoNLa9rD29+80j1LO021MhBvPwrXo28MZ1f
 ZI3vQ/ibrnOyTsGvTDFTwfsRSh+F2rdsCBmlwhrLDzZmWqXRXzrWeZZDt82bL0P7uOtvcTvpY3l6s
 9SSEQXyks5o5YtnDn26Su7A+VbDq23m/m3Y7zWk8dcBd8mM3rtP2IpU7gNAZDnqWBedx63nIA1Il2
 GyzjCyLQ==;
Received: from [2001:4bb8:184:76e3:fcca:c8dc:a4bf:12fa] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpzdB-0004Ez-KW; Mon, 29 Jun 2020 19:39:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/20] simdisk: stop using ->queuedata
Date: Mon, 29 Jun 2020 21:39:29 +0200
Message-Id: <20200629193947.2705954-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
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
 arch/xtensa/platforms/iss/simdisk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 49322b66cda931..31b5020077a059 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -103,7 +103,7 @@ static void simdisk_transfer(struct simdisk *dev, unsigned long sector,
 
 static blk_qc_t simdisk_make_request(struct request_queue *q, struct bio *bio)
 {
-	struct simdisk *dev = q->queuedata;
+	struct simdisk *dev = bio->bi_disk->private_data;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	sector_t sector = bio->bi_iter.bi_sector;
@@ -273,8 +273,6 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 		goto out_alloc_queue;
 	}
 
-	dev->queue->queuedata = dev;
-
 	dev->gd = alloc_disk(SIMDISK_MINORS);
 	if (dev->gd == NULL) {
 		pr_err("alloc_disk failed\n");
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
