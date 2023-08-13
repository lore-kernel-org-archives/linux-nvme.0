Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0F5C001DE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tUuuKbL8ydFNPda8N4HOTsW5STdP9ERZYuHURXlNIxg=; b=uWwmIN7UaMljwXIQL0zZbim5gM
	XqqSXJZHMus21jgORzuvjJ+I8tbYstSw0vyBHI/faNQzuLz6MH6WfxtHqHLmkTYrg4VcW5PkAd6MV
	tDa9EX/v5mJPOBsF2eNz/S7enSEupG2r8ASHL7VvgG0hA4z+EAUHPerrEzqykWmQfyGL+hAl1TIQs
	zVhFShy4dF7NQDhhCEzPrGLhnlmreX3KMj2t3FzQX4wpawoG1p1ufz07wUfjCLjJoO8rLjJPmVc+7
	s68RYdrjlilNmy1S0CWv9+nRjV4V3CcmLZgQwqVHkJ/dM5HQgUMuffb+9fCdUxmBP4sk2oESyrXJ0
	ea1glQTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVC7e-00FEMS-1L;
	Sun, 13 Aug 2023 14:31:14 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVC7a-00FELe-27
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:31:12 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fe8d816a40so3430315e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937068; x=1692541868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUuuKbL8ydFNPda8N4HOTsW5STdP9ERZYuHURXlNIxg=;
        b=Jr1eDquWC05SCtmZUir7dRS0mWi27MYXOtlCTbrFeOimUIwa8qkmpBkiSiaeKgczJA
         mNBgtMLFnEKkfBCDPiFgBWEQY6OVNRGIbGvPUKc17ivtekIyWI+RYeJIyJNgYKpGWMar
         6TufYvEbIkWsvhikzcyb4+WLoczbtrwNGXvi973uo8unRUhDVFE6ExdTwjpJG2oY6OqP
         fesO+4Hg+gDfx/BtMkH78qKh1862ipzRzbaeEkwxmbVrpyxsdWkNDMK0UwqCknMPGMSO
         2GSPl+9Iz8CNN7/BQrdT4NDnZ3OvS1Yf4iznRPfBOgiRkGC/8DlMgynXBhIGdMGMVMn0
         98uQ==
X-Gm-Message-State: AOJu0YzcFnI/dbaybzTfF7jj2cg41XPoYBxxaQIpGE/bU2CJ7IOXp3SI
	qU+8bva7Z8lKbQ+r+K3byliZtTCIgAw=
X-Google-Smtp-Source: AGHT+IGd2hPeaEh7kNTz5il4uY8J2DCXyPRPmXa8I13qfg2Tvp0zsvrPETGq8PATbl4Ea3sAn+YmBA==
X-Received: by 2002:a05:600c:5111:b0:3fe:5228:b78c with SMTP id o17-20020a05600c511100b003fe5228b78cmr7207790wms.1.1691937068577;
        Sun, 13 Aug 2023 07:31:08 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906660c00b00992c92af6f4sm4655213ejp.144.2023.08.13.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:31:08 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: stable@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 5.15.y] nvme-tcp: fix potential unbalanced freeze & unfreeze
Date: Sun, 13 Aug 2023 17:31:06 +0300
Message-ID: <20230813143106.12390-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081226-oak-cartoon-6115@gregkh>
References: <2023081226-oak-cartoon-6115@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_073110_695447_B55C0FC7 
X-CRM114-Status: GOOD (  12.66  )
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

Move start_freeze into nvme_tcp_configure_io_queues(), and there is
at least two benefits:

1) fix unbalanced freeze and unfreeze, since re-connection work may
fail or be broken by removal

2) IO during error recovery can be failfast quickly because nvme fabrics
unquiesces queues after teardown.

One side-effect is that !mpath request may timeout during connecting
because of queue topo change, but that looks not one big deal:

1) same problem exists with current code base

2) compared with !mpath, mpath use case is dominant

Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1dc7c733c7e3..8d67cdd844f5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1884,6 +1884,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
+		nvme_start_freeze(ctrl);
 		nvme_start_queues(ctrl);
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -1892,6 +1893,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
@@ -1996,7 +1998,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (ctrl->queue_count <= 1)
 		return;
 	nvme_stop_admin_queue(ctrl);
-	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.41.0


