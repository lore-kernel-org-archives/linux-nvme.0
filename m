Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0813FC11F6A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:30:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C525C619A0
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C525C619A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FkxWXWynMUgjTXs75SDo0efD+yaVJPGzNyB8fO9B+/g=; b=AbXegaDOJ4rEcP
	F3byHDmHpgqQMMrbo6PNjSAu3Jzv5ZGYVrmfR9xD90dyM/uMCpgdJlpCbG5Q0Ix3E5z4+QPN8n2uj
	KBWsFs6yVCcucGKdwGLDEOJdArqEVRmpxkpcIm1z+MD1RIRw5OprYd8yqnZLYNrDNcjFSJj4vi0OH
	RFrqNTvS9DP9QzGkA4MqUOntfoZCBsXtvL+/8bMQbo6SqAdLzJmRqYDiYZUhyfSM+gGlcrO0rDsRM
	geXE0BBrOTvYt/l2rqrlNhCC1TkzW+jfnNJz8RTlD77qHb1L6bKwooaGL2rtiAfvAwyapWM8DT4ME
	B5cBoYpfvlEL25gwsYRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0QXs-009LQb-DY; Mon, 05 Jul 2021 15:30:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0QXg-009LMD-6s
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 15:29:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2599061990;
 Mon,  5 Jul 2021 15:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625498991;
 bh=CreSF3836YFQf5SepfjQHNe1Dhiejoa7yZUMT0fJ9dA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mIzp93XTqPU4papXm8Vd6kXlPZ3Z42LRA8iG7POp7aY3p8FOYpbuHjsc8bxZqxEoP
 xOvlbcM4OVENp3IfgWgc3e4jYF7ZVEPFvSI6ug33sZGwSZoxGK61zr1WLbB/iVUjUQ
 fQRZlq25ZinCq5A65INMvc23w9tC6b11AxRbI/c2KmHsI/ihaBacPfov8Bzp/Ailtq
 AyzI0TblEC/4VtLOiTBqsA54neYKXoMBKcTMZAO2sTtxY4SYsH1DqepVkRP68EUqSO
 8QwSkKPzky6aZ8hOKpiVC/d71kN/ikfvsa5OBEGkkUMg91hvGfIC62YyY+h9SLo0rV
 JI/bYdqO/EH3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.12 31/52] nvmet-fc: do not check for invalid target
 port in nvmet_fc_handle_fcp_rqst()
Date: Mon,  5 Jul 2021 11:28:52 -0400
Message-Id: <20210705152913.1521036-31-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210705152913.1521036-1-sashal@kernel.org>
References: <20210705152913.1521036-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_082952_318248_A8FCBA32 
X-CRM114-Status: GOOD (  14.36  )
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

[ Upstream commit 2a4a910aa4f0acc428dc8d10227c42e14ed21d10 ]

When parsing a request in nvmet_fc_handle_fcp_rqst() we should not
check for invalid target ports; if we do the command is aborted
from the fcp layer, causing the host to assume a transport error.
Rather we should still forward this request to the nvmet layer, which
will then correctly fail the command with an appropriate error status.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d375745fc4ed..b81db5270018 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2494,13 +2494,6 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
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
@@ -2528,7 +2521,8 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
 	fod->req.cmd = &fod->cmdiubuf.sqe;
 	fod->req.cqe = &fod->rspiubuf.cqe;
-	fod->req.port = tgtport->pe->port;
+	if (tgtport->pe)
+		fod->req.port = tgtport->pe->port;
 
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
