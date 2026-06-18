Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B902CD98E4
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2026 02:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G6bgdFP6eQHqUIHYA197THpQx8Z+j/fXy0gSUXkLpxo=; b=Qz23pn19NJRB8KMlRPwBwxXGyq
	XS9g6m+FYp37goL6kW9ALQOpKcmaxwgoeETY9XTNbXeE95n9d6dn9pngght8jAJ7i9MZVBVm1PQ79
	lMvJ7meIUJf3gZqUJa8scg9WmnMVI5iVmmhlkrbeYDeAxvt/lPOlZMMy2jd5R1uOYcPL0V4FG7GSf
	y6mqSsF7YIc/D8nrKgi1QdkvadW4dZoP1UkmYtlFbMZcxZp1OGPNKt1URsIFx6PjJ7Hmo/F/ZUFht
	G0/qFirF1s8cRlq/dYuYyMI5nqliHCVTGqWq6b1RgQkvR1qv1A6Y/dwZNF0KYHNXmQkpouBw9ufir
	oQdTt4eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa2JL-00000000WG0-3N8q;
	Thu, 18 Jun 2026 02:16:55 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa2JF-00000000WFI-08X0
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jun 2026 02:16:50 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2c6ec0af575so1127085ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jun 2026 19:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781749008; x=1782353808; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6bgdFP6eQHqUIHYA197THpQx8Z+j/fXy0gSUXkLpxo=;
        b=sIUOIy+eNwGrDjCDUUJiRjjzYOQIMxMXS1gfav83j0Wfpycwr+/lD/Q20q6u1F2xF+
         zXl9SpbI6iT4oatxq0HZRoquLBe2yaoJNgkDMyweFbzocqIN7Ks5AJAQSbggTqTVAeVv
         BxNKBWSBzy+ogLqaZu+mhhpZrTY5TFlU52s7dYCdH/z4dUrh6qWQYXBh5vmNhfOxPnvP
         dXrBBb1QaioK50v5QaHqJj5Lu634OEntLlP5qxtA2+m6859s4ozne70OxbP8MPqLBvs3
         ma9Yu/M2VuUvRfkfmU+kB0o0IaeO5V44MgQBOCrvRcXnKeVyZjWdTy61ELb8rBtrbj5/
         HLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781749008; x=1782353808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6bgdFP6eQHqUIHYA197THpQx8Z+j/fXy0gSUXkLpxo=;
        b=ehXAkKuXCGApOgQGn5kgza19LNlhMvw3K8opu6Iylh499WUjUqMV8ISCvrwr3i3zcR
         eq9sGxF0MazUf9h7CRMPns+JweA1oRpVsbax0wW+1V5ZeXCYHSh3517Qy7rUQQEmt0BI
         qcjQyM28rAXn+st5Tqf3w6eNmROS19vEQ/ojfNC1MyRUb7qllFLxlcKWqsS29ZAZvsxZ
         ORygiMmoeI7SdmmdYh+3eZVANv1iPMD5P3H+CMqRP54b7eUNznLICzy9M9/lLWQFKY29
         aK15A02g2YX+x+r/EIExA464Dq5Vo5Y5bAbokA3AN5jQxsS2T+K2U+ueDcXeSGgKPW0u
         E4eA==
X-Forwarded-Encrypted: i=1; AFNElJ8nBZZ1y2ET642OCnWwiu+0tZ7AvrOA8gVJqda/mTN8Aj/VvlPMkD0rBXiN/Xu3XsSYt9NmPv2sm1Fh@lists.infradead.org
X-Gm-Message-State: AOJu0YylcWEXCDWK/J7UJ+Bhy+dSZ7rMNaeo7ALy0LmBV/b9xPE+Ta5h
	RneFqhEIFGGBBIVng70BrXyTt3iUKucGcBvpZph6DdIGFcUJQNb4Fqyj
X-Gm-Gg: AfdE7cnGAbGqzVziEbL0/B3DFkC3FrIIZvhz2wVSZNV9M75hKPxnYvQAbPjtmVlVbVx
	LLvY5rldELv8ADSPdpw2I13SvhsIOC778JLhpqsd3EYlCCUiDWfwIvXszA4PFWau+gXB73NjwNQ
	FEAXDGYR+C6RLyXwta9pWiCGIBJzsvKsWWiFLdaxW/PmDt2UVqYWMhxP5Jm2NGmnHci5faynU2S
	JM9OpqTMYY0GvJ62kJ+FxrttMVGT5Lm78lBFTfO1QhDDKGrAMyZHWEf9mC6b/m2CyrXTTiuk0/s
	GeZY423uTgfXtRJhekQ79yhOSjUfXVsQmFVzXsQlfSX7m0pl3FBNYjbNwKiLgNPjkbwMOLEB3ER
	YIn1tBnKCFUQv03ilshDyuVAfpsBm5oS66imPnHOb0WN8qSJc+Gq1qyI16GXQ++tZiTb48KZJ79
	FplNmKUhGA3wq5KXLJwjuUxULWLFasQF8vimOQuNWybKw7AUhu08IOczVhKXeyXR/g3eQEjBe++
	g3urBcXdu76bDP7uY8faQvwZU+uGTdDK9z6HkxPPTuCQwI=
