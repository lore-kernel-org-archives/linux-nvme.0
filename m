Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3099E77199
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 05:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fuOazopibpAs20wub1IJXrvMuywQGVOpmNTUuhx/xHA=; b=sAuExGvchmyR4n6qU7HIfyG+mB
	vsX2JGpH8eKuES/AEQmS7e6tHUIQECojibZnFhH9ZFnLLn76D/WipMxSC3hlrza6p+CsgBJ/jTNoJ
	SNjPymVjxEkG1zXsFPuvs1IWooDgyg//gm577dXzoV7KUj1Due6I25Zb6WHoNNOwBZnR39VcAbu4R
	gKa6g81P6F/05Mm2KZSUzmjZaG6INfMiEun+UVJrb8WIz2Ct4mZds7wJ0kEjg1qXT3hZMMPSck/59
	7HQ2naK1S4zJueURH9F8+MXeJrZlSv+O8Ak8REnwJ1lCA9tgSAwW6bCJXPk9mx4NQQmLv8uGv7YLV
	HisUBCHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVlZ8-0000000ArZs-0NjE;
	Thu, 09 Jan 2025 05:58:46 +0000
Received: from 2a02-8389-2341-5b80-ddeb-cdec-70b9-e2f0.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ddeb:cdec:70b9:e2f0] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVlZ5-0000000ArV0-3Gjh;
	Thu, 09 Jan 2025 05:58:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nbd@other.debian.org,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 08/11] nbd: fix queue freeze vs limits lock order
Date: Thu,  9 Jan 2025 06:57:29 +0100
Message-ID: <20250109055810.1402918-9-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250109055810.1402918-1-hch@lst.de>
References: <20250109055810.1402918-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Match the locking order used by the core block code by only freezing
the queue after taking the limits lock using the
queue_limits_commit_update_frozen helper.

This also allows removes the need for the separate __nbd_set_size helper,
so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/nbd.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 259bd57fc529..efa05c3c06bf 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -327,8 +327,7 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 	nsock->sent = 0;
 }
 
-static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
-		loff_t blksize)
+static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
 {
 	struct queue_limits lim;
 	int error;
@@ -368,7 +367,7 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 
 	lim.logical_block_size = blksize;
 	lim.physical_block_size = blksize;
-	error = queue_limits_commit_update(nbd->disk->queue, &lim);
+	error = queue_limits_commit_update_frozen(nbd->disk->queue, &lim);
 	if (error)
 		return error;
 
@@ -379,18 +378,6 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 	return 0;
 }
 
-static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
-		loff_t blksize)
-{
-	int error;
-
-	blk_mq_freeze_queue(nbd->disk->queue);
-	error = __nbd_set_size(nbd, bytesize, blksize);
-	blk_mq_unfreeze_queue(nbd->disk->queue);
-
-	return error;
-}
-
 static void nbd_complete_rq(struct request *req)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
-- 
2.45.2


