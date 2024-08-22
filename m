Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606C5C3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 20:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E8qq1+rJTV6QlIcBlmP32ULiTU79Wc7hdDRM7Jn604E=; b=tEGHWe6WWeIrVfcGNeUVJXykC6
	NA03UId0C0daDiL6UMHIvFolvX4q14vX4htTpKIIpVXq5oSBdVxzcxG/ZsFpBLfWFUCPMWhXprfZw
	QOmlimSaqp62248don/vz4p8ncI29D71crOQMVkZUKWCo6uF610u7oY1b3x+ikBTFGdk3Yot0XgA/
	lSr9PKzMMo879mzbfy7n8nPeQG2bnN8oDcJPNXNUYXJOri/A7T0EPyECqBMoUy8dBeYMJBfrigzBO
	Pbeqxqv6BQgVMNfg82siEWeXh2Vi9hYI4gU6eiVtHjV0Zxcldo3YSltUxAmsaPw++VFGxqecKukWY
	64M9U8+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shECL-0000000ECFZ-3bMc;
	Thu, 22 Aug 2024 20:14:21 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shECI-0000000ECEg-1aNW
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 20:14:20 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a8679f534c3so153655766b.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724357657; x=1724962457; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8qq1+rJTV6QlIcBlmP32ULiTU79Wc7hdDRM7Jn604E=;
        b=apc7DpQPcDbHY/DpMBGlVEpVx0uMXK23KCrX4PUSEIZV59tPPXRdKS6HK74QZD47so
         byLrAR/ygBuHfavX7vGb1atu0mELUAHKp4WFXzL7Sltp5vzgMScrGYkZqVVOzGXqVe+5
         5vgk+3kKYSvRGD+MXcuBZ1fQ683h0a23FZ6N4DojTZ4PCfORHHhNRxebBbkUfkcNhRMn
         ULSDt8O+1sl2aAblSP4IJ7BQ5lR0SPP1mkUO2/UC/jrOXRz1FxJyzXtvUaxLe/sz5wtU
         n/6W4UmWEvDYlzM96T+WfadGGbx4NUAIuZhRMJQCUKf8YNqJ6hcUyZT5Ve5bwxtIbwYi
         o9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724357657; x=1724962457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8qq1+rJTV6QlIcBlmP32ULiTU79Wc7hdDRM7Jn604E=;
        b=KyGjNcF01E8eQN7nfbMaY1gjt0MCSyCOHDI6G5NIEzwPUvq/yje+Q4TB1oyY45m3z/
         VGT+LUo4tb5f2Z2U3BEk53Vmsg8abexXL3uOvkozepXUMezP8X2jPGUMbnJns4wSnhZG
         2h/AJQOBYbGJutrd+aD+z9i5SIPk0jjAq+B9yvV53fdLfRYe8AqTb3PoSTe4ba3FKFEx
         PKSDdXoaom1X0Rk17sdovpctT2NSxToeWw4F0RtxsumRMkSzVN6TTZihkH6QU9Y0ccyq
         DKuimfOdB4fIEfnbzSQ/MA/8LK7xHqvnnykKvnJzWgCv991K1B+tBJE2yNHNKlNr3Luu
         f6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVAI5Y58u6Vg7fTOBh9obmSGzxZGndA5ov3aURf6fhJFFQbB3pNtOJzXL5HIOg3a7iWczoF4FeacNEg@lists.infradead.org
X-Gm-Message-State: AOJu0Yyk0sNULkUd7tIhpZlHvK9WlrtS+6NG2wHwFvtd2yLQW+5ozy2D
	foPCpn5yZnldBgmZQgCzBdOoG946gxXWc0fVCQjVPdRVnrI1n4AFAF7CVAnwynyT3pU4ckOI3pv
	Z
X-Google-Smtp-Source: AGHT+IHzu56cqlZ49A1w9vGG2LfBKiRAx28b40um8WnvQmVh7SEi+A83kUcv62ViqMyqXSlXgwc5Tg==
X-Received: by 2002:a17:907:2d06:b0:a86:829d:317d with SMTP id a640c23a62f3a-a8691cbab76mr222888266b.64.1724357656317;
        Thu, 22 Aug 2024 13:14:16 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a868f48a98asm157724766b.182.2024.08.22.13.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 13:14:16 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: core: freeze multipath queue early in nvme_update_ns_info()
Date: Thu, 22 Aug 2024 22:14:13 +0200
Message-ID: <20240822201413.112268-1-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_131418_438505_EFCFD489 
X-CRM114-Status: GOOD (  15.62  )
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
 drivers/nvme/host/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 33fa01c599ad..e2454398c660 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2217,6 +2217,9 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	bool unsupported = false;
 	int ret;
 
+	if (nvme_ns_head_multipath(ns->head))
+		blk_freeze_queue_start(ns->head->disk->queue);
+
 	switch (info->ids.csi) {
 	case NVME_CSI_ZNS:
 		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
@@ -2254,7 +2257,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		struct queue_limits *ns_lim = &ns->disk->queue->limits;
 		struct queue_limits lim;
 
-		blk_mq_freeze_queue(ns->head->disk->queue);
+		blk_mq_freeze_queue_wait(ns->head->disk->queue);
 		/*
 		 * queue_limits mixes values that are the hardware limitations
 		 * for bio splitting with what is the device configuration.
@@ -2288,7 +2291,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		nvme_mpath_revalidate_paths(ns);
 
 		blk_mq_unfreeze_queue(ns->head->disk->queue);
-	}
+	} else if (nvme_ns_head_multipath(ns->head))
+		blk_mq_unfreeze_queue(ns->head->disk->queue);
 
 	return ret;
 }
-- 
2.35.3


