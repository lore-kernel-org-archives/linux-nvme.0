Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A93C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 07:59:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F75A207F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 07:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xQpMRiol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F75A207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SqhVPEjqVyPNXfoNAKo691tALuzYrimM4ZnIZ1R9qIg=; b=xQpMRiolav0OOV3J2oaH7FXh7I
	1ubRbUi8lRn6qiS+sFFEHP+PbsL+PUa7nwpjIRhd3AghGB7dp6pcB/YBjUBH8GPmtxgsUkTYVuKVP
	D1UUZvOFbaUWFBkkecnWOogy5iCtwuv57gXrOlxqHL7q45h4VlMMqM3MRaGyjIcQ35xlISSjz9kK+
	hVqgjlpRjVgJMKPaKF8KrK4mXGwn9HjsMZXpc/FfVfImvVd3PZEE8XSI0AwKOnFFjBnEDalzVG+uk
	sq1IThwKT2YWQgFZoe5t7gYQ/U5xyq/2Xa4M1BNnyVlu8QiYWvWOA1U28/oj+F+o3dTgKbMQ/sFkS
	6CTT3QnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0gzJ-00067t-Md; Wed, 29 Jul 2020 07:58:57 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0gzH-00067N-7N
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 07:58:55 +0000
Received: by mail-wm1-f66.google.com with SMTP id 184so1989025wmb.0
 for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2020 00:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H9U923biYU9V9TCrZkTYgM90A8i7c3ZnKa4DjvCfvt0=;
 b=Rk8kZlrZjGxG6F1P2ayS+F5W8h5QlxjZ0DHRVD9cgquPIBBJoSUcaz8S/fq0mFqsX5
 ZrUUZjSo0pj0dh5plEdZHpTAK2AHNjTtB0/kxJDHJAfRbexYXsT0CW5dMRu6168mS6Ba
 el6QTT3WmaMyX/hNVE/3zTBjeD4YZtgtmyS4aQ5xYe5OMI/L4k0psQGpB9+nu5xa21cx
 ZUyu2FlUulM7UxDxogRyJmKDcPhsdS5bSXuOkG6InHCcnypxSp1MfXR0i/mcTawNnxgg
 gpQdgEDwgLRibJ4XmqRwrZyDTNwcPg3bhMaok2retjoT4IzJCajuLM/qmFgItRub8pne
 d7OA==
X-Gm-Message-State: AOAM531o6lERP9BoNV7JHr/91uYvADD7pFdqR/J8EjAqYk7DIodLlP/K
 G6UFHDlC5HmHDJav1YEuGxJas2mv
X-Google-Smtp-Source: ABdhPJxt+jjTPse5WzM+EOgoPw57eXb4lH+teGWjS491Y3SjBuABT6NTWfjPsKXPmB8ayqHWGAAHlg==
X-Received: by 2002:a1c:c28b:: with SMTP id s133mr1350341wmf.43.1596009533731; 
 Wed, 29 Jul 2020 00:58:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:8475:db3f:c2a2:c61c])
 by smtp.gmail.com with ESMTPSA id b142sm725072wmd.19.2020.07.29.00.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 00:58:53 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v2] nvme-fabrics: allow to queue requests for live queues
Date: Wed, 29 Jul 2020 00:58:46 -0700
Message-Id: <20200729075846.22762-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_035855_296514_538CB4C9 
X-CRM114-Status: GOOD (  17.20  )
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
Changes from v1:
- fail passthru commands on the admin queue if the controller is not alive
  because we want to make sure they don't preceed controller init.

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
