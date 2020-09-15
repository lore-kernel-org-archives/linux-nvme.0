Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C5FC433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:51:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5562520936
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0E+Co4fz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n6fHO9Jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5562520936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Tc/D/BNi7Tl+wPz/efsXpJBJKiSBD1nvgzZODIOY09I=; b=0E+Co4fz4xZWqu07IWz5IKVfi
	GhlZ9Ax/eF4CJ1LoprIvO1Je7VpXXxCJgIFHEza676j0wBplcJ0yDS8wlWWrqK6FzpqJ6xZAQlw8E
	wkfAdtA4T6T3XgBHeFerTp03pECFplUjuQ3QGAuMzV51u3sACuR5sA+i9/WA9QqskCFQlF2z2cd4l
	YhnsmYt7JvvSYoBtJZw52jXhkbTzKlpTqOqqtlzurv2rApOngPLnyAJCVzJHlYBCfbLiw/4m53Qrr
	dbdQVl4rVodLhd8YaHltVIYj/GpmG9F3rcwzkEh00GIesdfxuF1n7W0NesDoCK6QfXvB2BX3uuQy3
	x5MAkQJLA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIIrX-0001Xo-Un; Tue, 15 Sep 2020 21:51:43 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIIrV-0001XA-6j
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 21:51:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600206701; x=1631742701;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bVx7UObRX7scggoe6Whf96n+Ndrol9MmUnW0aD8+b7Y=;
 b=n6fHO9JmxPqCac3BkivN/s6kqgbnx5IEHLLXBHYCmBtycZlxIeMGas11
 ebvmb3IkVCGvNuDocoQEJiat+psa2ja8R/Ih7s0LKaliu12OeiewB1Dbz
 Q7UYCJ+MFTQItM3rL6sRJ4nAdAJLv6EPFAEPzkVxdtCQRPpU3CNSbOe1f
 ANrLhGt6GeDWK6WkngY0RhxNTY30gsTy8ZLdmH4asY/flwu7UQCZWiluw
 tF4XO8DpBbumXnkc3Bovg7P/gMDRRCKcrrKorD1yYI1iiZFu98aMJAsI+
 TK4f0HQlQfXFFVKxvgxJUYWwZ3xvhe+ruhOalE8IKhuf2TMuGpXTBTyNJ Q==;
IronPort-SDR: CA1fkVCFFRuTQJ5gaUCqW3Rs8bWyzVM0d4YG014/jCZGryRSC7wOdBAX6UyV8g4hTxRyVp4VBy
 TwXo8pqJswmwKfvtefv2WXoenw+fnhYvE+sp/gTpToF96lr60p1bh25frSKMdEuOzWs4fruIzP
 i5K0No6UheKlgzpfusNxfD+souwGf2WNLFdBERMWjmPD1X08rD7ohsdcPT8dOaCcZKN7grsg/5
 AdEJo4vMCY2Vn+iIY2aGOeLFkBZqbrW2lnbDWFA6I4fK+gXmkS52Yyg5OZweKL265VIPj7R3ig
 4Y0=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="147473477"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 05:51:34 +0800
IronPort-SDR: /uA2e8FV3MDzk9xzAgbe3AEfkbK4wEt94a2OyFUhtnq8tiMcO3ng6ifXO8H7Xx0cIeK8PmzYpb
 oLsjm2rGJQoQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 14:37:50 -0700
IronPort-SDR: 0Qyem+MuRsijp30qcHeuU9q4e0K4jxYtlBm8XDn7nTMiC3NkLNG6cmcUbzioJXcHRNko058ukE
 PxreQrGDOWNQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 14:51:34 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 2/7] nvme-core: use I/O timeout in nvme_submit_user_cmd
Date: Tue, 15 Sep 2020 14:51:13 -0700
Message-Id: <20200915215118.3934-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_175141_382054_8FF4E10F 
X-CRM114-Status: GOOD (  15.28  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the function nvme_submit_user_cmd() it uses ADMIN_TIMEOUT when
caller doesn't specify value for the timeout variable. This function is
also called from the user I/O command contexts (nvme_submit_io,
nvme_user_cmdXXX)) where NVME_IO_TIMEOUT can be used instead of
ADMIN_TIMEOUT.

For now we don't set the request queue's queuedata for admin command.

Use newly introduced helper function nvme_default_timeout() to set the
block layer request timeout value.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0f878f5e07f0..41177a181c8b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1082,7 +1082,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	nvme_default_timeout(req, timeout);
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
 	if (ubuffer && bufflen) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
