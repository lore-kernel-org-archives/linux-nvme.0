Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1DDC2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 12:54:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D836113E
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 12:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D836113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=63OXNsFqjTQ6Bk4jlJPbrmLm0t/A1tLF1N9S/U30QqE=; b=lkvRp2QpOAiM9X
	xT+yznqhU3YPFKPlW1VMW26LXKMQrdAMiZi8RFedM3ZFATUUNW2RPnEbQvG19JA133qLauz0e5lF2
	Yf/bvQTo/A8T/6f0ZVmA2Oa8i+ddMq4qDuYV5hj+SdrN/npiZR3/a+tjrlZ6tQR8CwwFTvyZvXEP8
	vKjW+fSSOvx9eB+Lh7mB1Fyf0hT3ljO7zVNMnqpBEZZ28cIN2QX5EGYLqOb0G5g63tRfPNihsjRDL
	IGYu4psZEnxN/ZuWGWlQ5yb97lQG7s8f5BDV6Bzj1K67wl5pi4VApCXNdkLEOE8xhXlsB2gTH2UZ1
	B0gHQMqmB3k7EgA+yN/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llWZo-0059Uc-7c; Tue, 25 May 2021 12:54:28 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llWZg-0059RG-2S
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 12:54:21 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621947256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eLUtJgY9+b2qIrJVNMLbqNax/G/jibu/Nff1lF0fAPA=;
 b=Wr1KXFo3i2tXL1rps+SM6sYqjJDHZmZ7USdVsyjpboMRYS+DRIidkiVspsGSbREJvDuYBW
 39HR+Q3kdlecOA4ftnM5zUzn0ohkPxiH5l+V8wAy7x7t9viSVSG/L6V2xZz9fV4o6EG2b8
 nBSnUB3qwtXvBlHVa1ymsD/jkMVAZoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621947256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eLUtJgY9+b2qIrJVNMLbqNax/G/jibu/Nff1lF0fAPA=;
 b=MLwEZggmT1p08HgWmKC4kESpyinyg7kBfgMtDCqyR+WsxtZIccuYYG1WvLAgHB4eiK19ky
 DCY27DLQ+El+QOCQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D0DF2AB71;
 Tue, 25 May 2021 12:54:16 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmet/fc: do not check for invalid target port in
 nvmet_fc_handle_fcp_rqst()
Date: Tue, 25 May 2021 14:54:14 +0200
Message-Id: <20210525125414.68118-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_055420_281969_27DE6F5B 
X-CRM114-Status: GOOD (  13.96  )
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

When parsing a request in nvmet_fc_handle_fcp_rqst() we should not
check for invalid target ports; if we do the command is aborted
from the fcp layer, causing the host to assume a transport error.
Rather we should still forward this request to the nvmet layer, which
will then correctly fail the command with an appropriate error status.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 19e113240fff..22b5108168a6 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2510,13 +2510,6 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	u32 xfrlen = be32_to_cpu(cmdiu->data_len);
 	int ret;
 
-	/*
-	 * if there is no nvmet mapping to the targetport there
-	 * shouldn't be requests. just terminate them.
-	 */
-	if (!tgtport->pe)
-		goto transport_error;
-
 	/*
 	 * Fused commands are currently not supported in the linux
 	 * implementation.
@@ -2544,7 +2537,8 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
 	fod->req.cmd = &fod->cmdiubuf.sqe;
 	fod->req.cqe = &fod->rspiubuf.cqe;
-	fod->req.port = tgtport->pe->port;
+	if (tgtport->pe)
+		fod->req.port = tgtport->pe->port;
 
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
