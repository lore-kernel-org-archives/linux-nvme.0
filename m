Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38CAC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 22:10:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E21206D7
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 22:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J6oDL0Fo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nokmOf/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E21206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+OjK37bV9n61Df6z+3uK3rk0W3+6Pmn1FX9xW4WlN8I=; b=J6oDL0FohuhWnGk6erw3D7msxx
	Pae0bq+Y7RGd/n0I6LpRDSKPk5EnviEiag316wK6AD4MrzF2AKgSrC2oBLQbLn5DMBdWq1AP2HFwz
	FpcAuk7b+sjcUrEuEpMYnXwyKFIJZxENdV7HkfzHcf+b/CvH4TtorHLY4fc4Snv48vv6cdl5MnhXM
	/ArAN/Qwf7v4P60bh7cyYxnXh+VVnX4odZtaVqYIwP1Mm9kdOApYN8HEfTFCKkbEv8N5RUPW5s+WY
	YsuAO+a5h9SuoX/5qHqHMewdVwMdvhSay2XyCs0DLteldrZVzco6y7aZZyR7hjOcj2yX7muxEPGcX
	Xk7enh4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz5tZ-00077W-SA; Fri, 24 Jul 2020 22:10:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz5tY-000770-7B
 for linux-nvme@merlin.infradead.org; Fri, 24 Jul 2020 22:10:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description;
 bh=oynyD4pGJvO0s7XSXZf1vsygXINkxKKybRM0taR0t+o=; b=nokmOf/59I9+Q5D3+VNZtGmOnQ
 IoAGHqzJWWNvfY8o0rtHR1vOBrAfwPjC7YKtJ3poNwzMXOQJbeuIWW+BKdJv7zY0EoJAfT524Or6h
 ppbjuE30TrNewYuGa90ZugJ5dwpuljnBMvUg2qm15XpEx3jm3uGD76otFPpoSMnUoHYFA/HMJ/fPf
 8m4Kjbi4rx7PsnLMo3ed0zVmqs+wygQJ2zaiwUGmLOd/GqJyAzWFJAkElQUJLc7Hr10hj5JCVCfxg
 rUJflpFj6Mi1qSogNwsNy3xBGSOYw/HPFovInO/RY/BG3AqC6mdIi3qj7WEYCewtNwPNtcW5trtz+
 zjFKiMCQ==;
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz5tT-0003zn-G7
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 22:10:22 +0000
Received: by mail-pg1-f196.google.com with SMTP id m22so6172076pgv.9
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 15:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oynyD4pGJvO0s7XSXZf1vsygXINkxKKybRM0taR0t+o=;
 b=pF+fm+OdWsW6evcPEMZzbzBdBx+guJ6hy6gadRhXlk+yGEMjpG2QjbsgQVPTw9uOlb
 cmqJ/c4szZUT4UODKYNcKqntj5lZUT+yHDoNieYa1UvDHpjDDDy2J+Awgu3gGexiU0+J
 RBUT1eiCIwUFjAFZXEH8wXY30V77l7VDdwx+wZyGnXoyxevSmydvKufnjWzwj2n6tCWm
 cC6rPNJBY0+/IejU2KvGog4O4F0S/icTwDQ1BKaW6w9NZTt+GqHAtBYbQFcwBLtlfj4K
 0pqot2C11m4uUyHdvLcSa5vxyJyL/Z5eFYNl9NTzu4qaraaTlRlu+O/ds/auLmYON7Q3
 hBYg==
X-Gm-Message-State: AOAM533QnXcpecI4K2+45GEjyB10DyOCgg+fEUC84aYldcGWtQHrxTYI
 9aAjeo3PvWJEu8T33SKSb68Ej62C
X-Google-Smtp-Source: ABdhPJzH5eL126dsIpV83rPa5xMMfrK3lVGZC4Kx5YgxlY94BW3XHCh+lBZzN/T7J2bE+cUJUJqlrA==
X-Received: by 2002:a63:2b91:: with SMTP id r139mr4234762pgr.61.1595628616675; 
 Fri, 24 Jul 2020 15:10:16 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id c139sm7393956pfb.65.2020.07.24.15.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 15:10:16 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme-rdma: fix controller reset hang during traffic
Date: Fri, 24 Jul 2020 15:10:13 -0700
Message-Id: <20200724221013.28828-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724221013.28828-1-sagi@grimberg.me>
References: <20200724221013.28828-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_231019_836327_12141D35 
X-CRM114-Status: GOOD (  15.63  )
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

commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
exposed an issue where we may hang trying to wait for queue freeze
during I/O. We call blk_mq_update_nr_hw_queues which in case of multiple
queue maps (which we have now for default/read/poll) is attempting to
freeze the queue. However we never started queue freeze when starting the
reset, which means that we have inflight pending requests that entered the
queue that we will not complete once the queue is quiesced.

So start a freeze before we quiesce the queue, and unfreeze the queue
after we successfully connected the I/O queues (and make sure to call
blk_mq_update_nr_hw_queues only after we are sure that the queue was
already frozen).

This follows to how the pci driver handles resets.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5c3848974ccb..d58231636d11 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -967,15 +967,20 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			ret = PTR_ERR(ctrl->ctrl.connect_q);
 			goto out_free_tag_set;
 		}
-	} else {
-		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
-			ctrl->ctrl.queue_count - 1);
 	}
 
 	ret = nvme_rdma_start_io_queues(ctrl);
 	if (ret)
 		goto out_cleanup_connect_q;
 
+	if (!new) {
+		nvme_start_queues(&ctrl->ctrl);
+		nvme_wait_freeze(&ctrl->ctrl);
+		blk_mq_update_nr_hw_queues(&ctrl->ctrl.tagset,
+			&ctrl->ctrl.>queue_count - 1);
+		nvme_unfreeze(&ctrl->ctrl);
+	}
+
 	return 0;
 
 out_cleanup_connect_q:
@@ -1008,6 +1013,7 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
+		nvme_start_freeze(ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
 		if (ctrl->ctrl.tagset) {
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
