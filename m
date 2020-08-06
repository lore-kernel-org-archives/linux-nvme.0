Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79790C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20A22086A
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NAmlxXLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20A22086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uU6rc2HUmo1KGumh8zj72xh4nQMvVKm905lZZsL+UNo=; b=NAmlxXLWM2Ema+sqTzFMQ5r5LW
	+R/7qXg/84Y2TCJkoR5qX4pBrFi4HsJxQ0DhKmrOe1ZCQcv6H0cCPXuLMMBb7JNzSTiz27BCdF7M2
	0R/UD1Lr39+FLgKRVKYN+Rvjx0oz7SPNFx+QL2je6OsGk4e60TVw3KSaFvoyz5gFC+sgx7PHvRWKr
	KmG6YzlaGOfUWMY7NnCYswaE/EB4l2mZPoHXFUqyNO2VakujL8OoLThCUI9n7GuJ7tMbIlCZbXwMo
	tetdoVnhFqC1U4F4fuNCGi/eUxBlcEQJeyn/wQTt0Z8Ugp3nDEZcKSGPBpT/0mE6UMJ2UOaRTwlIH
	2K/y39Zw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lIy-0008KK-2w; Thu, 06 Aug 2020 19:11:56 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lIl-0008D1-Bz
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:11:44 +0000
Received: by mail-pg1-f193.google.com with SMTP id o13so27473434pgf.0
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mnvghcr/Pstxo6fAdO7ZyQP1oY5nZwbynuE3nW+ZnQQ=;
 b=LgqufJDPYT7zZH8zHVdA7xnYzuVYSZtIerXPiRpZa0P6irQpmyNkub//cFq0xBS4cW
 IKuNn9zD10/JHZl92CS8vjXi1dyymjntQWYGnYL/goxCXya/XJSCbNQUYxacE/vA9h3Z
 eOq8LXLzBnCG3FOUlEOhbT81RFQDtG0MxV1H2pD9yoB+87dl0AVMJo+/hiqEaN0IkKpq
 6vLMP9ON8wHf61M1ZZ0NBUN6f1YiqeAZeBRrRaaUxS266okoTLR2ztDqJiUbDjjCrdI2
 QqL0ZQ0WjlUwcIxXS7UCYiT6UNAjCwQA2iH5b8SpNLhGcog307vFFdM25EGt2NtczHQ7
 ExNQ==
X-Gm-Message-State: AOAM5300F0FkwcLO8BhXM88AJichjV5vwFB+68cmH/HkGEJrSXJorQyI
 eqAaNP2X+C7lTZboSDSlyB7N2ifU
X-Google-Smtp-Source: ABdhPJynjjuL98yw/Wb7mtNfX0aG+aN//j6oN54t0ODBCZTwHeiR67b07dLpIlzrnP9ie4ljmHBvIw==
X-Received: by 2002:a63:4c5f:: with SMTP id m31mr5825039pgl.403.1596741101852; 
 Thu, 06 Aug 2020 12:11:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id gn13sm7801348pjb.17.2020.08.06.12.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 12:11:41 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v2 8/8] nvme-rdma: fix reset hang if controller died in the
 middle of a reset
Date: Thu,  6 Aug 2020 12:11:27 -0700
Message-Id: <20200806191127.592062-9-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191127.592062-1-sagi@grimberg.me>
References: <20200806191127.592062-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151143_453797_42132D0A 
X-CRM114-Status: GOOD (  15.84  )
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
 drivers/nvme/host/rdma.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 30b401fcc06a..4ca53b864636 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -976,7 +976,13 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	if (!new) {
 		nvme_start_queues(&ctrl->ctrl);
-		nvme_wait_freeze(&ctrl->ctrl);
+		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
+			/* if we timed out waiting for freeze we are
+			 * likely stuck, fail just to be safe
+			 */
+			ret = -ENODEV;
+			goto out_wait_freeze_timed_out;
+		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
 			ctrl->ctrl.queue_count - 1);
 		nvme_unfreeze(&ctrl->ctrl);
@@ -984,6 +990,9 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
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