X-Received: by 2002:a17:903:19ed:b0:2c2:50c7:58a4 with SMTP id d9443c01a7336-2c6bc223ee0mr64827035ad.22.1781749007689;
        Wed, 17 Jun 2026 19:16:47 -0700 (PDT)
Received: from bass-virtual-machine.. ([111.202.175.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a1878493sm61854705ad.81.2026.06.17.19.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 19:16:47 -0700 (PDT)
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
Subject: [PATCH v2] nvme-apple: Use acquire/release for queue enabled state
Date: Thu, 18 Jun 2026 10:15:43 +0800
Message-Id: <20260618021543.3866850-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_191649_076945_6FAB5284 
X-CRM114-Status: GOOD (  15.83  )
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

The old wmb() after WRITE_ONCE(enabled, true) does not publish the
earlier initialization before enabled becomes visible. Use a release store
when enabling the queue and acquire loads when testing it.

Although the shutdown-side enabled accesses are not used for publishing
queue initialization, use helpers for them as well for consistency.

Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
v2:
- Drop the old wmb(), as suggested by Keith Busch.
- Use the queue enabled helpers in apple_nvme_disable(), as suggested by
  Keith Busch.
v1:
- Found by auditing READ_ONCE() used for synchronization.
- A similar fix can be found in 8df672bfe3ec.
---
 drivers/nvme/host/apple.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index f9327feb87d0..291271c3954b 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -151,6 +151,23 @@ struct apple_nvme_queue {
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
+static inline void apple_nvme_disable_queue(struct apple_nvme_queue *q)
+{
+	WRITE_ONCE(q->enabled, false);
+}
+
 /*
  * The apple_nvme_iod describes the data in an I/O.
  *
@@ -677,7 +694,7 @@ static bool apple_nvme_handle_cq(struct apple_nvme_queue *q, bool force)
 	bool found;
 	DEFINE_IO_COMP_BATCH(iob);
 
-	if (!READ_ONCE(q->enabled) && !force)
+	if (!apple_nvme_queue_enabled(q) && !force)
 		return false;
 
 	found = apple_nvme_poll_cq(q, &iob);
@@ -780,7 +797,7 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * We should not need to do this, but we're still using this to
 	 * ensure we can drain requests on a dying queue.
 	 */
-	if (unlikely(!READ_ONCE(q->enabled)))
+	if (unlikely(!apple_nvme_queue_enabled(q)))
 		return BLK_STS_IOERR;
 
 	if (!nvme_check_ready(&anv->ctrl, req, true))
@@ -863,7 +880,7 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 	nvme_quiesce_io_queues(&anv->ctrl);
 
 	if (!dead) {
-		if (READ_ONCE(anv->ioq.enabled)) {
+		if (apple_nvme_queue_enabled(&anv->ioq)) {
 			apple_nvme_remove_sq(anv);
 			apple_nvme_remove_cq(anv);
 		}
@@ -887,8 +904,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 		nvme_disable_ctrl(&anv->ctrl, false);
 	}
 
-	WRITE_ONCE(anv->ioq.enabled, false);
-	WRITE_ONCE(anv->adminq.enabled, false);
+	apple_nvme_disable_queue(&anv->ioq);
+	apple_nvme_disable_queue(&anv->adminq);
 	mb(); /* ensure that nvme_queue_rq() sees that enabled is cleared */
 	nvme_quiesce_admin_queue(&anv->ctrl);
 
@@ -1016,8 +1033,7 @@ static void apple_nvme_init_queue(struct apple_nvme_queue *q)
 		memset(q->tcbs, 0, anv->hw->max_queue_depth
 			* sizeof(struct apple_nvmmu_tcb));
 	memset(q->cqes, 0, depth * sizeof(struct nvme_completion));
-	WRITE_ONCE(q->enabled, true);
-	wmb(); /* ensure the first interrupt sees the initialization */
+	apple_nvme_enable_queue(q);
 }
 
 static void apple_nvme_reset_work(struct work_struct *work)
-- 
2.34.1

