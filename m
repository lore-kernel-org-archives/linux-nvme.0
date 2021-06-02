Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB52C47083
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 15:20:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B769861246
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 15:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B769861246
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Xusj0U+snp1WBUYHQShXYdbXh611Lc4llV+uyo55L0w=; b=gO1Eein2Z9KizH
	HhAKM/u3dP5NzP20jWQ3h4aHjAu2rQAUZ1zWUqbbQSy/G8jc5FLhssKZpQwKf9ZEmJx9eBYPippUc
	e6bb5V1xGtp3TWSK5W3Co/tbDUQuMbSze6i8vAaaTHOgEM9eLqeoIl2gcW3iesg/BYjZ1u5ljfctS
	dq8+jQ5BeHRv1O4IzvyWW6vjbVg7DZwGJdyc3dNkQ7KIyBz/GLfTh2Qk00gAMSwrtaLseqLch+CyX
	130dk96QBOmmQvXH0PatK8YL+UammpkGI8qEFLwgRKgLD0JqrT6Ox3A8kUkcx0dBk69hBZ+u7hTfE
	iNedLkD6IFgCrmEaunmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loSfM-004p4U-93; Wed, 02 Jun 2021 15:20:20 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loSfG-004oAq-GV
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 15:20:18 +0000
Received: from relay2.suse.de (unknown [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0248B21AB2;
 Wed,  2 Jun 2021 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622647088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=abiDawFaADWTZKPBaHNA1Cn487UEzBujiumXV31Y0hY=;
 b=FgGMWr2rx5+tyKHIGvzvQcdXnafUfufwEilebO4BNPEnTDcvJN9IIsSMtyj3keMFwvdTHW
 vYLpEBDPg4fOMUAnMgd4D0zeqAUlcPk3QYfmpVEaa4dMPgdbJIaR2Tx+20zUgn3yPzZB5Q
 2UJ+67kFfIEDv8cHsG/NL6AxVDPwb7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622647088;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=abiDawFaADWTZKPBaHNA1Cn487UEzBujiumXV31Y0hY=;
 b=YqGPT4aMSZHc/Vk9k0tj5XBjN+v//Dxr3CdRdONjdWvPhnWHqPesQY8IZmDFGcejFPcNNN
 3o9r+Y3RafUrp4Cg==
Received: by relay2.suse.de (Postfix, from userid 51)
 id F33C0A3CB8; Wed,  2 Jun 2021 15:23:43 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id D57FBA703B;
 Wed,  2 Jun 2021 13:00:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id C89DA516FB04; Wed,  2 Jun 2021 15:00:42 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] nvme: reset disk to the mpath node also when requeuing
Date: Wed,  2 Jun 2021 15:00:39 +0200
Message-Id: <20210602130039.122879-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_082014_718337_2F2673F2 
X-CRM114-Status: GOOD (  14.37  )
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

Commit ce86dad222e9 ("nvme-multipath: reset bdev to ns head when
failover") moved the reset code where the bio is added to the
requeue_list for the failover path. But it left the original
bio_set_dev() in nvme_requeue_work().

Let's move the bio_set_dev() where we add the bio to the requeue_list
and avoid the double setting in case of the failover path. And this
makes the code more consistent.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

v2: loop over all bios and reset them

 drivers/nvme/host/multipath.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 127a17b4c13d..3334c6f23476 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -302,6 +302,7 @@ static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
 	struct device *dev = disk_to_dev(head->disk);
 	struct nvme_ns *ns;
+	struct bio *b;
 	blk_qc_t ret = BLK_QC_T_NONE;
 	int srcu_idx;
 
@@ -324,6 +325,8 @@ static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
 
 		spin_lock_irq(&head->requeue_lock);
+		for (b = bio; b; b = b->bi_next)
+			bio_set_dev(b, head->disk->part0);
 		bio_list_add(&head->requeue_list, bio);
 		spin_unlock_irq(&head->requeue_lock);
 	} else {
@@ -435,11 +438,6 @@ static void nvme_requeue_work(struct work_struct *work)
 		next = bio->bi_next;
 		bio->bi_next = NULL;
 
-		/*
-		 * Reset disk to the mpath node and resubmit to select a new
-		 * path.
-		 */
-		bio_set_dev(bio, head->disk->part0);
 		submit_bio_noacct(bio);
 	}
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
