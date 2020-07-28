Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD968C433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 05:35:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B7520792
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 05:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B+pDByk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B7520792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YJG75qh6H2iXz7pa0QjMTP/PZucvUsnpy3dD47M48Uw=; b=B+pDByk1k9nTjkvbHvk38M0DhL
	RbL3kmAPxQedW3J6NVhrx1yFiYVZeCYCZ1U+YU8JlBdsSCmfTlw8CJvtJ8vU3pdDsrX51XuFc4u3y
	CY+n3Z4iU8GXak2GWtL3eHkUSY0LKx8w55d44nyHXpJb5eaRbeJ4wgKAT3BglLh0HDVUVGz2k5zSb
	VVcu35B5UHEKfM1FBq+RItKh+LBsvMquHHPPnNQJ+eMFrznzBekUDqd9MuLqmYmNcLFfTdgVzvg0q
	c5p5tSznTR/JsuR7qcVTIx8bjkMe2d5vW5NL1dy4Xpjku+o0e7tirvongvnZP+/SGr+Gie+ZFlkK/
	FAdA/wUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0IH1-0003nZ-9q; Tue, 28 Jul 2020 05:35:35 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0IGx-0003mm-LO
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 05:35:33 +0000
Received: by mail-pl1-f196.google.com with SMTP id b9so9302669plx.6
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 22:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+d1RUcI8qkdFqk+3DykRmBf3CTagvxiCY0lV3kr5xIg=;
 b=AI5UjbbZMcym9G6lzkm0bAIQ2D3mvBLob5qvFMmrryVEE4CV6c3YMI4iDNkV2JcC6W
 x+w8AoNOgEPQM69Z+SMXI6YcZ6Jt5cTfE9Y9Z8gCwwX6mu3G15HF2F44WQqd0KPEiCMi
 vb3NGXVYXHzIOQDCbtQzZ79cmPupzEHmgiL9+vHAtXUoVdpOkmYW4YwAxVMi6j2wLBm4
 WPYTpeIuvCIA5CZDPK/0976iN4q4kBMnTWPOa/R56JBr+H/g6CUeaagzLK0nbzd80OYQ
 l0Bp6X4L7zd+SGv0u1KQ0VgopGAbGjNAAmm0HDi6CZKZUyU/21pOzG5NfLgwPUme8oK+
 Xc1g==
X-Gm-Message-State: AOAM533mxnHOYjxpI7jpem1rEy64RtM0bfZkkGDWCR6RuYeP3xDdXNF/
 7wLCeG4Dhlq0aw6wpTOMr1/v6Gpm
X-Google-Smtp-Source: ABdhPJzH8CXg2doYFpoxP7/s1M8bSGP8nV5k7Ysg+EvfYfLQpX43NrCAGqGv5s7EOgjAZTYkJJKhSw==
X-Received: by 2002:a17:90b:380d:: with SMTP id
 mq13mr2691244pjb.186.1595914525665; 
 Mon, 27 Jul 2020 22:35:25 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id o2sm17027572pfh.160.2020.07.27.22.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 22:35:24 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-fabrics: allow to queue requests for live queues
Date: Mon, 27 Jul 2020 22:35:23 -0700
Message-Id: <20200728053523.21657-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_013531_722229_B8AF81E0 
X-CRM114-Status: GOOD (  16.97  )
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
Cc: James Smart <james.smart@broadcom.com>
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

This is also the case for NVME_REQ_USER for some reason, but
there shouldn't be any reason for us to reject this I/O in a
controller reset.

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
 drivers/nvme/host/fabrics.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 4ec4829d6233..2e7838f42e36 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -564,21 +564,13 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 {
 	struct nvme_request *req = nvme_req(rq);
 
-	/*
-	 * If we are in some state of setup or teardown only allow
-	 * internally generated commands.
-	 */
-	if (!blk_rq_is_passthrough(rq) || (req->flags & NVME_REQ_USERCMD))
-		return false;
-
 	/*
 	 * Only allow commands on a live queue, except for the connect command,
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
