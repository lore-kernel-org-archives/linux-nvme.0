Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF388C12002
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 11:05:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63EB611C1
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 11:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63EB611C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pSbeGsEne8mUGytaoTNMOVP/m0AUA5upiScpJtquy/Q=; b=v6ZN9R0ir8n0Kn
	oMNHivnFfO2W4/WQGlhEfDNW80MArrVGbvqvigpkKImfM7YH04iTIXBiGFVB0ojHwGYgLM/lM5bor
	eCPfE7Mvcg/n9np9nnoJdeA1t8AZCjrBuUlFzPpqbI8a712KzYcMKxNyoyt1b+TDIEGn8m2eyP+3c
	xF6bc29+xMv+gwLor8a3cMouI8QJW9nBl28reYiqY/WYYAoICxVCgBIQ6VXOhc+VGW1/dFjyuXhp5
	4sswIrVzdc4A5kF/7AyhGM/BEkkumWtvNOHAcG1xJgsLno6OsKX+mZMQU1kFGnGnA7wDweiuNlxgq
	g66agFH0fHQB0e5AI4ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4Lei-004ECw-KM; Fri, 16 Jul 2021 11:05:20 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4Le9-004E5S-Hl
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 11:04:48 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 534A0205D3;
 Fri, 16 Jul 2021 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626433482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pA854x4+NZnK9VsYLRuDw6BPzTZncgGJA2I5lFQbIk=;
 b=HlGi7FiQU+L24+zC+gG0ZKwoBuzWoQyhISwSuel1TT0K3IBHEO7cYChsnR3UjPV0WrCyaD
 dSzypq2guJJ95Zf288BBOq3yzxNqGwtxernHnwdtEyKY+mYHn8NPggrFlEsNga5Wb8xt6E
 iim7wub7n7qRnsV9+rtm8d61qGX35XA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626433482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pA854x4+NZnK9VsYLRuDw6BPzTZncgGJA2I5lFQbIk=;
 b=gOGCKEcQvYYZZXr5UG1cvYqtEe6IsvO99ZSkfNG8HvV2ZBSQvoAiuU5cSoVlIRMlQ/02F3
 BSQ3u+rgxIAqsiCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 4720DA3BB7;
 Fri, 16 Jul 2021 11:04:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 9C63D5171614; Fri, 16 Jul 2021 13:04:41 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/11] nvmet: Parse fabrics commands on all queues
Date: Fri, 16 Jul 2021 13:04:25 +0200
Message-Id: <20210716110428.9727-9-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210716110428.9727-1-hare@suse.de>
References: <20210716110428.9727-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_040445_912329_F9B3D102 
X-CRM114-Status: GOOD (  10.27  )
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

Fabrics commands might be sent to all queues, not just the admin one.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ac7210a3ea1c..163f7dc1a929 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -942,6 +942,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	if (unlikely(!req->sq->ctrl))
 		/* will return an error for any non-connect command: */
 		status = nvmet_parse_connect_cmd(req);
+	else if (nvme_is_fabrics(req->cmd))
+		status = nvmet_parse_fabrics_cmd(req);
 	else if (likely(req->sq->qid != 0))
 		status = nvmet_parse_io_cmd(req);
 	else
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
