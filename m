Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC65CD6E4A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 07:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3LmA3WaTMG7OAWRgeiXus9O8phC2OkjC2j8xyhgOD/Y=; b=NBKSGcQ3WPB1wzxeEcvIH0krlo
	t3rWRdw18qs6BWXS2EXTgKJu1fPcSi3FphzO9uwEgzV2cM6BqvWNqvsGNJYL+C8p82XA7sp16Izsf
	/b508RgS4+Jtr3TTicPg6BUN9XB2q39FtPs1Yypa97ufRUR+6EA6WR8VUrMxrZynKL9yi495uAFOy
	HpuSvrDZHlb4nHB5WGrynsFeNDER2QxrqOyBAlDf6+uxR6Ln2PpwpV+7OjfXo9T8ipLDIeE/Mh5ln
	rFiDN94wHOrEM0dZ/Wihhh06eyp/oxg6ohbjhh7qzqE4hu2QMSVgoDNrhLw9RfplD0TQq5B8lAryw
	STyPLaPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUfwt-0000000ETW0-25MD;
	Wed, 03 Jun 2026 07:23:35 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUfwr-0000000ETVQ-1nBj
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 07:23:34 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2bf237e1433so53507225ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jun 2026 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780471412; x=1781076212; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3LmA3WaTMG7OAWRgeiXus9O8phC2OkjC2j8xyhgOD/Y=;
        b=Iibtle+r4D60KH5toLz0zkROS/6CT/2ANUR5WegoXEgyzRYq66/Rz+t15pNw/qoVb6
         +ngC8WZRnYYtqxr1ZYYfrVX1KfdT8zSut7+/ONNbq0ebAvgwhiimOw++AAOM8gOTOnI5
         BmUox1ZXMSDUhDK+TWLujNey/qguOMkC0iGx7Rfw57L9fIr9rEWIE6B0u60iAJCDJHJA
         HG+bPbkT6zTAS4XTExJhsQ/N80BVIrmRQFlng5BVJX9Ra1CSpkCI0UKMSgNx5pUaGaSl
         mRYd3/JysUsqPlc/R9XlHAFEORGp0vzQuVKmr0+cRpkbtRldaYywp5TmuXJrCJB6T4FI
         pajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780471412; x=1781076212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LmA3WaTMG7OAWRgeiXus9O8phC2OkjC2j8xyhgOD/Y=;
        b=BrhMDl8c/hvjY2SWp3+j7A4enj+SadOBmoe/5Rn54y6a3S+vrFjvkialLsx/WFX48q
         WFmN1i8yfxyGQKGr76/ZILwUHeUz3/6IXUDIUFUW6PWgiEqJ0AeX2fgH5GzbIc8T6wfY
         srkQh65GrrcpdD0Ex+3htvIQoHlgCPuKM0bgDg8B5F5OX3zURu25YuaFN0LrG8JYYufb
         iN9iK6i0VS2JkHI5VMLSjOIeh082Wo+uL/GksDolvRqHjMBt+vMm3lUGib35ZFbLynP+
         5G6qu3W6DNFkAhW91Qmpw9waXs4vlPEQl6GJwZScdt8QpfLLVTz9ywtcMdio22oZpKRS
         +I9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Ep5twwv/YmdgiCsfoZeybMmmV47fk+tmAyRy9FJ1FXECKtfAKwUUfZDqvzLfCEV3SZzI3Rv54arbf@lists.infradead.org
X-Gm-Message-State: AOJu0YyJSIszCkvozI+is9LcA0o53iOZ7wBh7zSvxWJqlcOiHU8UiSoz
	LPFzbjmDeYta3E1ngEe4Yzf4TD//sS4dUTymhvGAgzSJ+M3Kfx4kE5vm
