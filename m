Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67148C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Km7kvZryGfzgtWyO6R0fkU01naooGzypE9SyIJrzOm8=; b=EH7BJm7cqFgcsdMwNThWgkcx3+
	31szXYjKqVZZjrTZH659qwZEB+0mvmWeqlktewEU+d0KsQnqOnPkatXPMIGbMEUhrJtE/wgMkJGKd
	uPEjeSx94416BQYPftWLBbNqESrHXpwkF1UkuomHwuH+pDua5Yw6jtrHkKm3tj5XYLz+Dhf3B1uMR
	O4cM3+yKrBsGmicyCADmPd7s2aDQJ2T2SgUx30jKVSC/rU1PWkOrWAlmmhCPxHKqU5M9rV8e9xzcS
	D4F7Nid1A8ZFuYrwFv/KlftaeafchTwWKumnweUEeYXzeP9f7EdOtMAiMX/YchFQUFBT9UyTY32HZ
	u21MDdzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouBAq-00B8Fu-TP; Sun, 13 Nov 2022 11:29:16 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6Y-00B6TE-R2
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:52 +0000
Received: by mail-wr1-f46.google.com with SMTP id v1so12368877wrt.11
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Km7kvZryGfzgtWyO6R0fkU01naooGzypE9SyIJrzOm8=;
        b=GTzeIgTNmzm7j16hxEa4AJmZDtL8YEx5K0Bfiap/3K6y6ZDBc+53K+KXlFFzC3mqIB
         N9U8u559zRFou+i9Lq7XHC3RjCA9klORob3mx3TqeK9mg841wFOGkU34Og38A8zOILfi
         5GmDTCA/kJIE2DCcyL+iqB/5nDjrgc2I/INTrr+2TdNWav+mPqLRficGWNnaJXshJxv2
         Xs2+mwmrm/C41M0mzIaiYfZqL4sQwnvHj07n+WmTv9pfctoZypdZEChNdhfpoBk7mz+p
         ePQ5qwa2op6h22vevepnDyJpoFOyTFhDuRJ0fAzEqUJ+FjXqjb5A98UGq6heU7LQ5FTG
         zO9g==
X-Gm-Message-State: ANoB5pkgoCZ6IzgFfTeTGF0MEtWijRJwB3CNYA0Tyk77kZG1XrNtgiNF
	tJkaBa6v6pf96ndFmiN7jDA4WavHWD4=
X-Google-Smtp-Source: AA0mqf7YY4k69WQUZtGslzCN1YqYBtYfgx122nJm7OkD14Zx+hTVAQowMK5w4ieqgTMEDRRWfuwh7Q==
X-Received: by 2002:a5d:4ecf:0:b0:236:5655:1393 with SMTP id s15-20020a5d4ecf000000b0023656551393mr5137601wrv.626.1668338690168;
        Sun, 13 Nov 2022 03:24:50 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:49 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 20/20] nvme-rdma: stop auth work after tearing down queues in error recovery
Date: Sun, 13 Nov 2022 13:24:24 +0200
Message-Id: <20221113112424.1049834-21-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032450_896293_DEC58BD3 
X-CRM114-Status: GOOD (  13.87  )
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

when starting error recovery there might be a authentication work
running, and it involves I/O commands. Given the controller is tearing
down there is no chance for the I/O to complete other than timing out
which may unnecessarily take a full io timeout.

So first tear down the queues, fail/cancel all inflight I/O (including
potentially authentication) and only then stop authentication. This
ensures that failover is not stalled due to blocked authentication I/O.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6e079abb22ee..ff1a6924f339 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1153,13 +1153,13 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
 
-	nvme_auth_stop(&ctrl->ctrl);
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
 	nvme_start_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
 	nvme_start_admin_queue(&ctrl->ctrl);
+	nvme_auth_stop(&ctrl->ctrl);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-- 
2.34.1


