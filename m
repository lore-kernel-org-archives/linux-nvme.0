Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A844C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D32C2086A
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qRBKsMjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D32C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AnhkPbgUs3y9nLDnLsS4vvT93P9VObo6llAHMFDkY78=; b=qRBKsMjT4p4At1OWnJ2+M0QZFE
	c8sXdnF6leG25Ze6SoZ3fKbHznw4oEEryQZ6oe6KzdYqLZyzsAc4reTxepqwbgcJ/0Yt2wiNobJhw
	IvkXF3fSMSCWFjRt+lYVFf2/14gPsCcAZgThUToaEbFs5R23PgDzStr2bPhXPdL8NK86rJWpphgxD
	HqCJlod3r42UZ5yBnyJLa4Ds/LrDcw0Z8g7bqkJQyidGQA+u1IuHnvwiJIPFQ169gOmO64nzneGXm
	tbK4rAxvK696GFGCM+6EomJf8YlcdFvGVT5ZN3l/gGm/JxqlADQ6yQfuMy8aPYzL3U61fB08G9GiF
	TF4bJ3pw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lIu-0008Hf-1t; Thu, 06 Aug 2020 19:11:52 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lIi-0008BR-Eu
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:11:41 +0000
Received: by mail-pj1-f66.google.com with SMTP id kr4so7356056pjb.2
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OTI+DFyBORBonNDj38KkbE47cCO+2BTte9xP7vDDyUg=;
 b=sOgZp4sBV9MOn2jxWW3YZrixGnXLpL6n6d9LLkkaRPqu8iXdjeC5KpOdtj0UQ2dnfb
 fvfSEk4aA7EWhNlB1jN55Nr6REr7oi5g4TalAzOrZmwNml2F3mrMukL7nPp190DldXIy
 byYXhNvmjMbIAUwzPbmQf93rvWXjPd5LPAbB564TKUIrk9gGS33KqMnEQXSoRLVJP6ni
 r6gFZTv6xK7bMzbMlyi4WkJmxgTKdyy5oW/ONFh7BdlU8x7qqvybJMoPWdgI6eugaKAF
 NAS6+nq0AJvlmbj9y74OaiiN0hmMGeOMG7XgGrMOErF47WaOy8SC7PZn6jngSq9MqHzp
 SrHQ==
X-Gm-Message-State: AOAM531C0inV/VChly11p/tsuecHO/mNe3SgKq+0BamSwJf3uVf2v3RV
 d+0bScavJnMwy5N7yk+qHt6H8UcO
X-Google-Smtp-Source: ABdhPJxxe4x1/ATQxuK1e2YRgCqv9XfKTFOTpwImBQTZN2Fjk8S987tf8sLiJVPQjFP6d+gmaBNqog==
X-Received: by 2002:a17:902:700b:: with SMTP id
 y11mr9234971plk.290.1596741098997; 
 Thu, 06 Aug 2020 12:11:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id gn13sm7801348pjb.17.2020.08.06.12.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 12:11:38 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v2 6/8] nvme-rdma: serialize controller teardown sequences
Date: Thu,  6 Aug 2020 12:11:25 -0700
Message-Id: <20200806191127.592062-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191127.592062-1-sagi@grimberg.me>
References: <20200806191127.592062-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151140_562483_9087B174 
X-CRM114-Status: GOOD (  16.01  )
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

In the timeout handler we may need to complete a request because the
request that timed out may be an I/O that is a part of a serial sequence
of controller teardown or initialization. In order to complete the
request, we need to fence any other context that may compete with us
and complete the request that is timing out.

In this case, we could have a potential double completion in case
a hard-irq or a different competing context triggered error recovery
and is running inflight request cancellation concurrently with the
timeout handler.

Protect using a ctrl teardown_lock to serialize contexts that may
complete a cancelled request due to error recovery or a reset.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 44c76ffbb264..abc318737f35 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -122,6 +122,7 @@ struct nvme_rdma_ctrl {
 	struct sockaddr_storage src_addr;
 
 	struct nvme_ctrl	ctrl;
+	struct mutex		teardown_lock;
 	bool			use_inline_data;
 	u32			io_queues[HCTX_MAX_TYPES];
 };
@@ -997,6 +998,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
+	mutex_lock(&ctrl->teardown_lock);
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	if (ctrl->ctrl.admin_tagset) {
@@ -1007,11 +1009,13 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (remove)
 		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_destroy_admin_queue(ctrl, remove);
+	mutex_unlock(&ctrl->teardown_lock);
 }
 
 static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
+	mutex_lock(&ctrl->teardown_lock);
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_start_freeze(&ctrl->ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
@@ -1025,6 +1029,7 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 			nvme_start_queues(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, remove);
 	}
+	mutex_unlock(&ctrl->teardown_lock);
 }
 
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
@@ -2278,6 +2283,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 	ctrl->ctrl.opts = opts;
 	INIT_LIST_HEAD(&ctrl->list);
+	mutex_init(&ctrl->teardown_lock);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
 		opts->trsvcid =
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
