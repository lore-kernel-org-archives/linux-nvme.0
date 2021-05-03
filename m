Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA19CC433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:03:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85073610A5
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85073610A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zUldvYxWxPwk1cVbeaHHmQb8vfyCiHq/lUlctfTHd9A=; b=WKqCXFVI0hMfGB9qAoNsceBoSz
	Zrm2BRebgfFHkekwCQEIjBs4CV5fKa4/eMxWWzTo2ajVAtH92AMiMjaETvtT9+KHf77SgM7exoWHT
	h+r2kQWatuRtu1vhHz5jvSUndP7Z9etN/Pwy+179ay2XuojGV8cwHhQXzggV5gNAoFNSTFwfWdIk1
	JDqR0+CRKTVTGfuOw5Z/1DjD/IVFxtu+LSXhkDK3ZEkJw9CEF+TFM7Q0q3Nrn1UhE19GXZ3ZgiC7M
	Tcl6NwqqqZKEmgX2z1MCQVClFeyWazLlx5pZQX9D6cV3QR2pI+KDgKbOvIBuIy8Pg49IF8Ws0GDfV
	6u55lflQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldbyR-00ETOw-Gr; Mon, 03 May 2021 17:03:11 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldbyO-00ETOl-D6
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 17:03:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=wnKp63tMxv5NCa394nlfchrvfj4rACvyYUkDqFZYGhE=; b=Q7TkO4s6cMuRDujDXTwGlbnqGJ
 gq+f4MyGCliScu1LrdHbCEUaTf34pGtq0I48XPGrEkab3nf5TbAK03anZIneHBDAehs3+7TE0fn+a
 ePtHwieSee6cKze7POv/jpq4QaT7jpdKuCS3PqDwekZeXv1p+5Q2+cZd06F7tXxZUA4gK6rJ+swV/
 YLZq4B6QMDwL9tA1eHAam1bpVWdluMxl4XWmoLPfhUD/9YELt8DuQkgdjLM519wzyiDmx0B+XgNZ5
 UJoW1G3i5tbRtH1h4jtctkNur9O0cM2KLHEKarYXNyNLvEyLPH4PCV8+KbudLkgJrJRuhzXmjMvzy
 w6Z3P5fQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldbyL-003Joj-PP
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 17:03:07 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 66064AF0F;
 Mon,  3 May 2021 17:03:04 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] nvme-multipath: Reset bdev to ns head when failover
Date: Mon,  3 May 2021 19:03:03 +0200
Message-Id: <20210503170303.10443-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_100305_991553_6CAE3A6D 
X-CRM114-Status: GOOD (  11.16  )
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

When a request finally completes in end_io() after it has failed over,
the bdev pointer can be stale and thus the system can crash. Set the
bdev back to ns head, so the request is map to an active path when
resubmitted.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v2:
 - commit header fix s/bi_disk/bdev/
 - new commit message (hopefully it's better English this time.)
 - dropped bdget_disk, use >disk->part0 directly as
   suggested by hch

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


 drivers/nvme/host/multipath.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0d0de3433f37..0551796517e6 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -70,6 +70,7 @@ void nvme_failover_req(struct request *req)
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status & 0x7ff;
 	unsigned long flags;
+	struct bio *bio;
 
 	nvme_mpath_clear_current_path(ns);
 
@@ -84,6 +85,8 @@ void nvme_failover_req(struct request *req)
 	}
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
+	for (bio = req->bio; bio; bio = bio->bi_next)
+		bio_set_dev(bio, ns->head->disk->part0);
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
