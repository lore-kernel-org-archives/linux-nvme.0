Return-Path: <SRS0=BHMv=AO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45582C433E1
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 02:49:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165B22070C
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 02:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pv5MRDUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165B22070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RI1qMrzheBNIoG3whJjToUmqmbA0mtBwkq6xL6ScKYw=; b=pv5MRDUnanhVNQahzbGy9RQW+X
	+2bEj+cLJxksq2a90tQxfuGutL1LJD8HxVwPv9jKBFlGCuhf9NYlRoz9S4LFzMRhlRuTa57y8V4FI
	98RyiGxS+5Ijq6zoj1hdvjQXv53UK7F3YfIeyQAIpAGiMtyjarARlMgMleGL/blU3DQWmvPmfK/DV
	C9dxxyHzk3Dc374zgImY0iwY9zkbJypJLNyVq2F7BHsMU8L/kPLhonB/LVU5nrZOmQyCE3xeFSH51
	PvdqhCVnNclVcqH9mVS239OLIgRNoN34R2k8Gl12mXgutoh/0mKZNDjMA5cm8yhPKUyPsO/cRJwSh
	tmVzPsGQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrBlu-000718-5F; Fri, 03 Jul 2020 02:49:50 +0000
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrBlq-0006zk-Q3
 for linux-nvme@lists.infradead.org; Fri, 03 Jul 2020 02:49:47 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07488;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0U1XNlnV_1593744580; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U1XNlnV_1593744580) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 03 Jul 2020 10:49:41 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 1/5] nvme-pci: Fix some comments issues
Date: Fri,  3 Jul 2020 10:49:20 +0800
Message-Id: <3820a0fc3c74f9a70a8856172d499de4dee3c2b7.1593743937.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_224947_117936_B88E059B 
X-CRM114-Status: GOOD (  11.58  )
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
Cc: baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Fix comments' typo and remove whitespaces before tabs to cleanup
checkpatch errors.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c283e8d..a3d0c86 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1260,9 +1260,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	}
 
 	/*
- 	 * Shutdown the controller immediately and schedule a reset if the
- 	 * command was already aborted once before and still hasn't been
- 	 * returned to the driver, or if this is the admin queue.
+	 * Shutdown the controller immediately and schedule a reset if the
+	 * command was already aborted once before and still hasn't been
+	 * returned to the driver, or if this is the admin queue.
 	 */
 	if (!nvmeq->qid || iod->aborted) {
 		dev_warn(dev->ctrl.device,
@@ -2002,7 +2002,7 @@ static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 	unsigned int nr_read_queues, nr_write_queues = dev->nr_write_queues;
 
 	/*
-	 * If there is no interupt available for queues, ensure that
+	 * If there is no interrupt available for queues, ensure that
 	 * the default queue is set to 1. The affinity set size is
 	 * also set to one, but the irq core ignores it for this case.
 	 *
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
