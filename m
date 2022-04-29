Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6FEC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Apr 2022 04:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CpHg0HOnrWGa7Tx3F4NtSSZJIeOXY1dG95Z14kQlUe4=; b=ehfw5k1EpZft493WjYKLpoyCTo
	pMo4w+VWP7MACe5n20FbXakOeAdh0RaNb76+vaQIBjdEBxYQxHb4gz31WgXfi+JIWtCPo5lrDBsBV
	qAKfl1jeccx5To3lNrISA/j5uE0aJwT2UxeLKOtIAyuH3ZvcL4VxGowS+l+ExkYAFpnoeH+ecT8Qp
	QUOkaG6CMuT5ViMqmPVUl/mz1xAu8c3H0F6hTPKE7wG3k7qNBdDYFgFC9CUNGHaTcYeHwDUqnLMi2
	wnFH49H2iP6DcdBPZmeidw3zQSj1aA6/bIkf2uiiRoqNrWspHvxy+hxCw+vVfNympM0wsFhgZDuNI
	BksCePyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkId3-009Xzw-Uv; Fri, 29 Apr 2022 04:53:17 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkId1-009XyW-Fq
 for linux-nvme@lists.infradead.org; Fri, 29 Apr 2022 04:53:16 +0000
Received: by mail-pg1-x52c.google.com with SMTP id q12so5640374pgj.13
 for <linux-nvme@lists.infradead.org>; Thu, 28 Apr 2022 21:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CpHg0HOnrWGa7Tx3F4NtSSZJIeOXY1dG95Z14kQlUe4=;
 b=DZMevS/xWwWuxlsf4gXFc5HFAxDgVPrVGKnpGs5yz3v+xhXGSdkefJ4PTslZ7NFvtA
 fr/gXs/8hNU8W1BP3TTFETBnC2SLptOsN/PHR84/pBh/5sWKc0JlOoa1y6aY/zLWFy82
 i1uLqYX3SAZJCybjWKKTXy16fKbQhgNPpu4IWwyrAfVyQ6ja3dhBSYTbx2VfGRPGWxf9
 oSbMUuU1+XV48SUjROU2CeaNgFoTsBjcg2EON0iPB3K9aKkHNsiFMYR/1Bl8qbBao+0W
 SN9RUUiQ4MvY554bRZGt1eQ645hUFkHuWjv/kYB8m1LErjPuNE0SOCiVNBdEdlGikGoc
 F3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CpHg0HOnrWGa7Tx3F4NtSSZJIeOXY1dG95Z14kQlUe4=;
 b=yCaXdZSC1omZCdnA9y6FzA6lnyVhYiBv6fJZsVNsqLMVFxrx+praHs2jNEAjOoW4wW
 o5uGy74KbjKePducK1sAvYAgfm20PwYkoPqdsli0UloPkReU4kaBj4EJZJ11sVdprejL
 Jzrq1OYiLFFbIrLOLxP07Sl5V/3jVrIGaQ2vSMqS45Oprb3dIjuPY+jHLE5acrZrWt47
 uqzYuRCaysu57pXeGfWFyRvZTsSwh+YubBSZwCEBfGu0Aw1l1pQvJ9kkxmWWDamoLBHt
 r+OqocT/EaW3mZvjyh7LX3MF9rColpL3GiEukoEuTKYdJiNYCAyVPCpMohENGUxWb4qU
 rOEA==
X-Gm-Message-State: AOAM531tC47XTHVj1ABWR4DBxotVSSRAnFTgwGsPtnAu9ZIOlkJ6YtfW
 p41Oy72hGFaD9C5MIvtlA1NaFL562r8=
X-Google-Smtp-Source: ABdhPJzVEfIZ4B6o8d4oA2XogFjKxbre2TBkI06iQmXq+F0BQmpZtPZ54QQQKfj+NQV8PLcymVsJQQ==
X-Received: by 2002:a05:6a00:26cf:b0:4f6:fc52:7b6a with SMTP id
 p15-20020a056a0026cf00b004f6fc527b6amr38106327pfw.39.1651207993215; 
 Thu, 28 Apr 2022 21:53:13 -0700 (PDT)
Received: from archlinux.. ([161.81.112.246]) by smtp.gmail.com with ESMTPSA id
 g11-20020a63110b000000b003c14af50614sm4334507pgl.44.2022.04.28.21.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 21:53:12 -0700 (PDT)
From: Tom Yan <tom.ty89@gmail.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@infradead.org,
 sagi@grimberg.me
Cc: Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH v4] nvme: fix interpretation of dmrsl
Date: Fri, 29 Apr 2022 12:52:43 +0800
Message-Id: <20220429045243.324403-1-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <YmrMSGDDn3UMnJ8t@kbusch-mbp.dhcp.thefacebook.com>
References: <YmrMSGDDn3UMnJ8t@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_215315_556321_FF1E3393 
X-CRM114-Status: GOOD (  12.32  )
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

dmrsl is in the unit of logical block, while max_discard_sectors is
in the unit of "linux sector".

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
v2: ignore dmrsl if its sector-equivalent is larger than UINT_MAX
v3: put the lts_shift declaration before code
v4: make use of nvme_sect_to_lba() and nvme_lba_to_sect()
---
 drivers/nvme/host/core.c | 6 ++++--
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efb85c6d8e2d..8e06a6d675ef 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1622,6 +1622,9 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
 		return;
 
+	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns, UINT_MAX))
+		ctrl->max_discard_sectors = nvme_lba_to_sect(ns, ctrl->dmrsl);
+
 	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
 	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
 
@@ -2881,8 +2884,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 
 	if (id->dmrl)
 		ctrl->max_discard_segments = id->dmrl;
-	if (id->dmrsl)
-		ctrl->max_discard_sectors = le32_to_cpu(id->dmrsl);
+	ctrl->dmrsl = le32_to_cpu(id->dmrsl);
 	if (id->wzsl)
 		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1393bbf82d71..1c85edcf7dbb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -279,6 +279,7 @@ struct nvme_ctrl {
 #endif
 	u16 crdt[3];
 	u16 oncs;
+	u32 dmrsl;
 	u16 oacs;
 	u16 sqsize;
 	u32 max_namespaces;
-- 
2.36.0


