Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A62FC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 10:33:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1396C20731
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 10:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1396C20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KFvPfwigfOd+yAkmVOX9soXRMtwFPhvlIs4FZ9FVU24=; b=dLSTnTQVayWQMETIx4DBzY5wq
	WiVdpm49EnypO67lPud05qtK6BkeZG3F/jNQB1nZEwYdRhIb/O1E7A5DpfQrifVhXryzpMGj2z5U9
	OmQQVSoj4Se0lWy48cNYMv66Y+adbfAz1bznBmJ7Ee38eSe3fN/8Pt5jAd7fk+2Na4EopN+OKNjHt
	D2rgdv/ONHpzIVe/EZPbEUOUW0/3FB7SfsusqWp29Z/OPw7PKCq20HfS4S2T0HfaDCncP6NPEALwc
	lGTJycW+xfAJq0LcrgST19DNiMhDW42aNX0IciRNHmQqHgVXceq4WPPhAue9f/YPJi9wOzdDIuzUv
	R3EkLQ2Gg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4i8u-0000Cd-6f; Wed, 27 Jan 2021 10:33:44 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4i8l-00009F-Br
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 10:33:38 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 71866AF1A;
 Wed, 27 Jan 2021 10:33:34 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/5] nvme: return NVME_SC_ABORT_QUEUE for cancelled commands
Date: Wed, 27 Jan 2021 11:33:25 +0100
Message-Id: <20210127103326.16191-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127103326.16191-1-hare@suse.de>
References: <20210127103326.16191-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_053335_598676_09B9CDE6 
X-CRM114-Status: GOOD (  15.82  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A request will be cancelled when a queue is deleted, so we should
be returning a status of NVME_SC_ABORT_QUEUE.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/fc.c   | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4a5059472625..1f723b7e9efb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -364,7 +364,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 	if (blk_mq_request_completed(req))
 		return true;
 
-	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
+	nvme_req(req)->status = NVME_SC_ABORT_QUEUE;
 	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 	blk_mq_complete_request(req);
 	return true;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 97e3424c7b03..86395b66310d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1955,9 +1955,12 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	fc_dma_sync_single_for_cpu(ctrl->lport->dev, op->fcp_req.rspdma,
 				sizeof(op->rsp_iu), DMA_FROM_DEVICE);
 
-	if (opstate == FCPOP_STATE_ABORTED)
-		status = cpu_to_le16(NVME_SC_HOST_ABORTED_CMD << 1);
-	else if (freq->status) {
+	if (opstate == FCPOP_STATE_ABORTED) {
+		if (op->nreq.flags & NVME_REQ_CANCELLED)
+			status = cpu_to_le16(NVME_SC_ABORT_QUEUE << 1);
+		else
+			status = cpu_to_le16(NVME_SC_HOST_ABORTED_CMD << 1);
+	} else if (freq->status) {
 		status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
 		dev_info(ctrl->ctrl.device,
 			"NVME-FC{%d}: io failed due to lldd error %d\n",
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
