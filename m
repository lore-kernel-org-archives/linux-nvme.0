Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCB0C4363A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 08:39:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9352168B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 08:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1OdeEY+b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="R6oYUPcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9352168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n6cLjk5eYmG1M0L82cdiND/Uyj1LIMRhous46pd0HyE=; b=1OdeEY+bFRTn8CymON4HHZZG6d
	0d6q1hjSlbgn0JXP7fodoRbOVtMu3Lb9qIvBkiAzc3Rmq2R/LOZXbLGahUrF1GyiuZernJOlSIUX0
	SpoH5g7dfATRXMZoBQU4VW4aewh1zOMlUFmQj1k1rAdPOE5PbfgrhJRjGAtkBPVFj6iknAYLymJn1
	2qZbyIIoweVzC9PydvVsp9+jdKVYV1fLhGQ0ZbXzzHzJ+6lHlqP2enJAI6mIHhH/6abITXbaLc/6h
	L6wgXYyWPJlDC8qiU1Ln+gqeNsGuU/qGetFP9Zx2xK5t/e3gVBcjoTNUatIv48dMR9KreT0ns93XP
	d2KZ0Kvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVW7m-0004bm-Uo; Thu, 22 Oct 2020 08:39:07 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVW7j-0004aJ-Nn
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 08:39:05 +0000
Received: by mail-pl1-x643.google.com with SMTP id bf6so583676plb.4
 for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2020 01:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=WRjTSaJ7aRlukBrkL+M/gdXKqvUBRft0vm/xDGjNJRU=;
 b=R6oYUPcjBuASTz2/24ysShG+PREqfrEHx2kkOrsiSsB2c4Hl72f9rRMkwW0/OCL7oL
 vUcf7EWmn76UAHpNtVQDkAAO1KAPJsuRLDkkW+bbeTbAx0Nlh5m5/CZlHe1Lp9+44EaG
 0Diy/i+6xHgJK/78XvZ20MOoXn3uCM5ttumJvqusoqhh4D5PRETOv126c9G2E2XRSZ7S
 6dJ6842Z6eVOpeNkoJn7TzW5JmKJTPz4s1LwkVM8Jl+vQ0RKE1nzLIEYwBGJeArSFYjm
 ZidFXsPwwULRTFVyhQJzS35e74qU1QPgNOtkZ5ERgt6gAwOXAZVCXVno+aVg6rh0cvPD
 YlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=WRjTSaJ7aRlukBrkL+M/gdXKqvUBRft0vm/xDGjNJRU=;
 b=gGYhldz6HpBbS5FmLX2cZzx6o5007AvYjT14oJjpmcA+CyzP25OjMBVu5h3rB4n8e/
 qbj4sVtVwLISLVnzJyGz1ZYKGJPOEN0fawWRdwb07d/TFXnQHILKQPYKrYOwN8mmYCxB
 u+UX6fvz0BHi0isix4y0VOQCSqMtUgh4egeA8bMGX5z0VfisfbC6EYjPgReUt1iKbpks
 XZenaesGgcijNrHCc/zWrMmL9P+nkbRcSs2usF+JPGBPZ0uNbP8K8/sbkSeqUDuAiizf
 sx0sHiaVpeef56Sy1H3eKdbpxXl7nbgvJ3Hsmv0tQ3BZOTcuU95WBhynZgwigODfaRvl
 J5Yg==
X-Gm-Message-State: AOAM5319AkBkyy6fajncUnHgXFLMFT3nzOhzysAQKvKAMk7m7+iutqs4
 FOlD0KCzTRJEMUixeGeJED62tQ==
X-Google-Smtp-Source: ABdhPJym+5wrTVQPViwggX5vf9tIWTbsFDSKvohjwsGtuvWbA/bPDX3JjQgol2fAv6lpf1QnNPo/hg==
X-Received: by 2002:a17:902:8c88:b029:d5:ffe1:6653 with SMTP id
 t8-20020a1709028c88b02900d5ffe16653mr1556061plo.22.1603355938037; 
 Thu, 22 Oct 2020 01:38:58 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id v7sm1436396pfi.0.2020.10.22.01.38.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 22 Oct 2020 01:38:57 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@fb.com
Subject: [PATCH] nvme-rdma: handle nvme completion data length
Date: Thu, 22 Oct 2020 16:38:50 +0800
Message-Id: <20201022083850.1334880-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201022_043903_779348_6EB1A4F1 
X-CRM114-Status: GOOD (  14.49  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: pizhenwei@bytedance.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hit a kernel warning:
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 0 at lib/refcount.c:28

RIP: 0010:refcount_warn_saturate+0xd9/0xe0
Call Trace:
 <IRQ>
 nvme_rdma_recv_done+0xf3/0x280 [nvme_rdma]
 __ib_process_cq+0x76/0x150 [ib_core]
 ...

The reason is that a zero bytes message received from target, and the
host side continues to process without length checking, then the
previous CQE is processed twice.

Handle data length, ignore zero bytes message, and try to recovery for
corrupted CQE case.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/host/rdma.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9e378d0a0c01..9f5112040d43 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1767,6 +1767,17 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
+	if (unlikely(!wc->byte_len)) {
+		/* zero bytes message could be ignored */
+		return;
+	} else if (unlikely(wc->byte_len < len)) {
+		/* Corrupted completion, try to recovry */
+		dev_err(queue->ctrl->ctrl.device,
+			"Unexpected nvme completion length(%d)\n", wc->byte_len);
+		nvme_rdma_error_recovery(queue->ctrl);
+		return;
+	}
+
 	ib_dma_sync_single_for_cpu(ibdev, qe->dma, len, DMA_FROM_DEVICE);
 	/*
 	 * AEN requests are special as they don't time out and can
-- 
2.11.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
