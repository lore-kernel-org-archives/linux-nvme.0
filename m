Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F20C433DF
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70A72068F
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WZuZmcws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70A72068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CR8/sYr4V/25+go1iaC6pJzoNlziaOxQwG01cJFsco=; b=WZuZmcwsgk6M8ZYfN3HlpLTjpW
	lOQ3CKNmBMxPcQei3ULJBT05j0fy9A9twvsjihfXw4SqV/P1E/EOvqYObB74hFUPhhPMmbVjn4qDh
	ifBUgsXMXtgk/goNEyPubawtJYbFhh+vbVOEsml8fVNUwXqXnI997XKFofOq8bBAsaKfQpGczSoFa
	zAbvTMmrsPLuqrt/NqurpEdy/k9JBv3Ht0CKomwumaGKnSWCZnVTiF8jJ5ZpcMOMkOd9PqAumgIXE
	+/H8LiJs2VENpASUEJ57v1Yh3OGu7r9K4xJzH4YrbB2t1F2/ayKv2jhBZAllC6tIOv8NIPEJAidpS
	cwLGb/fg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2UR7-0004sn-5p; Mon, 03 Aug 2020 06:59:05 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2UR4-0004rT-6c
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 06:59:02 +0000
Received: by mail-wr1-f67.google.com with SMTP id z18so29548151wrm.12
 for <linux-nvme@lists.infradead.org>; Sun, 02 Aug 2020 23:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qxJyNY4cP6Qh/BQpGN7mAeeGq08PzWvbEB9duKVJZDg=;
 b=hgTAuaPJ6YJE/oMUhe0GcNxoZ3apLkTqw07nSMcnkp4tC+/ujzJbYU6AYCeL/zGgqL
 MDIaAiOoZ28l84AIUwWAdRWaSsFlBsRIo0yMHuHOjCSwM5f1Rb0FXjiCkQQ2NpCXMamr
 oxhePkHm06vSOafJAnGi7TegdPZPeSk1jJat84uCh6wiLKcSmr7uSKqL3WwnOynTN3sW
 EI/q1H3R+H++neIq0Vw/kz4Vl5TyJWjs/ViDn3tZvXgCwpfLvnoKXKavcFJNuISjRYjV
 /cOxJm2kzPLntEvNKEwHxTGAfH0KTZn7825+gAwscA7gRBrKR9W7T3w/+3HpJMln3Er4
 qdIQ==
X-Gm-Message-State: AOAM5300gTJd0Mo1OebLQ3LyAy8cFiwfkmbhnDTwEvA9DtX3H8eOR0f/
 gZPsUfhWNhraN2YOYxZM+MlkBm6H
X-Google-Smtp-Source: ABdhPJzvoSGWz88MQU+bum3SFWiLvIOgtaTeRy2ZmUHz1ToEYeSX7O53XRWGleA/kRc3/EV/EbJ5aw==
X-Received: by 2002:adf:c108:: with SMTP id r8mr14665259wre.41.1596437940898; 
 Sun, 02 Aug 2020 23:59:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id c15sm21574511wme.23.2020.08.02.23.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 23:59:00 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH 1/6] nvme-fabrics: allow to queue requests for live queues
Date: Sun,  2 Aug 2020 23:58:47 -0700
Message-Id: <20200803065852.69987-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803065852.69987-1-sagi@grimberg.me>
References: <20200803065852.69987-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_025902_313538_15CDA67C 
X-CRM114-Status: GOOD (  16.67  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Right now we are failing requests based on the controller
state (which is checked inline in nvmf_check_ready) however
we should definitely accept requests if the queue is live.

When entering controller reset, we transition the controller
into NVME_CTRL_RESETTING, and then return BLK_STS_RESOURCE for
non-mpath requests (have blk_noretry_request set).

This is also the case for NVME_REQ_USER for the wrong reason.
There shouldn't be any reason for us to reject this I/O in a
controller reset. We do want to prevent passthru commands on
the admin queue because we need the controller to fully initialize
first before we let user passthru admin commands to be issued.

In a non-mpath setup, this means that the requests will simply
be requeued over and over forever not allowing the q_usage_counter
to drop its final reference, causing controller reset to hang
if running concurrently with heavy I/O.

While we are at it, remove the redundant NVME_CTRL_NEW case, which
should never see any I/O as it must first transition to
NVME_CTRL_CONNECTING.

Fixes: 35897b920c8a ("nvme-fabrics: fix and refine state checks in __nvmf_check_ready")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 4ec4829d6233..8575724734e0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -565,10 +565,14 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	struct nvme_request *req = nvme_req(rq);
 
 	/*
-	 * If we are in some state of setup or teardown only allow
-	 * internally generated commands.
+	 * currently we have a problem sending passthru commands
+	 * on the admin_q if the controller is not LIVE because we can't
+	 * make sure that they are going out after the admin connect,
+	 * controller enable and/or other commands in the initialization
+	 * sequence. until the controller will be LIVE, fail with
+	 * BLK_STS_RESOURCE so that they will be rescheduled.
 	 */
-	if (!blk_rq_is_passthrough(rq) || (req->flags & NVME_REQ_USERCMD))
+	if (rq->q == ctrl->admin_q && (req->flags & NVME_REQ_USERCMD))
 		return false;
 
 	/*
@@ -576,9 +580,8 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	 * which is require to set the queue live in the appropinquate states.
 	 */
 	switch (ctrl->state) {
-	case NVME_CTRL_NEW:
 	case NVME_CTRL_CONNECTING:
-		if (nvme_is_fabrics(req->cmd) &&
+		if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
 		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
 			return true;
 		break;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
