Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E35C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 22:10:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094B6206D7
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 22:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i9VUzv+o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MwCp65oU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094B6206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qajUVGBlkCGiG8QO2bXE6ffpZYNm103H03134vizGG0=; b=i9VUzv+otu3hDmGfQko9HL/ztJ
	HUOIZLHZan4RHXK9Ey6dOSYyX8TGTP4CQZgnPiriQBPvLt++ODUqaJSmLv+AgAkOyHPaJIzaDEVE2
	jUtXGGgh4X4gO6gJpTgrlLjes1jgo/JA61c82VmaRo7w/CCKtyfmrfDW5lNBEdRD7O3MfDZnRyLLz
	T6aow2Syj82L0skNordyBoPQ/WYxXwE0wtMf6Ii3PO9yrlnM23olxwYMfIFCOguLS+cJ7Tbu+Irv8
	7GZpyoBJ0Fu1TT8aewEPvMtJQCUIhf80f3UQQCG8khbfocBGdzyGYOnYI5K8W+qmVAVFDe8UJDuXl
	CD8AbvuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz5tY-00077L-Vg; Fri, 24 Jul 2020 22:10:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz5tX-000770-9s
 for linux-nvme@merlin.infradead.org; Fri, 24 Jul 2020 22:10:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=IPOcMliK1GI5TzFR1nfWWjH6bfELej6689fV5QtJyUI=; b=MwCp65oUIEDBDGKptAIQ/k8UIr
 BA523JGI6lUKi0KDs7y6WrhezDEdHGa/Gc0r9HudVT/3MSAcXkB8386BxeZDVzoPvQgyJF+41WMCs
 7YIHVz+tla0UO/Mcsdij7qBkPDfE0zuvbIGHh2UdVuokQ9T8SIHQ6/ZomgKVvVs/+8mVDVI3YdpcS
 ruBrylxvKuSGm5i6lLt1XGx08GPx4SezxLrW5EFu+whVrWTqHMoEtBHWCJ9ogQa/9+zHD6/5KZI5+
 G7W21mWg6ZPQNhFkrKBri90/iHqgPh1vyZ3w55W1qw5UYt4c1ku0PqPH2F9gTxqh2uIxEvLmbNlgM
 PtIHONng==;
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz5tT-0003zm-Cv
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 22:10:22 +0000
Received: by mail-pg1-f194.google.com with SMTP id j19so6174301pgm.11
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 15:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IPOcMliK1GI5TzFR1nfWWjH6bfELej6689fV5QtJyUI=;
 b=sD1sx8eHS9ch9zIofrfWCFiCX0SE0JvotGCx1yKP2Xqj8DrodYukXp+0CPnhgbYdXS
 aqaUP03G0K+gQlX1Em6ktt0500veKHtcbcpXAUyN/NIvBovxXDuQI560nnwlEwdQtmnX
 9zpPCrIuXv05v6alGnbD6dvTiXgnYJ/WMw4uFidRncWeNYrF5w8/gmzpqIap/+dMokpm
 +UMZBFNdt+jNqwcJFMsk/PbGpFE5R8zpMTIBPGFCBt3mTwOhV+gVtsayJ1J8l6WY7toL
 Y/0TEE5Eg/MGdagaANQ1qj/Xtr15qEYyWhJ+V4Z9bIEd4EJ/TpQrYDCqM0M3BE5zTEa9
 +RsQ==
X-Gm-Message-State: AOAM530H4ZRJAwv6N2dBu0tZFQj2P/rdeViDpr8pzxUYbKMDzVrqzfss
 0m1WUbP1BbCJkoMH3ekKN15IwT7B
X-Google-Smtp-Source: ABdhPJyM12ijfn2BJFe9sl+zrtJin9h/vqZSm+2t0dz3nVdlhGW5CFP7p7TM1eRHeWUXGWdId3WvHQ==
X-Received: by 2002:a65:4484:: with SMTP id l4mr9965870pgq.96.1595628615306;
 Fri, 24 Jul 2020 15:10:15 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id c139sm7393956pfb.65.2020.07.24.15.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 15:10:14 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] nvme-tcp: fix controller reset hang during traffic
Date: Fri, 24 Jul 2020 15:10:12 -0700
Message-Id: <20200724221013.28828-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_231019_759240_93DECE5E 
X-CRM114-Status: GOOD (  14.94  )
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
 drivers/nvme/host/tcp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7953362e7bb5..62fbaecdc960 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1774,15 +1774,20 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			ret = PTR_ERR(ctrl->connect_q);
 			goto out_free_tag_set;
 		}
-	} else {
-		blk_mq_update_nr_hw_queues(ctrl->tagset,
-			ctrl->queue_count - 1);
 	}
 
 	ret = nvme_tcp_start_io_queues(ctrl);
 	if (ret)
 		goto out_cleanup_connect_q;
 
+	if (!new) {
+		nvme_start_queues(ctrl);
+		nvme_wait_freeze(ctrl);
+		blk_mq_update_nr_hw_queues(ctrl->tagset,
+			ctrl->queue_count - 1);
+		nvme_unfreeze(ctrl);
+	}
+
 	return 0;
 
 out_cleanup_connect_q:
@@ -1887,6 +1892,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
+	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 	if (ctrl->tagset) {
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
