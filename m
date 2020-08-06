Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1387C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052902086A
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I34i81u0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052902086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CR8/sYr4V/25+go1iaC6pJzoNlziaOxQwG01cJFsco=; b=I34i81u09m45GGxJxxglEH60MC
	UDd2ohAj8V7lQubKzP5l5HS7H42fWSWn6mZ2VnUz3pk7KpP4GY1PoquFMVWiUQZDiG7ojS5/drk82
	hlZQCM+2d99enxp0UzlNH72RPgbNEnqQ4p+Jo3PJSIa2oq9hyaAuqzzGSHDkQkRX+9yvcJ29UcgVQ
	XJQRMSiOGiQK9mMBEzpAzkmDjPKRDPjaTOSfAivrakekC/p0XHoOdQKF4moE9ruV+ToKM+cTyiOsu
	ZmNyLtyCs4uXLRoYXWAFV97SngKLYz5AkIV+GbhfdaHGym8Xoa4xWWwO7yJrMl8odFcxYBOY4h5kx
	LJLwhsWw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lIl-0008DS-Oy; Thu, 06 Aug 2020 19:11:43 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lIe-00088h-Hm
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:11:38 +0000
Received: by mail-pf1-f193.google.com with SMTP id f193so15219978pfa.12
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qxJyNY4cP6Qh/BQpGN7mAeeGq08PzWvbEB9duKVJZDg=;
 b=E94sDy6qEh6cKKjM/rpYlJJM1s63WN+7MokxiuTvBIYlyh4HC+1Y8eT7/meSO2rMMS
 bWwyJ/cax6LmDBu6MJLFr598hKtZoahQGsiyi8/Iw78WPZgLEOKDa79JevAPiSZNsmAu
 C7W14Unc+4pQ4hUsMF5xPyDh6TvO+tKdRBRblNZoSsXY19PhznL1aVVzqgeKEDJGTCDg
 /cEjS58yvMLrTCaCR4ZoaGb4aP2XHR51GRLHHIuJLFLE0JlZkasCGraJT6nvjI2jfP8s
 xmsS6eOQZf3FYvZGa3R9ocZ5a6rnO0IULPhvTXCYlvHJeFAOOmJJJ9s5uX1FN+yhEMMb
 chYg==
X-Gm-Message-State: AOAM530dZadxiaVVqo1SJvdq/y/ky96UC4EimfbDG8kiCRM5eQoU881/
 d8jZrCcim+8VHP+2doLooe3zDMRy
X-Google-Smtp-Source: ABdhPJxprzcxFNnakWMzW4CvwsXo6knLKcLwHVBOyg6gp833dOGuwX9mUE39Vj+dVx7Pm88HjKeMsw==
X-Received: by 2002:a63:1045:: with SMTP id 5mr1731091pgq.118.1596741091767;
 Thu, 06 Aug 2020 12:11:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id gn13sm7801348pjb.17.2020.08.06.12.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 12:11:30 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v2 1/8] nvme-fabrics: allow to queue requests for live queues
Date: Thu,  6 Aug 2020 12:11:20 -0700
Message-Id: <20200806191127.592062-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191127.592062-1-sagi@grimberg.me>
References: <20200806191127.592062-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151136_604197_636C50C8 
X-CRM114-Status: GOOD (  16.62  )
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
