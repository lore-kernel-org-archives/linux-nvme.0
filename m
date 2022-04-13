Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9539C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vcpHMPI78hVeF0UKlQyHT2iUzctAZnGeDStcz8bop0k=; b=nBUIklawUb6IxetrVBG6LYO2L0
	wzwXZBkAt9YeupzgQmb6lPFjCOh9ll+hryJnrUBGszabvzS06VwpQS2zZk/XxlcIodW03ByTFGQ3M
	lNWpDLK11lubL+xPvu+Y4j8yqf1pimsdZqqJI6RA/iZAxOfM9kv4kgXmPjVCCjMXgE5AWR+a5qmFP
	Ri3wetWKXdUDMCD7J0/smUAy7iOGMgOczNgI9SCygNEK3BofNGQJALtNudFf7EhlwOaQI7UZItg+o
	UvQiUZwj8kj2ULnU+cnjMiAoXlLBVjfVdQlnOL6W1a2J14GR5EtrNgXrkWUb7CIoFv4x0LdNaWW3H
	Eu4VZnHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neb3k-000jir-Iu; Wed, 13 Apr 2022 11:21:16 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neb3e-000jga-Km
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 11:21:11 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 2so1671249pjw.2
 for <linux-nvme@lists.infradead.org>; Wed, 13 Apr 2022 04:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vcpHMPI78hVeF0UKlQyHT2iUzctAZnGeDStcz8bop0k=;
 b=BJZo2ubkTkzFPUsNDT7KPfUy0nY0a8jQsV3JeIfgcx/E7kQrUNz85JccW0bTCobZJK
 Xk1NVeBqvp/3qaumttUM3mMO13xDNRw8BhjEX1zMFmrm9WaOMK50VMvdIbuT094kcab0
 55KqPehgbpYT4rG6WFIkzJVaJJ5NMxw+Nox4Q5cmq5JTaM4orpqo5F5Kvb3zay979ghR
 0mJpbbPi7BAgjIoUNI4mOo2wdUAXdEvxicZoDBBuK3HY0A87ocUxzeqrVRzKAB2dBeIA
 KbhXR11ITiL9Lk6LmoOcKCbRjhe74pJeYyQ4d6H/8tjQm8OhGU2SB4FF0z/YVZXhlDzn
 eFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vcpHMPI78hVeF0UKlQyHT2iUzctAZnGeDStcz8bop0k=;
 b=Lx7+NMKAR/StI08Iq5vQrZyI3YWECSKMhACWsYrbc5/yH1vcfJ0BtvzeVFNYiMGtqk
 dDeuBr1eQUVBCI67q5E5C/3M9a3JNAyVO6w6jo2vf55tjj8XIsDwS1raH+uCBFJ5t0a1
 vz3HNNov4mJGyZssc0JiZ9sFF6EkrlnHlNpUfeE3v0VL6SATpuXKxTFeyY3O8qsUAylL
 Szhla9/irPISeaJjfdTPVn1o8ivTgTpsOeBDTkZBnOxJKTzAH3i5Zi3JdHPxGlPFXiJw
 tr255rETCnQKjUwERe5jmkQ/t0hEs+N44+jdk42eHOBu+A21R1IfmohHbB+pYekPPlT7
 cQfA==
X-Gm-Message-State: AOAM530mESuxf460q/9AsWf6Sh4fh8lweosI5wC2S8xbpGYxZVuwvkBg
 /tT2mP6+0iwk7V08Fsx/q9Cwuj8zGxs=
X-Google-Smtp-Source: ABdhPJz8erKhFNo0ll5Gx8k/axhk+mSr3/PJf2ppBVYx1K3jIQh4i9FBOC7DxLYDUxRuVMJ7bMsl3A==
X-Received: by 2002:a17:90a:ba15:b0:1c6:7873:b192 with SMTP id
 s21-20020a17090aba1500b001c67873b192mr10415214pjr.76.1649848866960; 
 Wed, 13 Apr 2022 04:21:06 -0700 (PDT)
Received: from ideapad.. ([161.81.112.246]) by smtp.gmail.com with ESMTPSA id
 p27-20020a056a000a1b00b004f3f63e3cf2sm47126421pfh.58.2022.04.13.04.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Apr 2022 04:21:05 -0700 (PDT)
From: Tom Yan <tom.ty89@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH] nvme: fix interpretation of dmrsl
Date: Wed, 13 Apr 2022 19:20:56 +0800
Message-Id: <20220413112056.126198-1-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_042110_721526_6326DE00 
X-CRM114-Status: GOOD (  11.82  )
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
 drivers/nvme/host/core.c | 6 ++++--
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efb85c6d8e2d..a01bc00f3f72 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1622,6 +1622,9 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
 		return;
 
+	if (ctrl->dmrsl)
+		ctrl->max_discard_sectors = ctrl->dmrsl << (ilog2(size) - 9);
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
2.35.1


