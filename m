Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F844C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:47:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189B760C41
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 189B760C41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xdvEHrFwvckEacs6SIyRnGs9A3e0xqoOXiOBpmrPskY=; b=ftNNVpNxhzMT8N
	7/AXDwgJHr0sBO7gUS+RvgCllyf0Y4zi7SHoTNhnWFhCFIWUwKDCzR3BxTlGApio3acEecoO3pEqu
	qSQfLosqiKB3bU9gzAI5ijhntuBpEYV5mWXxwAv29lUVSFNARUZP3As51L2Mf1MleEIPz1WDx+Ym7
	EcZEYdW+BAtAMCkfuGzaDUdsWfCTqgSJtPElpcuRlRYSqRfjNEkhI7qtFp11tecF7v0oV4TH4Mv2+
	kagbHA2TOPU6y+QGi7j93oeM8YDiRaANeMFhxnr3mtjA6jAxiytkZXmL06Jf9GJbAY52jq7dJvg5T
	l6Xqqqp1T4eqNADhRD8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mCz4D-00HHr0-5W; Mon, 09 Aug 2021 06:47:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCz4A-00HHpp-T2
 for linux-nvme@bombadil.infradead.org; Mon, 09 Aug 2021 06:47:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=qYkQEi6HH6tvHJ3WGzG2rS1R73q8dommZSiqNjJoSCA=; b=jBSZvbu754g0AV8kqgcNftqE18
 KfQpQ+3bKWRniE3K6zSo59PHQbebitiho92LtSu27MAvSeWBj8hWoyBqERmS0ZTesLdds70wbG/4Y
 13r5QBsmjQNjnoyUB0SL/E53BtvGWEDw0rUjZzsZpBetSk4CTwLkP/CA76aCj+IG9UgdkxmamoV2C
 pGTxEC1Os4BZ5BzuSQfsTc7j9hNygWnhUYhjKXcW9/RIVMLa3FxvTFA2I3TucaM5VcpFfsTNGMjSn
 orrq6Nt9qDu+Y/u1isJfSC8PxioeBnjnFqchiB4LB93BmH+hZMBez9lBctaAd+M0imhX3I2DwYqzm
 kuhw/Xfw==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCz3A-00Aisv-0r; Mon, 09 Aug 2021 06:46:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH 6/8] bcache: add proper error unwinding in bcache_device_init
Date: Mon,  9 Aug 2021 08:40:26 +0200
Message-Id: <20210809064028.1198327-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809064028.1198327-1-hch@lst.de>
References: <20210809064028.1198327-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Except for the IDA none of the allocations in bcache_device_init is
unwound on error, fix that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/super.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 185246a0d855..d0f08e946453 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -931,20 +931,20 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 	n = BITS_TO_LONGS(d->nr_stripes) * sizeof(unsigned long);
 	d->full_dirty_stripes = kvzalloc(n, GFP_KERNEL);
 	if (!d->full_dirty_stripes)
-		return -ENOMEM;
+		goto out_free_stripe_sectors_dirty;
 
 	idx = ida_simple_get(&bcache_device_idx, 0,
 				BCACHE_DEVICE_IDX_MAX, GFP_KERNEL);
 	if (idx < 0)
-		return idx;
+		goto out_free_full_dirty_stripes;
 
 	if (bioset_init(&d->bio_split, 4, offsetof(struct bbio, bio),
 			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER))
-		goto err;
+		goto out_ida_remove;
 
 	d->disk = blk_alloc_disk(NUMA_NO_NODE);
 	if (!d->disk)
-		goto err;
+		goto out_bioset_exit;
 
 	set_capacity(d->disk, sectors);
 	snprintf(d->disk->disk_name, DISK_NAME_LEN, "bcache%i", idx);
@@ -987,8 +987,14 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 
 	return 0;
 
-err:
+out_bioset_exit:
+	bioset_exit(&d->bio_split);
+out_ida_remove:
 	ida_simple_remove(&bcache_device_idx, idx);
+out_free_full_dirty_stripes:
+	kvfree(d->full_dirty_stripes);
+out_free_stripe_sectors_dirty:
+	kvfree(d->stripe_sectors_dirty);
 	return -ENOMEM;
 
 }
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
