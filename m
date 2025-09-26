Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C5BCAC5B8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 19:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Wvtv/qcICkYTsHwiHykESM7tgNOYNZooGCxrW6WCvqE=; b=wKy5LlaHylPnzdHCGEzkAZBbi7
	kB7TP5zAUwYGgznFZsOPYQ7ndhXkaYh8f/sObVfIvmGD6zk2RWxwYtgrX/qbbFzgtm+Y17OE30B1J
	J8My+QpEx7uHbj8pfbiMHa8ZhaRSq8wems7I/APPIL8a+vStY5l5EGOZOGQocXeHCD+I2Pg5FZZBC
	UI+1E45P7xvbqSkCE964D5MOz0s2InjTJwiDDWgwjJ2oAaKXU9CH/AUHbaXHNpon8Ex4317PbmjKL
	SXS8me26QGpBFup2ETSSAvdJAL66aah+gEE2ezK+7Z4jRjTerlmqKXb0evjK8er8If8J0KBpaRGz2
	fwatj5Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2DpR-00000003qRI-2DWy;
	Fri, 26 Sep 2025 19:10:01 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2DpO-00000003qQX-3r2F
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 19:10:00 +0000
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-917be46c59bso14198739f.1
        for <linux-nvme@lists.infradead.org>; Fri, 26 Sep 2025 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758913797; x=1759518597; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wvtv/qcICkYTsHwiHykESM7tgNOYNZooGCxrW6WCvqE=;
        b=CtAdwzNMCyuj6d/3t40VPHI+fY4JMYy1sq+d9Cjebfkch6aIz5lsx4EXD90XWHZKsk
         v2N5qfGoA3bXn4fWuqTTKq8xfsOGBlhWC/y+NknHcqxh7zyHjDWc3bzbv6X0TFQVWUdF
         s8eCGvzM3UcbiTDE+uz6mzMtxvygQO8mVQ8RusPM8VUkSYG0v10GbmZ3gMkxBzvzCLWU
         BPJvIGTox6kTaxy4WoekFu3O7asDMM8g5SCXa5RM35BUX4Sw8RxcXtdvrmZH57gi5bRF
         O9lMIGZEe6fbkwGrHGLs9clZXLxuNb/2HaWrq107fpmbcj6782apUuO849IWScXP0xMB
         nfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758913797; x=1759518597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wvtv/qcICkYTsHwiHykESM7tgNOYNZooGCxrW6WCvqE=;
        b=YataUSSVtziE8hnTKKCAHpk4C8ZPWKluOOc0BItTuPeKmci8n87bz1nTLtpZ9CwAVJ
         OVZst70I0z0O0MTE09p+sex+9TclOUQC2uUEygIcODz6zmBtJ7FEJdT1It2xpy7mQjEM
         2bB45fLsXeyNld3yGEA00GlWSxNKX5G1tPCasC+QJPFcyyvdkq2MQuczN2jL3P/kmvu6
         PgRRvpQOCNme8klAro3aBWIKYu+1C42OqQNFT9PdknvUk0W9Bd2fxDg88O4EOn2zHMme
         spLXlDs1jXNydQZiEASiEyzfsBgZ+xvK66Awtt+Td1Gx2oKzRtxcD8S+U5FJunLuFgVG
         2GTw==
X-Forwarded-Encrypted: i=1; AJvYcCWylYxkOi5ziBL9nbMAViPsecKnoFzRs29JRnOBUQmJ2+h5Ko0Y5zxxVAZk+jTXcKnmSwIJjZAokiLB@lists.infradead.org
X-Gm-Message-State: AOJu0YzK79U9r3zHL80uPUaG7W61Dc+brefUkFvMNUl+OwBoD7qmksNV
	RYuYCAPVKFmto/LS7ZWyxoWCzpfFsrraACqst2p3vFf7ZDu/pUYFux5GihCSHKb7iSA=
X-Gm-Gg: ASbGncuUerrco0agJ14IcwP2dbaNPap4HzEExuj2c9IGEzHVTCBUlB+B4ZnqSI6l8Dk
	vypJqLybBo0jUjPxmnWmA+oMCCaiXeB2CY+npKx4yp6nnUVIFzO1JsSJG76ODZN1BCuu/Bjn3Zc
	WBUhRXKaVpqNH7IH1dtqoUzMKJmA59l3H+ADIG/H71DpBJHmTtbSPZ01yxz360/YSTRVu7sPg7o
	U4hRtnkbCE2W4b3pRqU4xJljeOiWuH/BXqx2a6PqFmr3tlLj09MGveoGeWNB3kyNkfB+6MvJ9Cx
	4W/QWvoPK1AnhPI+J9kgqchsEO6h/vXgN5VVsR6a2SLUj0ZPRpjZhNr2iwJ86sp38O35sxEBo2C
	rlKS/n24RbVBqSBuSNYqzBDmO7JeHfa6AmZO2wKZj7xIbL4y9NnnkDSwYfbtLWb5hmKtbNA==
X-Google-Smtp-Source: AGHT+IFjghvNCqO6TOfbA98+sZd3KQTpt5kAvS4oQsge2mxcUu3UVERk7C8TvE1C6z9/EDMI2LD95A==
X-Received: by 2002:a6b:6a0c:0:b0:8fd:baa7:bce2 with SMTP id ca18e2360f4ac-9016c57c02amr1232916839f.16.1758913797264;
        Fri, 26 Sep 2025 12:09:57 -0700 (PDT)
Received: from 8745f5817b94.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-90e48099408sm105070639f.10.2025.09.26.12.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 12:09:55 -0700 (PDT)
From: Amit Chaudhary <achaudhary@purestorage.com>
To: achaudhary@purestorage.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: mkhalfella@purestorage.com,
	randyj@purestorage.com,
	jmeneghi@redhat.com,
	emilne@redhat.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] nvme-multipath: Skip nr_active increments in RETRY disposition
Date: Fri, 26 Sep 2025 12:08:22 -0700
Message-ID: <20250926190823.5031-1-achaudhary@purestorage.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250926_120958_997683_343B46E3 
X-CRM114-Status: GOOD (  13.47  )
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

For queue-depth I/O policy, this patch fixes unbalanced I/Os across
nvme multipaths.

Issue Description:

The RETRY disposition incorrectly increments ns->ctrl->nr_active
counter and reinitializes iostat start-time. In such cases nr_active
counter never goes back to zero until that path disconnects and
reconnects.

Such a path is not chosen for new I/Os if multiple RETRY cases on a given
a path cause its queue-depth counter to be artificially higher compared
to other paths. This leads to unbalanced I/Os across paths.

The patch skips incrementing nr_active if NVME_MPATH_CNT_ACTIVE is already
set. And it skips restarting io stats if NVME_MPATH_IO_STATS is already set.

base-commit: e989a3da2d371a4b6597ee8dee5c72e407b4db7a
Fixes: d4d957b53d91eeb ("nvme-multipath: support io stats on the mpath device")
Signed-off-by: Amit Chaudhary <achaudhary@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
---
V1 -> V2: Moved check to mpath start and check relevant path bits

 drivers/nvme/host/multipath.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3da980dc60d9..543e17aead12 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -182,12 +182,14 @@ void nvme_mpath_start_request(struct request *rq)
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns->head->disk;
 
-	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
+	if ((READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) &&
+	    !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
 		atomic_inc(&ns->ctrl->nr_active);
 		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
 	}
 
-	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
+	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
+	    (nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
-- 
2.43.0


