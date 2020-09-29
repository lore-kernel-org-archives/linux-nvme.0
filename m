Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335A9C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 01:31:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF8721D92
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 01:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rxoMuTQ6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYkzoyBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF8721D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zFRxta9CMXXx3sZjdUZXNfABetmQKnsLO4fivlNE1LY=; b=rxoMuTQ64SbYxkFAqNuRjmyy1
	86JHUT4ta0pAddew0SGQeyaooIEKP/2R80AexuB3G+G6Jp9Z2dE96l6nGcHg9ObPVaGrseLyBeIxe
	wzsV22i/M4sCkWn2YIDve/BOcHEF1UAzDgtV4Sc+iowd7tMExbHdQ8jZycQ1hh6IWAJ3pTdfSHEWg
	Ge5YU0vuec88Xyk8Uo8TDEwBPgifbiDG+T2UIhaJH4hQSChE2mIgAxPrMGKX9zS1RNR+TNIRvvHR6
	1RHYJ2S0MPX9+7fYXBfGHKq4SYtEjpPL19E+9CFBeqXQXH+V4zKrM1lqxP7Rzg7lljYdYHeSf4ktJ
	bE1bqoJ5w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kN4U2-0007Hn-89; Tue, 29 Sep 2020 01:31:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kN4Tu-0007F7-Fq
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 01:31:04 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DF2EE216C4;
 Tue, 29 Sep 2020 01:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601343060;
 bh=m8yyWdT17sxwA4pTD6kXD50OTjR8orcJ4BiXJpbqZAw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WYkzoyBcyzw7/oUVGksf/HHaiD73FNOvm3M4iMhq3Jvj93XtB1v78jO9Hv5WTQMwL
 gxBQsgK2i5I/dzc/UorKlYJw8BBXMZ/1lzDeKPlXztD8LemyvW7866ZQDm9jTiYlvV
 IL5bvwzhdwhPZNrTMu7xQIocPmd6Eoc69hQrn2oA=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 26/29] nvme-pci: fix NULL req in completion handler
Date: Mon, 28 Sep 2020 21:30:23 -0400
Message-Id: <20200929013027.2406344-26-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929013027.2406344-1-sashal@kernel.org>
References: <20200929013027.2406344-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_213102_852828_7355B3A3 
X-CRM114-Status: GOOD (  16.05  )
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
Cc: Xianting Tian <tian.xianting@h3c.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Xianting Tian <tian.xianting@h3c.com>

[ Upstream commit 50b7c24390a53c78de546215282fb52980f1d7b7 ]

Currently, we use nvmeq->q_depth as the upper limit for a valid tag in
nvme_handle_cqe(), it is not correct. Because the available tag number
is recorded in tagset, which is not equal to nvmeq->q_depth.

The nvme driver registers interrupts for queues before initializing the
tagset, because it uses the number of successful request_irq() calls to
configure the tagset parameters. This allows a race condition with the
current tag validity check if the controller happens to produce an
interrupt with a corrupted CQE before the tagset is initialized.

Replace the driver's indirect tag check with the one already provided by
the block layer.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 90346cba87d1e..cc3ae9c63a01b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -942,13 +942,6 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	struct request *req;
 
-	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
-		dev_warn(nvmeq->dev->ctrl.device,
-			"invalid id %d completed on queue %d\n",
-			cqe->command_id, le16_to_cpu(cqe->sq_id));
-		return;
-	}
-
 	/*
 	 * AEN requests are special as they don't time out and can
 	 * survive any kind of queue freeze and often don't respond to
@@ -962,6 +955,13 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
+	if (unlikely(!req)) {
+		dev_warn(nvmeq->dev->ctrl.device,
+			"invalid id %d completed on queue %d\n",
+			cqe->command_id, le16_to_cpu(cqe->sq_id));
+		return;
+	}
+
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	nvme_end_request(req, cqe->status, cqe->result);
 }
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
