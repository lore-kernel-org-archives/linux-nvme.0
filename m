Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A14C001B0
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zCCJuLWxlzwZK4lPpl9OOBdDL3u1368YHPb0g0HV9fw=; b=OsyY2wZB4TJ2tMZj0vTivSYUY1
	u2XAqtpkELhukzpPIXjN1/TpIZX5E8TvTpda5+gRLuNrn48BJvs16gIpluAyOw9nR5pjX7wyLqXZQ
	BiKV6KdZLuKj2ausOoFYfMORehm1HqefjfmO7/BpOhnORlHWWiAHtYmUXRGpnJQad/9j7Pff5y4xs
	mY5bIAwYBYU2+SulW8WiXhYLxLeJ78e99oGcDVkolDvE8jzeYS3It2LJg2oaLTgB+Q6Lp3qUljIrO
	htHBl2BTPygYkg7cjmcTWyX3yI1O579jv2/dMH/xIg5PtMyK02B1z0e6eZdo8JSUzNEr4AbyzgEde
	S2nPmbtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVC9K-00FEcR-14;
	Sun, 13 Aug 2023 14:32:58 +0000
Received: from mail-lf1-f47.google.com ([209.85.167.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVC9H-00FEbJ-0t
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:32:56 +0000
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fe0a3377bfso1516478e87.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937173; x=1692541973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCCJuLWxlzwZK4lPpl9OOBdDL3u1368YHPb0g0HV9fw=;
        b=dj4t5VFweuaM27MnrMCN8uZWN94ze1D8E0vLVgK9bFM4q7wfeVzvhA7DDByajJpKlP
         e8UYSQNVgKtx5TRHKqhT/7Y6tijib+Ab4r+kn9djeTs7/kvStJG4pZe+hGz4xL9i0FKT
         zONq2bOTQQtk+/6FzpxewYqyWG/1bwPajYb+KMnnB6GogNF2+j+duJoiRG/b9Lk+UTcJ
         /F5WKrlfQ2pHEWI3vVhybsHsp7A4miVfBM5MV4/EYkhssItXmPOANJjBjnoEHtuMgYIQ
         NewY0UQJ6Was034sCvMtfxG0SYDsO+awOnLhFp8Wl/zYcO6h2HrCUoypLexRSOAhMj60
         rvZg==
X-Gm-Message-State: AOJu0YzWvq/cbzZD1VkJevAz351tH9vRPTetxndOIqb2euD6cIlvlecz
	eBxThZLVt8663yv7SURSX9L/qsCI1qo=
X-Google-Smtp-Source: AGHT+IEMgr4cL72fjBoVIyNafC2S2sqmZAmXwlZ4lvT9BP+7xUMXncpZwcbs/1ab1EHGo0SlKnrpJg==
X-Received: by 2002:a05:651c:210d:b0:2b9:4bc3:c367 with SMTP id a13-20020a05651c210d00b002b94bc3c367mr5471629ljq.5.1691937173219;
        Sun, 13 Aug 2023 07:32:53 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id kg23-20020a17090776f700b0099cfd0b2437sm4672075ejc.99.2023.08.13.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:32:52 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: stable@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 5.15.y] nvme-rdma: fix potential unbalanced freeze & unfreeze
Date: Sun, 13 Aug 2023 17:32:50 +0300
Message-ID: <20230813143250.12621-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081242-sage-caddy-ebf9@gregkh>
References: <2023081242-sage-caddy-ebf9@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_073255_313377_D7D05822 
X-CRM114-Status: GOOD (  13.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Ming Lei <ming.lei@redhat.com>

Move start_freeze into nvme_rdma_configure_io_queues(), and there is
at least two benefits:

1) fix unbalanced freeze and unfreeze, since re-connection work may
fail or be broken by removal

2) IO during error recovery can be failfast quickly because nvme fabrics
unquiesces queues after teardown.

One side-effect is that !mpath request may timeout during connecting
because of queue topo change, but that looks not one big deal:

1) same problem exists with current code base

2) compared with !mpath, mpath use case is dominant

Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 80383213b882..c478480f54aa 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -923,6 +923,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto out_cleanup_tagset;
 
 	if (!new) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_start_queues(&ctrl->ctrl);
 		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -931,6 +932,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(&ctrl->ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
@@ -980,7 +982,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
-- 
2.41.0


