Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2A1C001DE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QNGi8K3J7lw/ZSXS7j6v1SkrAVUpcZa/LdyjGxfu3pA=; b=4o5kBPsjREKN03eRb9j4tFb1C4
	ztjkQ5EXCgS+B9x10IS8nq3JqVO5r25WBcP7ZzE3jAQKr/jcaqiXH2DX1+tVIqvtw9b5L+xynpCA0
	ywu/ylnRkaM27YY/u4KDwZJ+6NFnG7o8yVzORzNR5zZnOel/4FHYNMisUPvaJ+ygCpQl7GlrfqzQ7
	e7riwEyheK53aHxZdMAQrmMkhULXIln7PcTH0oM/Ujbk6Q86D8C8aeVusCyavM5VQVOVjDYWOXgbt
	0dng8narPFT4DHjOdvjQ0rjYVLBoUQ276XM3OOSFeV2IZbok0/ekpELBCcr8fPCFxON27bJ30WI6e
	A43zkp+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCLE-00FFuM-32;
	Sun, 13 Aug 2023 14:45:16 +0000
Received: from mail-ej1-f51.google.com ([209.85.218.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCLC-00FFtY-1J
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:45:15 +0000
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-98273ae42d0so108716266b.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937913; x=1692542713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNGi8K3J7lw/ZSXS7j6v1SkrAVUpcZa/LdyjGxfu3pA=;
        b=dJuZ6jipGchMEg1Rn+Uc3fEORem3xUlE3fiGX0zpS8L8lqdR8UVSTkoYROy8NJ2Fgk
         JF3M+Qe78+c3KpuuIyuiJWbH8gUtDiERdTVAvPRlJaekHeI3odn7kvuhFgRKPUhXRU19
         TalyTBnNSaahe2v5YlVhtxG37vX0rDpZrLiyuAU/7PWD2TH3BGHtBTd7iUC6IghBonfs
         kN7a6clmlL2OgHDkW5JhPrgQ0lYOn12afh+cUtauZF6356emf4jAWL6zpdiKnaZ4l+aI
         vo4S7Gcn/qbHu/dOs67MJl2ySzlr+R0wnH/wX4YOvcMnWClayOXUWUSNQzJHXfEPtWhI
         IlOg==
X-Gm-Message-State: AOJu0YxgCVtJHy/7PRQUfNkm6Yj3qZEHzQBbptHkkEC3Lz2kz9IVRhpx
	r/hQ7Tuc/YSk8aw80ZSKMpo=
X-Google-Smtp-Source: AGHT+IEmlQCISV8xuYubpycyxGP0Hocr6owQNsOJL0RdozE0FVGdLDyTDQ7kzwHuZeUbpaz/KHYqqQ==
X-Received: by 2002:a17:906:73c6:b0:997:d069:a880 with SMTP id n6-20020a17090673c600b00997d069a880mr6142907ejl.1.1691937913126;
        Sun, 13 Aug 2023 07:45:13 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906348600b0099c157cba46sm4574699ejb.119.2023.08.13.07.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:45:12 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: <stable@vger.kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 5.15.y 5.10.y 5.4.y 1/2] nvme-tcp: fix potential unbalanced freeze & unfreeze
Date: Sun, 13 Aug 2023 17:45:09 +0300
Message-ID: <20230813144510.15401-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_074514_446341_D0A65570 
X-CRM114-Status: GOOD (  11.99  )
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
index 96d8d7844e84..c2e037644ad1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1882,6 +1882,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
+		nvme_start_freeze(ctrl);
 		nvme_start_queues(ctrl);
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -1890,6 +1891,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
@@ -2008,7 +2010,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (ctrl->queue_count <= 1)
 		return;
 	blk_mq_quiesce_queue(ctrl->admin_q);
-	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.41.0


