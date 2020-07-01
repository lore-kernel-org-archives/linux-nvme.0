Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F08C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 09:02:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2A3206C3
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 09:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uthc2o17";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qMNQ5x4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2A3206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qfRpEDEQjO19iA3lcAsLO5chrcnTh88OrvzhawlTHzQ=; b=uthc2o17kkQ3iz/mbiAMjj/z2
	pXzTy+1ACwy2dbS+ta+lHOStmGn1FEwaCpHW1L+n9De8Jgq1vZrZCcQXb935diEDAolMRBPGvZkmZ
	TZuxSF98Ay9LYL5THBxKN0wIpAjdz6pzuu2ASvcJZv3pnj5LV1Eho+zNJQ4DHQ/jih8ZxJ/JK3XV5
	MakFpZPvuE4tqyG2FdB2oHGJ1l1y3zFM2sa86FsyTcxxqp0iwZ6QGRb+bpG+nwXe5LdTlrIPfGuWu
	rRkHcmL8yKZrv0cd8fqLqqdZ69A3N4XExHU/V4CnQ8J9h+FCj59L8nJKXfNNedj9eQhHM96l6sl61
	ipTr5I3Cw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqYdT-0006J7-IC; Wed, 01 Jul 2020 09:02:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqYbL-00057R-Mx
 for linux-nvme@merlin.infradead.org; Wed, 01 Jul 2020 09:00:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=EAMIpv1ziuqNgf5ZNOHoxjY+dqzuD4FouWA6YFyHhkE=; b=qMNQ5x4RLz46SfC5VFJYmHu5Nx
 xI0sjPMkrZu4JzWH34erLzcJLJaVi42hoTRxgTqPpAaZ10BnqAfleFt5C4BDjFM7Jqls0VeMH/gqf
 JA3ksJqj7QKrohDk4U7Nu5sAUxcmERKiJBmNcC4cwjoQwwewNksjinjd1ESmGAyAqTxprSKh519+R
 qO3AP4glQ4JIPWzLlAmJTJ/p5U8MhH7mj4rvJOfk+i3Ndn0uebCLnEpXHTGMMoRlA6B0XeegOCH4b
 q01IOa4xLW4RLaoayu0NTlJoWxQpHxYHTgi94RpyBco2yaAblICORPz0jkVk33ytG9sq9oRItFIdp
 U2gEkKCg==;
Received: from [2001:4bb8:184:76e3:ea38:596b:3e9e:422a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqYbK-0008Hs-Cg; Wed, 01 Jul 2020 09:00:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/20] block: shortcut __submit_bio_noacct for blk-mq drivers
Date: Wed,  1 Jul 2020 10:59:46 +0200
Message-Id: <20200701085947.3354405-20-hch@lst.de>
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

For blk-mq drivers bios can only be inserted for the same queue.  So
bypass the complicated sorting logic in __submit_bio_noacct with
a blk-mq simpler submission helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 57b5dc00d44cb1..2ff166f0d24ee3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1152,6 +1152,34 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 	return ret;
 }
 
+static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
+{
+	struct gendisk *disk = bio->bi_disk;
+	struct bio_list bio_list;
+	blk_qc_t ret = BLK_QC_T_NONE;
+
+	bio_list_init(&bio_list);
+	current->bio_list = &bio_list;
+
+	do {
+		WARN_ON_ONCE(bio->bi_disk != disk);
+
+		if (unlikely(bio_queue_enter(bio) != 0))
+			continue;
+
+		if (!blk_crypto_bio_prep(&bio)) {
+			blk_queue_exit(disk->queue);
+			ret = BLK_QC_T_NONE;
+			continue;
+		}
+
+		ret = blk_mq_submit_bio(bio);
+	} while ((bio = bio_list_pop(&bio_list)));
+
+	current->bio_list = NULL;
+	return ret;
+}
+
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -1177,6 +1205,8 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
+	if (!bio->bi_disk->fops->submit_bio)
+		return __submit_bio_noacct_mq(bio);
 	return __submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio_noacct);
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
