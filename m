Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECA0C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:40:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D413B20672
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HEDlDwaf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fZK4xo8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D413B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rIxtkqReScyfQwu1TODkcSJCm4bBmDiSSpKrS2S/z9c=; b=HEDlDwafAM6uczL2m9cya0tE6
	H9qXdN2ZAPupKTSyryuUdWGCvpme2w3wfRXX5VQkuJ/WhjD9WjJvJN7TYI65KHGtcOXP4njNRTFBT
	FJy9yoPSD10zFJvN4vvj3PpUstjTbLezibfbWLTGE4OLIGwn8v6z2BBMFD0EXeuNepjJqahWwfzuv
	qriOk+4OKcZnIy8rrEE95aQXIIOn3JjF2jLbfm11CET5ISSnfsARc79BJOQUchr19Qg4e8/YMDdLV
	yzBWl9CVHlY0XjVQw0Zm2fH8+mZGDn51EZDvR4WgFM2IfEIo7X5buT/Oaj2/TLgVnuHx+jwG4/oRL
	Wndo3+2Dg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpzdX-00041F-FM; Mon, 29 Jun 2020 19:40:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpzdK-0003wR-Dj
 for linux-nvme@merlin.infradead.org; Mon, 29 Jun 2020 19:40:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=8L8p6UbF45RVD9lwh+Y9njbbxbDNtEWDlp4D4BAc300=; b=fZK4xo8+3EiAVx4FIVtuNf4vAv
 zm4KGc7qiZkEK9LKiarRfAqvPpqWgTHtvE1QlHbQB0NZU32yOFMr/MNwB/ae5o6r8J1k0LS9KcWAk
 y7NYBsiVmRRcp2FQitQb40ThskDUPPDmDPYJLe8Pz2HzRaKfT30JREsrdWRxrkBie92FmSraPeTrJ
 5gSeTgEBrq4yvaPEIhmxj824T815wc+cDodRF3igQSRVwj8EWofccCOa9w/2vYmArzZqDITwIfqs4
 88J/ODZsBaLBKHJTA5Q+FqqqW0H41wxD+2jejtdQOMfQBGUmjLZbPCuBmTM01I2o9gUYysjfD3sm2
 QnEgqUIA==;
Received: from [2001:4bb8:184:76e3:fcca:c8dc:a4bf:12fa] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpzdI-0004Gf-PC; Mon, 29 Jun 2020 19:40:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/20] rsxx: stop using ->queuedata
Date: Mon, 29 Jun 2020 21:39:33 +0200
Message-Id: <20200629193947.2705954-7-hch@lst.de>
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
 drivers/block/rsxx/dev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index 3ba07ab30c84f5..6a4d8d26e32cbd 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -119,7 +119,7 @@ static void bio_dma_done_cb(struct rsxx_cardinfo *card,
 
 static blk_qc_t rsxx_make_request(struct request_queue *q, struct bio *bio)
 {
-	struct rsxx_cardinfo *card = q->queuedata;
+	struct rsxx_cardinfo *card = bio->bi_disk->private_data;
 	struct rsxx_bio_meta *bio_meta;
 	blk_status_t st = BLK_STS_IOERR;
 
@@ -267,8 +267,6 @@ int rsxx_setup_dev(struct rsxx_cardinfo *card)
 		card->queue->limits.discard_alignment   = RSXX_HW_BLK_SIZE;
 	}
 
-	card->queue->queuedata = card;
-
 	snprintf(card->gendisk->disk_name, sizeof(card->gendisk->disk_name),
 		 "rsxx%d", card->disk_id);
 	card->gendisk->major = card->major;
@@ -289,7 +287,6 @@ void rsxx_destroy_dev(struct rsxx_cardinfo *card)
 	card->gendisk = NULL;
 
 	blk_cleanup_queue(card->queue);
-	card->queue->queuedata = NULL;
 	unregister_blkdev(card->major, DRIVER_NAME);
 }
 
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
