Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2354C001B0
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zCCJuLWxlzwZK4lPpl9OOBdDL3u1368YHPb0g0HV9fw=; b=KaSjqvQc6IQ2af4WLYEa8V42cA
	NzHpEjzrtvuVjU49/nkeXAkznIzFeF/NmX998PSmI+5tAoERzUPYYs6EtW/XAeJGiFhmz7fQM/+bP
	OVyDcP42Yy/WO/HOVcSGVOde99gVnJfdnDriQOTw0e9Fajb/FR9rLsm+3q2XlhX1KZC057Vgf6njW
	dY+wwfHiXcYv9SOwrdOwiSQDmdmG28AGO4UTyPyJJOiwSqpeuT/SMzfDtThGl7zrb6TQSn9KxoNRd
	Vd7GCrjevoe6ljIQTrfcC21T19O/Kj8yO56STzS5nq+xoq+x7Pyd5Q6W+J2jkJmDphLNI0XycLYNS
	ef3gBQ8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVC9h-00FEgt-2T;
	Sun, 13 Aug 2023 14:33:21 +0000
Received: from mail-ej1-f41.google.com ([209.85.218.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVC9e-00FEfu-2E
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:33:19 +0000
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-98273ae42d0so108578866b.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937197; x=1692541997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCCJuLWxlzwZK4lPpl9OOBdDL3u1368YHPb0g0HV9fw=;
        b=BNu/bvZ/ONX07HC+bDKezp5+dTedXmbbDYl51wJAdUDYGtvn28t7cJtFW+vfW0wbgp
         iy9wKr6pxqa/nxgyYN4YltwWliJzB3frVqXPyCHcJnTXFn9aiI4n0BVEhqKlMDEDvPL0
         rJaVkNm4GBabloVihiW7/M65ivCnniCaOoBA3/NRhn7WJaK9dGR8k79DGeuENafBsoj4
         ChM4Lob9OF52X41/T1f8R5mLig0eW2jPFu28LLx3PWniKr9bMo8oW+Ee+IN9eNdcrxS4
         6STOPx5qBmYeYjDVuyO8F7u2MxGvVbzwivT32Y6CU97g2HeZrOcjJY2e/j2AD7MbyPcm
         SPvQ==
X-Gm-Message-State: AOJu0YwXSTnKmogYcpXCFO5MBFDG0k7pMri5m0O16d3hMfdRr3GWWcXm
	dqdRyuxqthXplfyy6KINkkuIwinwkJQ=
X-Google-Smtp-Source: AGHT+IH/3SVrocrlNv7tLut8xuTnp+SfOb05qBfpzKkMLAjB1u5uRGZhVnFFHAar0t1m4vbV+ZvScg==
X-Received: by 2002:a17:906:220e:b0:99d:acdb:f709 with SMTP id s14-20020a170906220e00b0099dacdbf709mr330591ejs.5.1691937196739;
        Sun, 13 Aug 2023 07:33:16 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id l7-20020a1709066b8700b009737b8d47b6sm4598059ejr.203.2023.08.13.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:33:16 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: stable@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 5.10.y] nvme-rdma: fix potential unbalanced freeze & unfreeze
Date: Sun, 13 Aug 2023 17:33:14 +0300
Message-ID: <20230813143314.12684-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081243-sleet-native-6d03@gregkh>
References: <2023081243-sleet-native-6d03@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_073318_784210_A005FC91 
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


