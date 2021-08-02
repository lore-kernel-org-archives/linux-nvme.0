Return-Path: <SRS0=aESL=MZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5A9C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 11:29:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C76360F36
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 11:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C76360F36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nXjrzSUihUe2qJzNa+QcBoHgO4a8Ly6cu+xbsIvbZ7Y=; b=14sgQEZDXKkJHw
	AF0LXczg6PUu76KRc6yBIIPvn9KRqtOmNfU7HhdaSPYzXBFJbcp0SQVoFwBBba69siZRh7YytVgZ5
	XXNPWdW9uIrR1fVVLDhTbPOMMfObenmvSELbhi596wHD+PQY1Zz6JiQQKIJgOWz1RTmw1Uvfx9axk
	TicEp36encSWmeTEgVYzmYdIn6eIvDVCjrcFeiKKXnaaYEs5wxTvE06cT66zDdmp/XOm91uYhHc9J
	OWXYnrW/EcqbNUc529ugVnIyRYss4n8SvlUzjx+N9r2yxmJMiYocciM3APY+vTDhNGLeUXPC1qIKA
	WeEbbnw/8igtknyvl+bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAW7z-00FwL3-6h; Mon, 02 Aug 2021 11:29:03 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAW6B-00FvfI-OU
 for linux-nvme@lists.infradead.org; Mon, 02 Aug 2021 11:27:17 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0F9D41FF7A;
 Mon,  2 Aug 2021 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627903628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5Dv6QSRopYt+IEkWfubvU2x5TlLAENN9LR3ro7upZE=;
 b=hU4IpHJARFQo6L/ZNRtZr5Rb7GOWjqAS/2h+8qIGlPo0feZPl4apky6Sam/wpf2JUBc9jB
 f8N9/jJTB4z1S8dapzDxZsuvWIScAgSe/mIkIXsi/gIXzBQQ5RdQz1wuHgimn6riUIu1oZ
 Oi0kvOmG4rgaQwB4T5n7e+ActqRn5gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627903628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5Dv6QSRopYt+IEkWfubvU2x5TlLAENN9LR3ro7upZE=;
 b=lAzJ0RX8Y4N/v9EwR/1mQwcSWPvGWiFuhMA5K+7yDqTm1Fi7GcFJxpdo/eOh8KzzORfhpG
 IO3WJ96jtcquEECg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id EBB25A3BC2;
 Mon,  2 Aug 2021 11:27:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id D72F8518C0A8; Mon,  2 Aug 2021 13:27:07 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 2/8] nvme-tcp: Update number of hardware queues before
 using them
Date: Mon,  2 Aug 2021 13:26:52 +0200
Message-Id: <20210802112658.75875-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210802112658.75875-1-dwagner@suse.de>
References: <20210802112658.75875-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210802_042712_038289_C86D0F0D 
X-CRM114-Status: GOOD (  13.49  )
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

From: Hannes Reinecke <hare@suse.de>

When the number of hardware queues changes during resetting we should
update the tagset first before using it.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/tcp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0a97ba02f61e..32268f24f62a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1789,6 +1789,7 @@ static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
 static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	int ret;
+	u32 prior_q_cnt = ctrl->queue_count;
 
 	ret = nvme_tcp_alloc_io_queues(ctrl);
 	if (ret)
@@ -1806,14 +1807,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			ret = PTR_ERR(ctrl->connect_q);
 			goto out_free_tag_set;
 		}
-	}
-
-	ret = nvme_tcp_start_io_queues(ctrl);
-	if (ret)
-		goto out_cleanup_connect_q;
-
-	if (!new) {
-		nvme_start_queues(ctrl);
+	} else if (prior_q_cnt != ctrl->queue_count) {
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
 			 * If we timed out waiting for freeze we are likely to
@@ -1828,6 +1822,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		nvme_unfreeze(ctrl);
 	}
 
+	ret = nvme_tcp_start_io_queues(ctrl);
+	if (ret)
+		goto out_cleanup_connect_q;
+
 	return 0;
 
 out_wait_freeze_timed_out:
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
