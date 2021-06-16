Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C11C48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 21:20:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0521A613E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 21:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0521A613E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QeHv8T8aQABjmP8sk5uQQYJ3qY0cIPL6LwT5ZoKt/0s=; b=c+JnJyMNSNKExu
	qQxT4LYoG77g/hL6qgrhyWxH5I/PtINceEMwnQDGO3Gw1V3mJwR9lCwj2WuN9n3wsBpf960nTBpun
	YH4r/PVxo6Xg1XSu+C0nbG8LAy1H+tRuLM7EqAAo+35FjYormDd7301Q2C4aaXzmGN8sqbY0/J6z6
	HKmGTuEZBQxamwutrIH/fL5XnMriPSzm4qy5pqLke2dF824Z5+e6K8yaN8Bteyp2iNr+yyOt2U9KY
	t9am/KYroYGJ0ad5I46E9S/gJhOTntsVWYlVsJuXx2wIYROYlpbS+TiMoS/zO+sYd7SArvUka960H
	ULyfIh4I1uJQLWmfGCDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltcxA-007k5S-If; Wed, 16 Jun 2021 21:20:04 +0000
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltcwo-007jzn-Ty
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 21:19:44 +0000
Received: by mail-pg1-f179.google.com with SMTP id l184so3081196pgd.8
 for <linux-nvme@lists.infradead.org>; Wed, 16 Jun 2021 14:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2rD6dRKQY1CwJ6z1bAw+yL2vL5WNSe9YdPvwIVmcr5E=;
 b=gvlhUUAFHVT6nWPtH88hrJMUBXquyw7xp6uVlZ3tRtZ7tkSUB93hsvmW5mIugNb4Pn
 9hv6YBBUzsfjMKb9gyYWNs7+d/AnzHVWYjxNX12/nowr5SxnRw0I/oqaQDKcPnVO7+V+
 tsMlgcsGw+aiAzEPEv7OpdKiaVDZYNZlHVJA3Ob4qAkGuKFDGEDJCbJgAyqEU6spPs1A
 BEWfpv59B9ODsKhpgZxFlATftO1Uw8FWrA+44rEm81ualq7QbT4CXAHyvmPOEF4zIJXa
 QC9UZZa/bWEgTV6TGxFju3t5Z56tjv6ODGgYXhhI1H3H+n0axsN0toOynUYvVuSVRW4/
 MAqQ==
X-Gm-Message-State: AOAM531q8XbO1lIJGNWNHHZJ1pOpQcqUC1VtCdIr7CrQMTSacX/5iGes
 eM2L//DXGyIXsIKfPxv3c+K0jgrHCJs=
X-Google-Smtp-Source: ABdhPJwg9V/5OCcfqMvis0zG6ptGl1/3DN+wEkAxysrXbjkCgq3z60qYge+lggU5SZeOhdE/nYp1Mg==
X-Received: by 2002:aa7:838b:0:b029:2ea:3332:dd8a with SMTP id
 u11-20020aa7838b0000b02902ea3332dd8amr1750160pfm.74.1623878381923; 
 Wed, 16 Jun 2021 14:19:41 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:1036:8496:ef40:673a])
 by smtp.gmail.com with ESMTPSA id e188sm3003046pfe.23.2021.06.16.14.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 14:19:41 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v3 3/4] nvme-tcp: don't check blk_mq_tag_to_rq when receiving
 pdu data
Date: Wed, 16 Jun 2021 14:19:35 -0700
Message-Id: <20210616211936.451128-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210616211936.451128-1-sagi@grimberg.me>
References: <20210616211936.451128-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_141943_029866_EBF85130 
X-CRM114-Status: GOOD (  12.99  )
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

We already validate it when receiving the c2hdata pdu header
and this is not changing so this is a redundant check.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c7bd37103cf4..3ad65f42fc1e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -703,17 +703,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			      unsigned int *offset, size_t *len)
 {
 	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
-	struct nvme_tcp_request *req;
-	struct request *rq;
-
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
-		dev_err(queue->ctrl->ctrl.device,
-			"queue %d tag %#x not found\n",
-			nvme_tcp_queue_id(queue), pdu->command_id);
-		return -ENOENT;
-	}
-	req = blk_mq_rq_to_pdu(rq);
+	struct request *rq =
+		blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 	while (true) {
 		int recv_len, ret;
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
