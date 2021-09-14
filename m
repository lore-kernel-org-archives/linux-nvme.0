Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5467C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:11:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC9F61164
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7CC9F61164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sCqR1tP6EY+5z3WV6zvpYjSSgYLJPXscjBszp2xD2O8=; b=NPkUhPwwuslfbL
	DRk8V3apZreuEXyEVl1MRRLC/2qc422Jok3BCqEYZf39UPrOB9jJj4+lSXHm+jKWp0/YqwUmqqoil
	7IdSyZ9ServhpYVur9p7P7OqE6h+Ovo5aTZccagzSU2bISgVcM8lvY6EDYKnkx6av695LnSpmHj4R
	V4ksx+CkzZCbXlx6axw99J0xx+KtbgAsEtjDV/S/yvYKdAzM7ct0nZOzpzoKhgcNypDBVDDUUOacb
	F9dCy9O+FfqMVhzI9dJeJs53DUgH5JKX5dXjXBDdBfuV/qYoJtZrSeaNiaGEUsYqOsjZUdeQgbBkP
	vT9FbMtd66kpb29FTqDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ2ab-004OZG-Ct; Tue, 14 Sep 2021 07:10:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2aa-004OYr-B7
 for linux-nvme@bombadil.infradead.org; Tue, 14 Sep 2021 07:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=AzL4+XF2Digv1HL+rJARVaK5sLuH/C/MZkJ5+CGwmbg=; b=o67CinCtb/+reCqvp/wJj/5xpj
 MsLN8+SI7FpsSM4paxccZ0oSkbo5K8pRXUxkQRv4rMSRPuhpQa8dA7VNRo488JNUZcZtyk0ivMiCo
 NQqYLT1pfe/jTVE9CBHrAslNmpXmgAs0VDfwr3C1DPPVTjCBQ1Na5LMXRN36khSexlvPQj9Q2AAH3
 jGKIJHnRekv3QqTr2S2Rlzn15n2yFcTWXYsnvW8jtdIGwSzfX4u6VeS4kVyUd9/3D3J4rtvOlz4nf
 kaUmwQQ5Hoxf7d33XqO8/qE7NshejNM2Iu78+Ge1nnzK1TmKw1n6GLodv3gGm/fzi0Acxrj0bBYmT
 IiEvdmgQ==;
Received: from [2001:4bb8:184:72db:7baf:b601:6734:7149] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2Z7-00EMt4-3w; Tue, 14 Sep 2021 07:09:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	martin.petersen@oracle.com
Cc: Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] block: flush the integrity workqueue in
 blk_integrity_unregister
Date: Tue, 14 Sep 2021 09:06:56 +0200
Message-Id: <20210914070657.87677-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914070657.87677-1-hch@lst.de>
References: <20210914070657.87677-1-hch@lst.de>
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

From: Lihong Kou <koulihong@huawei.com>

When the integrity profile is unregistered there can still be integrity
reads queued up which could see a NULL verify_fn as shown by the race
window below:

CPU0                                    CPU1
  process_one_work                      nvme_validate_ns
    bio_integrity_verify_fn                nvme_update_ns_info
	                                     nvme_update_disk_info
	                                       blk_integrity_unregister
                                               ---set queue->integrity as 0
	bio_integrity_process
	--access bi->profile->verify_fn(bi is a pointer of queue->integity)

Before calling blk_integrity_unregister in nvme_update_disk_info, we must
make sure that there is no work item in the kintegrityd_wq. Just call
blk_flush_integrity to flush the work queue so the bug can be resolved.

Signed-off-by: Lihong Kou <koulihong@huawei.com>
[hch: split up and shortened the changelog]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-integrity.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 48bfb53aa8571..16d5d5338392a 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -430,6 +430,9 @@ void blk_integrity_unregister(struct gendisk *disk)
 
 	if (!bi->profile)
 		return;
+
+	/* ensure all bios are off the integrity workqueue */
+	blk_flush_integrity();
 	blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	memset(bi, 0, sizeof(*bi));
 }
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
