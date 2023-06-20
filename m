Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB83EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Bwdr1KTf4X5q6ZLeLCmBIiNYO6CpfklphjHoRh8Te8U=; b=3IBkbsAbNYHTsmp+SdWDdHhXIU
	hia4kl0YcWPNu9nfnqOsFTRa1tC9C2ZovO1CZC9bF0lembOx+5UPt9vv7JUPdnprz8XSm/IaqKtHL
	krEMIhtJANHgWoKofgExvyT7xmcBfuXQhN0hDNJv4kmSLheS1OrlOIImwoYZLH62z37DCkghWShP4
	wzy5Ui8yGn+sRMybyVrlFX31P20MhMmurQyV0mnD5gXKbPAXuDtm4T8i/Lyv07f9FZGnbx63XSwkr
	3t+2bpsEkk032Zh17QN8GfjyuUqPRtMbNmIjpMzmT47QCNNfM33bkHoqFJdLfpkPW6TEotzLJJ8wC
	U8QzzDgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBb5E-00BKsw-2J;
	Tue, 20 Jun 2023 13:07:44 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBb5C-00BKru-06
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 13:07:43 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f80cbc37c5so11197275e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jun 2023 06:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687266460; x=1689858460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bwdr1KTf4X5q6ZLeLCmBIiNYO6CpfklphjHoRh8Te8U=;
        b=eZWu3X8mk5AKoITpc2FVjJDxxktKqoWrP2lG86niyUle3EeVGkzMFdhKRQ7lTPRUOs
         hCL1J38X1YU2EZcYpOYtdLGBvJ9hanr/UTELtsctRJkE67ma6pFad1ORX2PKHcFH5pA2
         jaLMnGDQk7GB8hdtzWYKogZKr5ZCzxnuiTMx9PVyP41jouKyKUXnWY0yWnPLQR1zBBn2
         THJWvu7hRmZOlny8X43xJWzHhveuuFWPnTSp9F+rHi9B9Lj19vELeZ65XDPVO/CB/S4G
         B7oSfvLYp2TUF4E/Bo4YOWCISEzdUQIsEgoI8SMimad7cxP/KiKVKTHoqOYz3kbfnFEf
         WoHA==
X-Gm-Message-State: AC+VfDyigXLTt3qkDjWSgcZSSZClh7t7YIydP0Et0raSEgFB8npVkGqV
	nk13BnuAXiVwAJyUJ2mgFNPVDk9rW4c=
X-Google-Smtp-Source: ACHHUZ4DA/GnOycvMmA5QVi9HzTFzEFaskTIW3g62OhW14GD0rTMnKh3WwOVoSN32mM8Zx4bcizm/Q==
X-Received: by 2002:a05:600c:c8f:b0:3f7:e7c9:4039 with SMTP id fj15-20020a05600c0c8f00b003f7e7c94039mr10822081wmb.4.1687266459286;
        Tue, 20 Jun 2023 06:07:39 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d558f000000b0030647d1f34bsm2051196wrv.1.2023.06.20.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:07:38 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2] nvme-mpath: fix I/O failure with EAGAIN when failing over I/O
Date: Tue, 20 Jun 2023 16:07:36 +0300
Message-Id: <20230620130736.1090531-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_060742_087137_5242B65A 
X-CRM114-Status: GOOD (  15.47  )
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

It is possible that the next available path we failover to, happens to
be frozen (for example if it is during connection establishment). If
the original I/O was set with NOWAIT, this cause the I/O to unnecessarily
fail because the request queue cannot be entered, hence the I/O fails with
EAGAIN.

The NOWAIT restriction that was originally set for the I/O is no longer
relevant or needed because this is the nvme requeue context. Hence we
clear the REQ_NOWAIT flag when failing over I/O.

This fix a simple test case of nvme controller reset during I/O when the
multipath device that has only a single path and I/O fails with "Resource
temporarily unavailable" errno. Note that this reproduces with io_uring
which by default sets IOCB_NOWAIT by default.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- Add a code comment to explain why we clear REQ_NOWAIT in failover

 drivers/nvme/host/multipath.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2bc159a318ff..7d93bbbc01ac 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -106,6 +106,14 @@ void nvme_failover_req(struct request *req)
 			bio->bi_opf &= ~REQ_POLLED;
 			bio->bi_cookie = BLK_QC_T_NONE;
 		}
+		/*
+		 * The alternate request queue that we may end up submitting
+		 * the bio to may be frozen temporarily, in this case REQ_NOWAIT
+		 * will fail the I/O immediately with EAGAIN to the issuer.
+		 * We are not in the issuer context which cannot block. Clear
+		 * the flag to avoid spurious EAGAIN I/O failures.
+		 */
+		bio->bi_opf &= ~REQ_NOWAIT;
 	}
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
-- 
2.40.1


