Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF1AC5321E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qrOsx2LgGspaPfv+eO8KAtMHfxsNHZqd05qu2KKjOW8=; b=yTxLoiGLMtHUv7rcGxbEa3YhK9
	tp0bozI9P2aSkxt695eG8Cso7MQ3Fsmm4heGsrhVZUGB7C2iZfKOOd0XPkoQc9iXIHMhX4OMBZRMY
	2TaV8SwI+v/o1GSSSGw4pTwk6gEQ+WkukNdCaw8BMR3Lic2wvOApGvED4PjM8cL5EPKmXKciyl+im
	AVeYyz1/v8LTmHdZ+kIeDD2uCQ4ed/mfeZnkK/IBpSijPyL7uzljp+jmMrccbQr83bg6mg2f8LGv8
	sDOrCymalJajdKExHGYStIrkBjz/GmEyh/sHE5r+BINFaIEWljcYk1YGbpE/nc5wigUzNIzSc9wEE
	fLgiwk4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sicqK-000000084Po-3OZr;
	Mon, 26 Aug 2024 16:45:24 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siclC-000000082zh-0CpN
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 16:40:07 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3718ca50fd7so2745655f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 26 Aug 2024 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724690404; x=1725295204; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qrOsx2LgGspaPfv+eO8KAtMHfxsNHZqd05qu2KKjOW8=;
        b=IVQnrkMPaufWVlPhyxxc8pY0YFOIek51uZA77G6UB/uLcOJlg3QrgaHqFZD/qIeNp1
         CLza6S6XB3p7cewulS/PdwYNKtxtWEM0hf45/YfFWdRE2//uHPGw8rbMZ4JLEIJR6rcF
         V0zoqFifjEWPVre4NoPw42Ot8ugPddsluZ1PHTV6HtM3DqWzid+7sqX8Fb6eyP/O89V8
         Yr6XVpcjPMjNNtePAU4DgmAyUsAo576TSVV0JoyLOfRdREwMbidY+uzYg4PfIarnxa72
         ph+DYLY3H3Ot3uo7uyV3VUXcKOklMdM0S1zMt+EmWdm8mbZ8xObS/8dM6YrjAs8DTUmw
         INvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690404; x=1725295204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrOsx2LgGspaPfv+eO8KAtMHfxsNHZqd05qu2KKjOW8=;
        b=GFzv0ZhSw3kqo6SzufMhtvZJABsLQN3AxraGFCNxm3lQuwUqR8cnLeclNVQDC6vBJO
         lLO8z75FeUTZplrgnY9b2jjf7fSvb/79Y4jhRYdC9F46JFyQFQNvnrKXhZ9dWsu7lZiZ
         uxWv81KbbzB+hFxQ0ZlJ6I3CFvdUEWNMvmqw1LvtU7onUFAKMgds2QVnyAJz4TiburUe
         73uXfVd84C+7l0gS21i+RckLkfo9JN9kBzoTHoUVIa4I5VoM95Pd9peYrMazjrXVMF2a
         7tLZiEsNM41fa/j28hGLO9gcFnxQHGerM/VtZ81eVJ71wkCug63ckabDWIXibGaahhXV
         qf8g==
X-Forwarded-Encrypted: i=1; AJvYcCUkhJfAZSiqnAvQv3CiZ1iB6rzD0i1Sq76tbgWOWFPbVznytnVL2rSGp/Fo4nAq6P/jZENOmgSOqhrc@lists.infradead.org
X-Gm-Message-State: AOJu0YzO2Yg/fgTHB6jkN3eM2nJ+OogfDVDnQ2GzE+L+0ZoOkDJBLNVH
	LpdkzwbfCb4SSYdz9i2BwUEpBpoubChEM806NINAq3Rx1+1Mn9ND3p0d4vm74dE=
X-Google-Smtp-Source: AGHT+IFDI8Raf4TCT+b976xlZ5ll6JnzcIrEkMlufBTSW7o+PdXlGtz653UMtgXMHCkDihqpS3MvkA==
X-Received: by 2002:adf:b31c:0:b0:371:8eea:24b1 with SMTP id ffacd0b85a97d-3748c826b00mr153677f8f.59.1724690403425;
        Mon, 26 Aug 2024 09:40:03 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a868f436322sm688354466b.117.2024.08.26.09.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 09:40:03 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v3] nvme: core: shorten duration of multipath namespace rescan
Date: Mon, 26 Aug 2024 18:39:51 +0200
Message-ID: <20240826163951.68078-1-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_094006_123319_BBDF0ACF 
X-CRM114-Status: GOOD (  26.20  )
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

For multipath devices, nvme_update_ns_info() needs to freeze both
the queue of the path and the queue of the multipath device. For
both operations, it waits for one RCU grace period to pass, ~25ms
on my test system. By calling blk_freeze_queue_start() for the
multipath queue early, we avoid waiting twice; tests using ftrace
have shown that the second blk_mq_freeze_queue_wait() call finishes
in just a few microseconds. The path queue is unfrozen before
calling blk_mq_freeze_queue_wait() on the multipath queue, so that
possibly outstanding IO in the multipath queue can be flushed.

