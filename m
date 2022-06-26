Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21829C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jun 2022 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LcFT+IFC/EVw2VJs4MwIqxJpehaJ5qpuaU453u1nuRo=; b=4j1Lvfv/lF6OHAJ3sROnKOpMG8
	T7AABzr9p9cEHYQTvQlb86BLTmClRtRqdZ63puolJYOGuglMBpFjj1SWyVYpJUt5VRB6k4aktfrKB
	/VvNmJgw1c7lKJPj3I/Yv2Gj0mdWATgZ6IP/r026ay0Xz+mZJXbt27PVy5RUnnkucQ8ioG/ZVNhyD
	ET4zRGb193S201ZKCnuOUjFQqvaBQSRLzyXLIqmzjpitU9MKtBowa5Kzbe/t8JIWrY8MGDpvBlU4M
	ur4NOrp0nIv0dEGwU9GIFKmDHWIFN3WnioTtOKu4xJgg2WovqtwLvOD1i8aQGFqZTXxUQIjuhAegX
	OxhfmrTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5Str-00C5VK-5A; Sun, 26 Jun 2022 14:06:07 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5Sto-00C5UC-Hd
	for linux-nvme@lists.infradead.org; Sun, 26 Jun 2022 14:06:06 +0000
Received: by mail-wr1-f53.google.com with SMTP id v14so9512076wra.5
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jun 2022 07:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LcFT+IFC/EVw2VJs4MwIqxJpehaJ5qpuaU453u1nuRo=;
        b=ZFxNM4RZrLFqZOlyW4rxyqQKD+CswqwAdkf4i6sZgdaf2dnZ+1tIOhknPCPk2TDwca
         LT22n+/Bv+e0BEiixUZfyO+R7k++L+BsaWLLdAaIx6s7s7B1+57PJ0vBTohpqf9jYPoy
         Ei9Lhxc0UjzcQL9sjMsqVbF4hw6dlM7vTAdVg0QhDdST1NaZuWxJzalc339nnZdjCevI
         QGk+Z1imGMwlpV2omuPapUh/qriLUeieQNfxq2/oVrUfN2rFSBzdZfxKXHclYx1eKCPF
         lUuQG7BjPztq/Bc1+BJaHt7FlThxv5ZHi1DRl0oAuxmxS9hoclyzBZQXSROJMsKYQAv1
         Y9QA==
X-Gm-Message-State: AJIora/iM2vZSdeLLLu1ar5JiIc8ZhKaJZMNNOk7VkcM1M2zSi7n7MPI
	sk+UpDsdkydaWGMU4Rt5MWr9LH5kn2U=
X-Google-Smtp-Source: AGRyM1sTbRgf+q16yvgDTwawz496AFwyK8o5Ri0KjGdjlVeg0mHBTpp9P76QgWZ0UEjGWKn69thfdg==
X-Received: by 2002:adf:f90c:0:b0:21a:3dcb:d106 with SMTP id b12-20020adff90c000000b0021a3dcbd106mr7930609wrr.448.1656252362540;
        Sun, 26 Jun 2022 07:06:02 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d560a000000b0021b9270de3csm8092220wrv.10.2022.06.26.07.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 07:06:02 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-loop: use nvme core helpers to cancel all requests in a tagset
Date: Sun, 26 Jun 2022 17:06:00 +0300
Message-Id: <20220626140600.81362-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_070604_623047_7A0BD864 
X-CRM114-Status: GOOD (  10.09  )
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

A helper now exist, no need to open-code the same functionality.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/loop.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 59024af2da2e..9c9c428ae538 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -424,9 +424,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 {
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-					nvme_cancel_request, &ctrl->ctrl);
-		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
+		nvme_cancel_tagset(&ctrl->ctrl);
 		nvme_loop_destroy_io_queues(ctrl);
 	}
 
@@ -434,9 +432,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_cancel_request, &ctrl->ctrl);
-	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
+	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
 }
 
-- 
2.34.1


