Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857DBC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1XLIoJNlnj/5CWq4CAjm0tQrHzeA6Vo2r7XIXxmhit4=; b=FsIs/EcPexdPvscViYaDUKXJN6
	bJj3qzr1qa1FzXtqyD3Li7ezxaZXb9/6Pt+KH+M4T5pHA148QxxfAsQiz3tmGidupXX1TKzLGEVQ+
	tGpoBocg4jsLWiSYG6m4ZRI1pJ7P1/q8QWOIF8NjrHY3HKYZZldz6l0nA3Tz9GBHIoEB/X3F33wnp
	zFVGF7SxI+cTvy2A900jRCj6wp4gi12z/t+QX2OdeCny2W/v1Lxde/bxJJRTF1fE1oHaQg6m37CB5
	qflFikbcAl8ZC+OFo/12ZknbX5CmUduzeQcadzpfZsOm5rsl/VhkOaZrY/PnO8EMgF0DCsMIFq5Ar
	FXA8bnUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk7M8-007xbJ-Cl; Thu, 28 Apr 2022 16:51:04 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk7M5-007xZe-HA
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 16:51:02 +0000
Received: by mail-pl1-x62b.google.com with SMTP id b12so4879257plg.4
 for <linux-nvme@lists.infradead.org>; Thu, 28 Apr 2022 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1XLIoJNlnj/5CWq4CAjm0tQrHzeA6Vo2r7XIXxmhit4=;
 b=YICBhFJ2cma002JpWgdzV7ZUIHso0CtyKLI8puo38HTCk2U9f2IleI7/AD3yINdud3
 eoHiQJqjSWkY74kcSgfqjtv7iXMOqYFaYm3UM5liUxtryn6l3AyNoUtQcotPnPhZoCZP
 cf/LvuKBKFUs2oAMoQLVDKoS/nYCuJedLucFiquzSEijbdY3qseaeyROF6EVgcc+IQmE
 0xegWaNGwYKRRrHg/bBNbNUN/pZ8PvR4BEcI0CKSOSWAV8qQJHswvo7+MoK+kpFaOHh0
 eRt0E98IFcnDzgaaemshjy/MW56ExOgz0y+lw0QGTm6xJEXG8owRqhYSitTMLCBo4//l
 EgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1XLIoJNlnj/5CWq4CAjm0tQrHzeA6Vo2r7XIXxmhit4=;
 b=lJiYacCDJGhZDxD8eg4oCAuc6jvC17jSghUeE7/ZNMo7zz5WcpAMrQTvzRsc/8FNpf
 ZT3qbJ7f78X1C1LpfintZUrCfEalaX1QI8fokFv3BmIA/W1/hbOqflGRjxpIN18w4ubp
 12ETDdAtl+52/NifMIFIll1kh+1FYTsrnR1P/F9suj/cRCom38obJ06YflYTH+yQR8Dx
 /8teHeq5MXbymYwjXEYAVF026sGtDuwMyfvesfRlIKjNZrov6Y3lRwzo79ryobiAQuSS
 lfXRGg1Fn71butTrcdddcgo1dHEABC2GvJhyl3Io0IvMnCWsFMY6FmVbGcIftkF7CFz8
 jXvA==
X-Gm-Message-State: AOAM532MdEX1rDnjAJz5RP7T0N8Mf6C6HoOQolCmIRVWU/eqOEozihrF
 mnyO/aaMjOTIyZsoasvj5cLDdrWZdJw=
X-Google-Smtp-Source: ABdhPJzLYjUw8uZ7DLpDYPsKf6GJh7XC4sni75x5wnvgM1U0Upoa0qld6dDsJ+v6wnDMIhXlQwTPtA==
X-Received: by 2002:a17:90a:589:b0:1d5:e1b1:2496 with SMTP id
 i9-20020a17090a058900b001d5e1b12496mr44246456pji.209.1651164659170; 
 Thu, 28 Apr 2022 09:50:59 -0700 (PDT)
Received: from ideapad.. ([161.81.112.246]) by smtp.gmail.com with ESMTPSA id
 u4-20020a62d444000000b0050d5b6bd65dsm372871pfl.66.2022.04.28.09.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 09:50:58 -0700 (PDT)
From: Tom Yan <tom.ty89@gmail.com>
To: linux-nvme@lists.infradead.org,
	hch@infradead.org,
	sagi@grimberg.me
Cc: Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH v3] nvme: fix interpretation of dmrsl
Date: Fri, 29 Apr 2022 00:50:51 +0800
Message-Id: <20220428165051.4708-1-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <YmquYxXtGXlNB0PL@infradead.org>
References: <YmquYxXtGXlNB0PL@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_095101_598527_0947435B 
X-CRM114-Status: GOOD (  14.07  )
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
---
 drivers/nvme/host/core.c | 7 +++++--
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efb85c6d8e2d..8bee0d139fd6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1606,6 +1606,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct request_queue *queue = disk->queue;
 	u32 size = queue_logical_block_size(queue);
+	int lts_shift = ilog2(size) - 9;
 
 	if (ctrl->max_discard_sectors == 0) {
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, queue);
@@ -1622,6 +1623,9 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
 		return;
 
+	if (ctrl->dmrsl && ctrl->dmrsl <= UINT_MAX >> lts_shift)
+		ctrl->max_discard_sectors = ctrl->dmrsl << lts_shift;
+
 	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
 	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
 
@@ -2881,8 +2885,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 
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