I tested this using the "controller rescan under I/O load" test
I submitted recently [1].

[1] https://lore.kernel.org/linux-nvme/20240822193814.106111-3-mwilck@suse.com/T/#u

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
v3:
 - added an out label and reversed the ret logic (Sagi Grimberg)

v2: (all changes suggested by Sagi Grimberg)
 - patch subject changed from "nvme: core: freeze multipath queue early in
   nvme_update_ns_info()" to "nvme: core: shorten duration of multipath
   namespace rescan"
 - inserted comment explaining why blk_freeze_queue_start() is called early
 - wait for queue to be frozen even if ret != 0
 - make code structure more obvious vs. freeze_start / freeze_wait / unfreeze

Hannes and Daniel had already added Reviewed-by: tags to the v1 patch, but
I didn't add them above, because the patch looks quite different now.
---
 drivers/nvme/host/core.c | 88 ++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0dc8bcc664f2..13164ca866ea 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2215,8 +2215,20 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	bool unsupported = false;
+	struct queue_limits *ns_lim;
+	struct queue_limits lim;
 	int ret;
 
+	/*
+	 * The controller queue is going to be frozen in
+	 * nvme_update_ns_info_{generic,block}(). Every freeze implies waiting
+	 * for an RCU grace period to pass. For multipath devices, we
+	 * need to freeze the multipath queue, too. Start freezing the
+	 * multipath queue now, lest we need to wait for two grace periods.
+	 */
+	if (nvme_ns_head_multipath(ns->head))
+		blk_freeze_queue_start(ns->head->disk->queue);
+
 	switch (info->ids.csi) {
 	case NVME_CSI_ZNS:
 		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
@@ -2250,45 +2262,49 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		ret = 0;
 	}
 
-	if (!ret && nvme_ns_head_multipath(ns->head)) {
-		struct queue_limits *ns_lim = &ns->disk->queue->limits;
-		struct queue_limits lim;
+	if (!nvme_ns_head_multipath(ns->head))
+		return ret;
 
-		blk_mq_freeze_queue(ns->head->disk->queue);
-		/*
-		 * queue_limits mixes values that are the hardware limitations
-		 * for bio splitting with what is the device configuration.
-		 *
-		 * For NVMe the device configuration can change after e.g. a
-		 * Format command, and we really want to pick up the new format
-		 * value here.  But we must still stack the queue limits to the
-		 * least common denominator for multipathing to split the bios
-		 * properly.
-		 *
-		 * To work around this, we explicitly set the device
-		 * configuration to those that we just queried, but only stack
-		 * the splitting limits in to make sure we still obey possibly
-		 * lower limitations of other controllers.
-		 */
-		lim = queue_limits_start_update(ns->head->disk->queue);
-		lim.logical_block_size = ns_lim->logical_block_size;
-		lim.physical_block_size = ns_lim->physical_block_size;
-		lim.io_min = ns_lim->io_min;
-		lim.io_opt = ns_lim->io_opt;
-		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
-					ns->head->disk->disk_name);
-		if (unsupported)
-			ns->head->disk->flags |= GENHD_FL_HIDDEN;
-		else
-			nvme_init_integrity(ns->head, &lim, info);
-		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
+	blk_mq_freeze_queue_wait(ns->head->disk->queue);
+	if (ret)
+		goto out;
 
-		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
-		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
-		nvme_mpath_revalidate_paths(ns);
+	/*
+	 * queue_limits mixes values that are the hardware limitations
+	 * for bio splitting with what is the device configuration.
+	 *
+	 * For NVMe the device configuration can change after e.g. a
+	 * Format command, and we really want to pick up the new format
+	 * value here.  But we must still stack the queue limits to the
+	 * least common denominator for multipathing to split the bios
+	 * properly.
+	 *
+	 * To work around this, we explicitly set the device
+	 * configuration to those that we just queried, but only stack
+	 * the splitting limits in to make sure we still obey possibly
+	 * lower limitations of other controllers.
+	 */
 
-		blk_mq_unfreeze_queue(ns->head->disk->queue);
-	}
+	ns_lim = &ns->disk->queue->limits;
+	lim = queue_limits_start_update(ns->head->disk->queue);
+	lim.logical_block_size = ns_lim->logical_block_size;
+	lim.physical_block_size = ns_lim->physical_block_size;
+	lim.io_min = ns_lim->io_min;
+	lim.io_opt = ns_lim->io_opt;
+	queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
+				ns->head->disk->disk_name);
+	if (unsupported)
+		ns->head->disk->flags |= GENHD_FL_HIDDEN;
+	else
+		nvme_init_integrity(ns->head, &lim, info);
+	ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
+
+	set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
+	set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
+	nvme_mpath_revalidate_paths(ns);
+
+out:
+	blk_mq_unfreeze_queue(ns->head->disk->queue);
 
 	return ret;
 }
-- 
2.46.0