X-Gm-Gg: Acq92OEH9gDe6zUbD4WgFbeO+XBLzwP6qlJXOrD0D8M4IWNnw7PaRTJQezGGH1fEHFr
	pEzaZ8WO1C5VD8Dky3qc2JjoLh1FLNHRkwBLt6nupNltuKzpXbN7uMNTly2ORW1e+iGF2KcwOOm
	bbtCSBQ/ehKJePfZ2DNlVdxxckyAx3A7g3O6UBWBM80eAJeXtqQRjkqVRHax4pw1l7/o/GaI7Xy
	XuG4ujCJZRZJk5A/kBF+NBe4XZjFXTbzMT+gV9KwOJ1sEhFR4QG/+yzPIFI3um2fOcUZBZQQo/t
	E26DcSqoDapmFZ9zyEcTrD+81MasBCVyKMYJa7rh0zpnEQuLXm2ukY4ozqEM0QGbgV85CpzBH2M
	PBsbfZNHgxMf5yoN/El79wW2QqTnhOJwXqOfm0JZwzEcYTrC5XzlOkGbeuDYB/nCyRL31W5bEHk
	FhHFCumXAvZBEh9vJnJqVzT/KFV9L4YgnOQkLq9aOfBkRFNTmbcxdLP6oCEzL45C3Dn6RX34App
	yPOnL6EmeR9X6E5Kr+OV775H9h5tcOEpuz3HTQC55Ozojb6+f3frOFBpuv50Ks3rXiATKK2kVis
	oGU=
X-Received: by 2002:a17:902:7b85:b0:2bd:8395:fed8 with SMTP id d9443c01a7336-2c1641b148dmr13579975ad.27.1780471412125;
        Wed, 03 Jun 2026 00:23:32 -0700 (PDT)
Received: from bass-virtual-machine.. ([111.202.175.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa072asm14750055ad.34.2026.06.03.00.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 00:23:31 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: sven@kernel.org,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	j@jannau.net,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH] nvme-apple: Use acquire/release for queue enabled state
Date: Wed,  3 Jun 2026 15:22:05 +0800
Message-Id: <20260603072205.3291888-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_002333_477829_A286889C 
X-CRM114-Status: GOOD (  15.10  )
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

apple_nvme_init_queue() initializes queue state and then marks the queue
enabled. The interrupt and request paths check enabled before using that
queue state.

The existing wmb() after WRITE_ONCE(enabled, true) orders the enabled
store before later queue use, but it does not publish the earlier
initialization before enabled becomes visible.

Use a release store when enabling the queue and acquire loads when
testing it. Keep the existing wmb() in place for the
store-before-later-use ordering.

Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
Found by auditing READ_ONCE() used for synchronization.
A similar fix can be found in 8df672bfe3ec.
---
 drivers/nvme/host/apple.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index c692fc73babf..fcaf8f230b19 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -151,6 +151,18 @@ struct apple_nvme_queue {
 	bool enabled;
 };
 
+static inline bool apple_nvme_queue_enabled(struct apple_nvme_queue *q)
+{
+	/* Pair with apple_nvme_enable_queue(). */
+	return smp_load_acquire(&q->enabled);
+}
+
+static inline void apple_nvme_enable_queue(struct apple_nvme_queue *q)
+{
+	/* Publish queue initialization before setting q->enabled. */
+	smp_store_release(&q->enabled, true);
+}
+
 /*
  * The apple_nvme_iod describes the data in an I/O.
  *
@@ -677,7 +689,7 @@ static bool apple_nvme_handle_cq(struct apple_nvme_queue *q, bool force)
 	bool found;
 	DEFINE_IO_COMP_BATCH(iob);
 
-	if (!READ_ONCE(q->enabled) && !force)
+	if (!apple_nvme_queue_enabled(q) && !force)
 		return false;
 
 	found = apple_nvme_poll_cq(q, &iob);
@@ -780,7 +792,7 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * We should not need to do this, but we're still using this to
 	 * ensure we can drain requests on a dying queue.
 	 */
-	if (unlikely(!READ_ONCE(q->enabled)))
+	if (unlikely(!apple_nvme_queue_enabled(q)))
 		return BLK_STS_IOERR;
 
 	if (!nvme_check_ready(&anv->ctrl, req, true))
@@ -1016,7 +1028,7 @@ static void apple_nvme_init_queue(struct apple_nvme_queue *q)
 		memset(q->tcbs, 0, anv->hw->max_queue_depth
 			* sizeof(struct apple_nvmmu_tcb));
 	memset(q->cqes, 0, depth * sizeof(struct nvme_completion));
-	WRITE_ONCE(q->enabled, true);
+	apple_nvme_enable_queue(q);
 	wmb(); /* ensure the first interrupt sees the initialization */
 }
 
-- 
2.34.1


