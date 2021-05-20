Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780F3C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:45:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E648610A2
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E648610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1ZyIZ2jpyrBmj2P4B/Nlfjkda5W26oIignJ9hX/TZMY=; b=dLYrOI1m6SjmFpkHrzobSSIXf
	wCeruRZMhJHghDajQK0/PMKUCQkXZWRsFOqUrCH5qppInq5U3wgyvHfpsNh6Y0QBU5nXey96aZVCD
	suzOFKxeeX10RL+8wrmLwbKo0lBsXmxqV8x1Krhgo2uLV5Za/slzxpN5H3epbzd0RipK3shZo7di5
	4fBATemkv9IxUNlSrcLpCEfvaFrmxpMcE/TmxZsjL/WMTFqGZ3fmhVDSKVvTUNLNBVipjHFi74tt1
	yN2XjHp5shHa14E09WjRcaAPtM0iDRt4RX4tPqlAfUSC/D843sOGDK8/htTvtl1tLBmCIH5azMoau
	54rUmE0ww==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljbUZ-005yiO-Is; Thu, 20 May 2021 05:45:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbU6-005ydg-OR
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 05:44:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=hOX3vvSyMPOuQ4KHQdquXkjWDDG1N7RHcsFWVjHSiJc=; b=hO+Y1wfqEVPe4ZCpJWIzNJPCoB
 ecKiDSb/Q09/YJFv1siDCY2xEe5E3Jp+4V4RPGld3yyCtxmpb61wYBPxZbfW2AarxdxcC5aRNyhmK
 og1kdWF7mcF0XQ8rMtmyMcOVX3R49G00JlB1VqM9wVA6plrGHspRQ4bXPcV7HJmbp/Q4lCYRsW5IG
 TgWjzRH9JRGHrIZqMQmROps/E1zzVXpWxPpzRXOwHeRLVOJ+Sup8uW7prAxrNX1DBbxJ03/Wpa2KN
 SJwwOqV5PhAnutxAgvPSFfo2DtHxuKMwMnD4afluEX/W/fAxPg9FBL11T97HRsN+sQbZ9Oxyvzi74
 HPZ+auzg==;
Received: from [2001:4bb8:180:5add:a633:7cce:5450:3d63] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbU5-00FxMR-4a; Thu, 20 May 2021 05:44:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/7] nvme: open code nvme_put_ns_from_disk in
 nvme_ns_head_ctrl_ioctl
Date: Thu, 20 May 2021 07:44:22 +0200
Message-Id: <20210520054426.567241-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520054426.567241-1-hch@lst.de>
References: <20210520054426.567241-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_ns_head_ctrl_ioctl is always used on multipath nodes, so just call
srcu_read_unlock directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 3f84bd3b9259..2c6969ffe85c 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -377,7 +377,7 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	int ret;
 
 	nvme_get_ctrl(ns->ctrl);
-	nvme_put_ns_from_disk(head, srcu_idx);
+	srcu_read_unlock(&head->srcu, srcu_idx);
 	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
 
 	nvme_put_ctrl(ctrl);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
