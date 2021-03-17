Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBC5C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 20:36:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742F064F33
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 20:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742F064F33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eRyycBS9A7eD1Y0V/M9u6gtf3vMxOO3wyis+Oc1PwIc=; b=VurXya+WlS8H6Ndl0FzmEVxKjv
	GL/E5oOneDCP6gWqUZktBQEwXiyUuqI5gm1Z+2Oiv2+SbkwdwYOlhnUd24h9NDwImZ93ukpk93pKi
	FMEW7mkiiSiixugq6zc1mootfjzWnBza0Jg5ZCs5rSvDhIhnDyCxKfYmj41NDUH/omVihB7Hqc0aK
	EyT5zbDe2pxaaHo1trJTbw6mLIte6x1Cic/HJ9NB/uh3sH2G5mSis0RBY6TQ8eeT45rCQd2LnwBtd
	Zjxcqmp7ECW6jr2jDsaCsbscNrqU2OtuR9Z8aOrJJhuDDsaB5Rr8UfBwjZsmL9aZe64zrDJXjq4Na
	KumktqIQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMcsG-003s9q-Kp; Wed, 17 Mar 2021 20:34:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMcsA-003s9S-4O
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 20:34:31 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0569964E28;
 Wed, 17 Mar 2021 20:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616013264;
 bh=R2mye9a//eLnzU/Yy/23812EbKNkaJBP2qlLSaKc1LY=;
 h=From:To:Cc:Subject:Date:From;
 b=Or9rKyEJXihhWbFm+RAvkwuKDW4vUi6qyKfBF8BHB7j573vO9h/I+OZrGKA5wx5lj
 1QbQuh1G2raqinP7o3uLx6MHC8Rj8Tu/uRAM5w0lEofDIZln1I9XUjjOa1T5Nrv760
 HLXE1Z5uUE8t00G1a5W5qDcK7DKWC1lYi+Tg8Y21zPJsKNnMGBod2OL4K7Cb5G0syO
 rzmgEfJqT/TR7543slnR5Vqym/dOmSaJJqNdhIqezloOGoxh4N/PSvPVYLiRgFwF15
 rrRIpb1IiyJGbd0LbQLpJx+6Kne67qjxbOTP/x4MplTbP+Hkp9tPJhjqau9wNEXOat
 blQm0rJ3ue1iQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: warn of unhandled effects only once
Date: Wed, 17 Mar 2021 13:33:41 -0700
Message-Id: <20210317203341.17315-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_203430_426924_93ED113A 
X-CRM114-Status: UNSURE (   7.98  )
X-CRM114-Notice: Please train this message.
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

We don't need to repeatedly spam the kernel logs with the same warning
about unhandled passthrough IO effects. Just one warning is sufficient
to observe this condition occurs.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bfc868d6bda9..bb15882c0fd1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1072,9 +1072,9 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 		if (ns->head->effects)
 			effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
-			dev_warn(ctrl->device,
-				 "IO command:%02x has unhandled effects:%08x\n",
-				 opcode, effects);
+			dev_warn_once(ctrl->device,
+				"IO command:%02x has unhandled effects:%08x\n",
+				opcode, effects);
 		return 0;
 	}
 
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
