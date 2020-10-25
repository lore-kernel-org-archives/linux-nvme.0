Return-Path: <SRS0=vY4W=EA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E78C5517A
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Oct 2020 11:52:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A45C21D41
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Oct 2020 11:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BZ6cyQS8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="y/DXhF2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A45C21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6K1NM8ySm1IPJioT511ek+bnqmTY/LaBt9zTufvsPHg=; b=BZ6cyQS8qpjV5rfHJs6dS39o5U
	hwJOhUNViejQWNhxwS2HJzRDF2sjlUuWzpKeGg7OuKS1vY/p6nbsIf6TI8BTwCrCADC5TvU5Ogtbd
	hUFQ8wyMVwLk+3xzncGpfg830S9ORv4cwEfAu2enmusghkgSSB9e7IiHmfsK2l8Y0PhKd5/e8r+jM
	L43wmwt2QTx+C7uX1KfpY8Xlr9W1sEOJ5rwRT5TgSnt1qx+WU7Fh6NshCKS8MPxqgt1Ap50ImxH/f
	P5BlOw4bcQuo5bUnHjjcpEjR3WeYhkeuBHjLw+8bXgzUZaRtTkLUqN1XjjkTJtPHZEPj/g8v/cobE
	882Q19Tw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kWeZC-00030T-E1; Sun, 25 Oct 2020 11:52:06 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWeZ4-0002zP-Nb
 for linux-nvme@lists.infradead.org; Sun, 25 Oct 2020 11:52:00 +0000
Received: by mail-pl1-x643.google.com with SMTP id o9so3319652plx.10
 for <linux-nvme@lists.infradead.org>; Sun, 25 Oct 2020 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=1KiygqGWwb0F23sQdKfIGxFeP8lZb1Vly0G9w/101ss=;
 b=y/DXhF2Fqdumgt3Pn9ix0eB8zltPQXKFobDlC+s+Gy3EYJnN6bNZ6GiSh1q49Ryyts
 3kbXB3zqV2t1RB+apb5MB21aaO0Y3bJ5wzz0KtxT3HEh+wOiaBnsES6jQ35l3jpnPdZU
 EAtF1m+9Kx9VhqcjY4O9cE3Fi1fC/JyYE44EzlkNKBiHar5gRRglKGHICWmboBXDaREa
 n83pjMWieUbnY9M3aH0deeluCrnfdMC/gwfQxyXZtN0U5uKigD7/phsu+I3iM6eywBil
 jm4y43ZGTY8TzshFJNrlzINHO6ITTn21atoxGf66wjlMGwkHgazdw1zUTW41ulLfDOkl
 mzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1KiygqGWwb0F23sQdKfIGxFeP8lZb1Vly0G9w/101ss=;
 b=MG5Ydcc/AOD6tBHh59VK2I5Vr+h5HofJzRiYtoO0n0tuYM1e2GSoWHG6DyUlAuKdhu
 4ZMlea+r8CMo5wU5t9YOldmcOQaA5m+q4Pg+yZsO9XwxC6FW91Pq8DtvE4LoDnkaV6Hi
 m/UVkDuls7BgmksxwHXbIHvNAL1/zl+3DvrKGxX3Ru8HqemqRBvl8D44oBxoIjQ7A6FN
 NIOcym/IcT1mohsEu1UMGccUbdyimT2CVlVWrFMYkFJ/vTYJeDMPj8S9IIEchk5HRVf2
 CmeXPsZTWp4xBb/iQTl70I9yRFeFWGDO+0FR3BBLiUs9+nAY+E4X5OYADREf+Wky5yhh
 g/fw==
X-Gm-Message-State: AOAM532P59Oz70bCg7gAHHiHaqCKsxhDpJuGfOxBbFPRWzGl0oNvRNO+
 kslxacVtzmLkOBoRiLe5hFjG4w==
X-Google-Smtp-Source: ABdhPJx1F1ZJkSgr74ZVrgG2Doqqo6qZpxGo/7X3N66an+FJd02Y5pof4gQDqWmycZHAtJoDUaGBwg==
X-Received: by 2002:a17:90a:17a8:: with SMTP id
 q37mr11244997pja.44.1603626714849; 
 Sun, 25 Oct 2020 04:51:54 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id q23sm8825394pfg.192.2020.10.25.04.51.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Oct 2020 04:51:54 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH v3] nvme-rdma: handle nvme completion data length
Date: Sun, 25 Oct 2020 19:51:24 +0800
Message-Id: <20201025115124.1430678-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201025_075158_917476_A26E03F9 
X-CRM114-Status: GOOD (  14.46  )
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
 linux-nvme@lists.infradead.org, lengchao@huawei.com
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

Do sanity check on received data length, try to recovery for corrupted
CQE case.

Because zero bytes message in not defined in spec, using zero bytes
message to detect dead connections on transport layer is not
standard, currently still treat it as illegal.

Thanks to Chao Leng & Sagi for suggestions.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/host/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index aad829a2b50d..40a0a3b6476c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1768,6 +1768,14 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
+	/* sanity checking for received data length */
+	if (unlikely(wc->byte_len < len)) {
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
