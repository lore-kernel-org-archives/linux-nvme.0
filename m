Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC73C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E15B2072D
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IRTL4gFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E15B2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fKkZDj/nE9XINr35CmKgwqvyAoWBPjTMRA1Rl67ynKc=; b=IRTL4gFnWoRDe34n0eAXnT7Xks
	PG3OniWFgUVCwhVALfJPRJBeUGIltbv9wVvUWPEZ5ZfB4lSGhmDa+7DFk4FfW3a/sfATy5RsSvaeA
	tbJFIi6DGCNzigpY6Mme7f1wxSO1zzxEJOpDc+rM91xdr6bsXLqTvj1wDfqAeuidJkCTrPj1D/uj7
	Zx0y9zzOxggfgQcQqOB0mIocw3hLYvJ93MN/Gr4yXlbNRUooTiI2xvwbPsW0jMfQGU72SVyYAKLtZ
	oncO8NvmOp+PNaxbXNu82KjR5VOfUWrDrX8KHBloR5OeIc4qiONjeUeMhTftwCK3yuLTLfhFVDyTk
	aD7CJwMA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8dGe-0000qd-Ji; Thu, 20 Aug 2020 05:37:40 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8dGb-0000oq-N2
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 05:37:38 +0000
Received: by mail-wr1-f66.google.com with SMTP id p20so867546wrf.0
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 22:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nlg6sqFY5o2PcnpCIv/DiGkYQV7u/24y0atYx4A1Yu0=;
 b=Cq2rk45Foyib5YZawGL9BOXHQNORNRqlVQIQTIpmzJXjipUfYoA0spPZTB9i0Egn3r
 PNgpfR12qnObTGik+PZwnSjAV+6Q2RepB/1/6eAmztTSY7mO8wqaav+da4ztgJFvalP+
 ojpBUyIRiJtm/1nwuvBjoyDnwnkke5HZAWsn43WACF4iVBMbYhZZ2oUZryUDSQseLS+8
 LHSQKiITQyWp6HzZeYIEP5EQQ7Yr8lErd01R1hhTZpVJgG/QQnsJR3DQ8p9uq+nyVkrm
 /1F8IsRsgIrYPpvommT6QbsncLo6ZXPOzaFmd9AimbT7hwsZlo8kUmn807Qi+fNf/tRe
 mo7A==
X-Gm-Message-State: AOAM533M44xVe+TcRGyIA7PFFP6gl3KBY5Z7RLqAinukLaLtvO7xloJr
 2Cs+Mv6Kr7kFAkq7tQG1j4pJMxzEoUtE8A==
X-Google-Smtp-Source: ABdhPJxpv3o81lDNz0ib2Oqgw1R5NMEuDa2+6a2MOa7QgbuY0A0ZNNX/0WWQ83LMh/BbfSMGLo+uew==
X-Received: by 2002:adf:ab55:: with SMTP id r21mr1331072wrc.332.1597901856380; 
 Wed, 19 Aug 2020 22:37:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id a10sm1900353wro.35.2020.08.19.22.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 22:37:35 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v3 9/9] nvme-rdma: fix reset hang if controller died in the
 middle of a reset
Date: Wed, 19 Aug 2020 22:36:51 -0700
Message-Id: <20200820053651.197057-10-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820053651.197057-1-sagi@grimberg.me>
References: <20200820053651.197057-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_013737_799300_79B222EA 
X-CRM114-Status: GOOD (  16.76  )
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

If the controller becomes unresponsive in the middle of a reset, we
will hang because we are waiting for the freeze to complete, but that
cannot happen since we have commands that are inflight holding the
q_usage_counter, and we can't blindly fail requests that times out.

So give a timeout and if we cannot wait for queue freeze before
unfreezing, fail and have the error handling take care how to
proceed (either schedule a reconnect of remove the controller).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cb8731f4b316..1d8ea5305d60 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -976,7 +976,15 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	if (!new) {
 		nvme_start_queues(&ctrl->ctrl);
-		nvme_wait_freeze(&ctrl->ctrl);
+		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
+			/*
+			 * If we timed out waiting for freeze we are likely to
+			 * be stuck.  Fail the controller initialization just
+			 * to be safe.
+			 */
+			ret = -ENODEV;
+			goto out_wait_freeze_timed_out;
+		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
 			ctrl->ctrl.queue_count - 1);
 		nvme_unfreeze(&ctrl->ctrl);
@@ -984,6 +992,9 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	return 0;
 
+out_wait_freeze_timed_out:
+	nvme_stop_queues(&ctrl->ctrl);
+	nvme_rdma_stop_io_queues(ctrl);
 out_cleanup_connect_q:
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
