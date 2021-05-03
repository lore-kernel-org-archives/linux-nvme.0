Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD0FC433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 12:59:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA4A60D07
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 12:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA4A60D07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PhyX8l7cQIOjmuld3mNcQXK6KbkWicV8t2B9Syk74hg=; b=k/feXW1Vjya+3xYrRsZeDtvSfN
	NdTGY6lK0bw8IPSahEN0XGWV0PMz0wPA+aMNOPvarJx4IqtjY30yfHMzOzuG9n3sv3rSA2rrlgMIR
	J+qoeC2ft+7+2qtRwvAei7GOJ0rXM9qs4pl6lzgsgAP5iNzGtuSBMN/PNa/CKul+ZGk74abv8yruK
	EbZeHLl7uUp3cDcQEAhnnmT1iVaH2+lTPKraTCFbtC9JTbD5P3taxbGbDYCCkwsfxp4N+mroXqgRA
	siautzsHoFCrljZrNfCkH9Q+sZ0RZ/BqrGBBxNhkVfHJwLSroBrSz1xLNKz1Eeh8sTVgBCSmfNmRk
	B3a02Rcw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldY9S-00Dugy-9K; Mon, 03 May 2021 12:58:18 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldY91-00Duf6-BG
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 12:58:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=OYCeAO0sMXDZDTjMjIXIAYqt/mYeDyYR+eRpRHRCWxQ=; b=qGQNB3YoLb9fHc/nOQzK1JaaUf
 SrXPCZwLB4mLxN1Fq+TVBX/U8jGlmxIWYifK87uh9yx1sH4t6EUW5W2wJMscLI+KsRlbQBsJqkIAB
 QD43ylFVFX7eZqlOM2KkL5ID83CcpQGOtHnDxWGdbrEMSvsaHj/g/Izcg7n6c3mK4We9tGTw3wBju
 O5srnWqsMTuNDmgB/jOHrj0rpnUD3Ys5VW3vFKvg/46frzzYKz0FbotmRCwT9tVQcFoPAbRsllGIh
 KdOR2b6QPUmPRXLIDGYc4xa/5usFOoajCG9blwcStKj5yURd1PV6fbZXXGkIXknQGXv3BgaDB7gP+
 RjBvZaZw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldY8y-0034dm-Kj
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 12:57:50 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BBFD5AC38;
 Mon,  3 May 2021 12:57:45 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme-multipath: Reset bi_disk to ns head when failover
Date: Mon,  3 May 2021 14:57:41 +0200
Message-Id: <20210503125741.68117-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_055748_841503_F9B3C1AF 
X-CRM114-Status: GOOD (  10.75  )
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

The path can be stale when we failover. If we don't reset the bdev to
the ns head and the I/O finally completes in end_io() it will triggers
a crash. By resetting the to ns head disk so that the submit path can
map the request to an active path.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

The patch is against nvme-5.13.

[ 6552.155244] Call Trace:
[ 6552.155251]  bio_endio+0x74/0x120
[ 6552.155260]  nvme_ns_head_submit_bio+0x36f/0x3e0 [nvme_core]
[ 6552.155266]  ? __switch_to_asm+0x34/0x70
[ 6552.155269]  ? __switch_to_asm+0x40/0x70
[ 6552.155271]  submit_bio_noacct+0x175/0x490
[ 6552.155274]  ? __switch_to_asm+0x34/0x70
[ 6552.155277]  ? __switch_to_asm+0x34/0x70
[ 6552.155284]  ? nvme_requeue_work+0x5a/0x70 [nvme_core]
[ 6552.155290]  nvme_requeue_work+0x5a/0x70 [nvme_core]
[ 6552.155296]  process_one_work+0x1f4/0x3e0
[ 6552.155299]  worker_thread+0x2d/0x3e0
[ 6552.155302]  ? process_one_work+0x3e0/0x3e0
[ 6552.155305]  kthread+0x10d/0x130
[ 6552.155307]  ? kthread_park+0xa0/0xa0
[ 6552.155311]  ret_from_fork+0x35/0x40

 drivers/nvme/host/multipath.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0d0de3433f37..0faf267faa58 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -69,7 +69,9 @@ void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status & 0x7ff;
+	struct block_device *bdev;
 	unsigned long flags;
+	struct bio *bio;
 
 	nvme_mpath_clear_current_path(ns);
 
@@ -83,9 +85,13 @@ void nvme_failover_req(struct request *req)
 		queue_work(nvme_wq, &ns->ctrl->ana_work);
 	}
 
+	bdev = bdget_disk(ns->head->disk, 0);
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
+	for (bio = req->bio; bio; bio = bio->bi_next)
+		bio_set_dev(bio, bdev);
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
+	bdput(bdev);
 
 	blk_mq_end_request(req, 0);
 	kblockd_schedule_work(&ns->head->requeue_work);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
