Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA98DC07E9B
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:31:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96254619AF
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96254619AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eGm+c156FRVp+j9CXOyBHqgc7hi9DwQwYkFQVEBDwrk=; b=JRNyWQsYPhWdH7
	LkUpxrgAHxsfHtyn5VCOlEUmZWIyw34f9RnAFHiDO+szO7Rv5KZYC38HioTQhp1S+hD/MEE8IoPL/
	0KUIUI3UN1gfbpY70lwL2CvxDQeEAEnS9rSPs5/depDFv2rOMNme5fPlDJ/jE00P9xj+gPv87qv4q
	ZI56GnxsLnCkEP/61/+3e8svcpKVunyJgG76LJNeO0XFiXuK5y41MxYW8AY3BMlgmM5z9eC748Npk
	yXv4sKgf6wrZQp3xqUiM31TaddhO8IvOZ5zAlhMOZ02PhV+XxTWB1JoPc9sDE+escJd3FtU7J8NEu
	ANvi+AsUouIaAwvh+Fzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0QYy-009Lta-7x; Mon, 05 Jul 2021 15:31:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0QYm-009Lo5-2H
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 15:31:01 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0387461A06;
 Mon,  5 Jul 2021 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625499059;
 bh=qqKu06X8V8ZT4YRn43Tkxtopp0QFQFhzdtUcjql7AYQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oWvuZ6RslDu4N8RfoUCBvTy5EZlXSkunvn6b3lew3vUTFTerFww9Yq1hnqlXbFL74
 +LL94DJcJIs0eUahY+RVH9YK4bZZ7TEaukBzu1nn58IxE1smJEZBMwM3dXpRgiE2Kn
 KrOHs9Q7SeWCzswzOY/YLBQJoIwd5IuoBXJy9gYv/JJSvRoz1xlJIt2Sb1S/vgg5dh
 ofRMU6cGWWu5iALPUBqlxGHfifdmWjkauTiRJnHb51UcXu6HBWkIX2fGsQJL0MjuVa
 igDdmAEJXloRsrJDQNsVcMArXWovTnoqFDTUKLZL0UjOlPREnCRML3RK2/DvUH04lV
 WUW8qEpIKY8Mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 16/26] nvmet-fc: do not check for invalid target
 port in nvmet_fc_handle_fcp_rqst()
Date: Mon,  5 Jul 2021 11:30:29 -0400
Message-Id: <20210705153039.1521781-16-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210705153039.1521781-1-sashal@kernel.org>
References: <20210705153039.1521781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_083100_178660_4E77CC88 
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
index fc35f7ae67b0..9b07e8c7689a 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2151,13 +2151,6 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
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
@@ -2185,7 +2178,8 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
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
