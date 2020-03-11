Return-Path: <SRS0=tokg=44=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2AEC10F27
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 08:50:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4409B20637
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 08:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nulVE3Gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4409B20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=6D8QlEj0YDOmrQLWg1wnBQXao6aP0xwCGNS0lRRcnPo=; b=nul
	VE3Gm5r6+9fYF0jMqj/UBr8z5WakBu0muqgzb+XRlnITDXDalYPHFzqwlEFYO4hjEWqXC9g+zawSz
	xkAjli7h6LkIGOZlwU2hiLszjFRD7K1BvpH1zHIoS7rQw5CmzI9bQ31Ey8B71kgxkuM3lboF6W27e
	MkK/thO7q6FmrVpqqhwTdSrRB5TdvDOYx3k45O1zrl4E7JJRfw1nLON4vnrBUAcVv3ezWxjBaDQn+
	5r+S75TYDYGC3BQJX596z8KAtKMY8/yeTt5W0+vE59v4zX8sGZaYPz3HxTfPj0FsnO7jZcxL2ODCc
	cb+3Q6HAszLVetfB85vHmHFGqzPhx8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBx4c-0005Wm-GE; Wed, 11 Mar 2020 08:50:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBx4Z-0005WP-TF
 for linux-nvme@lists.infradead.org; Wed, 11 Mar 2020 08:50:41 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7D8D3AEC1;
 Wed, 11 Mar 2020 08:50:38 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme-fabrics: Use scnprintf() for avoiding potential buffer
 overflow
Date: Wed, 11 Mar 2020 09:50:37 +0100
Message-Id: <20200311085037.18888-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200311_015040_089439_F1B499E5 
X-CRM114-Status: GOOD (  11.17  )
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
Cc: linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/nvme/host/fabrics.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 74b8818ac9a1..2a6c8190eeb7 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -105,14 +105,14 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	int len = 0;
 
 	if (ctrl->opts->mask & NVMF_OPT_TRADDR)
-		len += snprintf(buf, size, "traddr=%s", ctrl->opts->traddr);
+		len += scnprintf(buf, size, "traddr=%s", ctrl->opts->traddr);
 	if (ctrl->opts->mask & NVMF_OPT_TRSVCID)
-		len += snprintf(buf + len, size - len, "%strsvcid=%s",
+		len += scnprintf(buf + len, size - len, "%strsvcid=%s",
 				(len) ? "," : "", ctrl->opts->trsvcid);
 	if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR)
-		len += snprintf(buf + len, size - len, "%shost_traddr=%s",
+		len += scnprintf(buf + len, size - len, "%shost_traddr=%s",
 				(len) ? "," : "", ctrl->opts->host_traddr);
-	len += snprintf(buf + len, size - len, "\n");
+	len += scnprintf(buf + len, size - len, "\n");
 
 	return len;
 }
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
