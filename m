Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF770C433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B82120658
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fyMlND0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B82120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RaqhKDPLjJv4zaQKJ+liaNtKcHrgs1c1g270nLsJDco=; b=fyMlND0wn7FmjktIfxJ7tGduyM
	N17JoVPm/qSM8UJJGxm4GA6Zv/Zgm9Ng5APzLZw2PGmI3dmvlwQHiwjz3ALS4vBiQrxEjNX6zlYDT
	VK9Xo3HrCK6ZyqFCJLg6VwaNkdPgooYW0L1zgDpkAjNnBq0Ql4lqDg39GEOwkHOkL0SroNjwA9iMS
	bQn088oBnnvYC3+oNEh/hH3RFwc4qvce8mR9DMlTjakEsy+VWjN0F8gyAKgOa1Jhy3lPw/+Hx8g1n
	aeKdj8KIkLb1qNXv5lCiM+X4lI+RQxyx8Te8OUL4oOxVkgzSNOmHY79FL/XWCcIz581VWJwWNxNwF
	KG0oTHgA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFjj1-00071T-NN; Tue, 08 Sep 2020 19:56:19 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFjiy-00070u-U7
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 19:56:17 +0000
Received: by mail-wr1-f67.google.com with SMTP id g4so478900wrs.5
 for <linux-nvme@lists.infradead.org>; Tue, 08 Sep 2020 12:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6GJxtMWFMtXFEqCxA0DFwIv0ipW31wATSJsybfu9fnQ=;
 b=U8Q8hcEjw/EGbqq/T16YF0Rc1WNHOFgN5L1PlDe1kkhTj2gR9ZuyEGJox17ulgaUVH
 Jrn8atGESLZxDSja/93eGWGhVrG6NVcW/MU37oIzoLDhF6O+8prCFlKUBtPFGF6L5kTC
 FTHnAQ06ZxsVs0pYvKI3GARRmknoM+RRMrHLLWVvOIhyXISlDZMSaOBTMeTdcbXjx4p1
 hW7FWvLTqJ3EfmVGZuIqzzFJOX5+Du6I2KtSJwq+EWwaA/aNgkLsR0dVDE923L8a0K+y
 mJgvGDKcc6Xv//nsoj3vQdkPXbwQRv2Ay2gcUIORXdk4crVhsB+gpP5dIFCfcQklAjER
 lI2A==
X-Gm-Message-State: AOAM531vrylOmVEav+N9mvAssmxWnr7omoilbm2dNXIfcW37uFN/NMMS
 IhNmzUMLWpm20gxSxatK5ew=
X-Google-Smtp-Source: ABdhPJzU50Ey9ZfSkdlyZz0sPNDk2KvSn6td4AvuUSaNBnsjK7gkn30GGDYsPOjv7q76+Mfs3fk1Kg==
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr110824wrm.375.1599594975526;
 Tue, 08 Sep 2020 12:56:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d04f:59f0:a712:2917])
 by smtp.gmail.com with ESMTPSA id 8sm753121wrl.7.2020.09.08.12.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 12:56:14 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH for-rc] nvme-fabrics: allow to queue requests for live queues
Date: Tue,  8 Sep 2020 12:56:08 -0700
Message-Id: <20200908195608.127615-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_155616_969557_AA174230 
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Right now we are failing requests based on the controller state (which
is checked inline in nvmf_check_ready) however we should definitely
accept requests if the queue is live.

When entering controller reset, we transition the controller into
NVME_CTRL_RESETTING, and then return BLK_STS_RESOURCE for non-mpath
requests (have blk_noretry_request set).

This is also the case for NVME_REQ_USER for the wrong reason. There
shouldn't be any reason for us to reject this I/O in a controller reset.
We do want to prevent passthru commands on the admin queue because we
need the controller to fully initialize first before we let user passthru
admin commands to be issued.

In a non-mpath setup, this means that the requests will simply be
requeued over and over forever not allowing the q_usage_counter to drop
its final reference, causing controller reset to hang if running
concurrently with heavy I/O.

Fixes: 35897b920c8a ("nvme-fabrics: fix and refine state checks in __nvmf_check_ready")
Reviewed-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 32f61fc5f4c5..8575724734e0 100644
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
@@ -577,7 +581,7 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	 */
 	switch (ctrl->state) {
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
