Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1DAC11F6A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:30:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE9861990
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE9861990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L9KOL6TlixquZWTltqY/17DkZHqY5OL1gv5L8apxRRQ=; b=Nr69yyUkPDgjKV
	1+NYtg30n9OVJq6TW1rjE97fKpD07618m8ouLWVPGAKbJEuyFXzeZ5nzYLEtm65HIGwGhjLqsQ4mm
	8cr7e68r3gobd75msgyzSSGmNTa4/l8VhZocKFN6b2ldtoezLNt3S232SAb48bsicCtaNJ9pmz2y5
	yKvQ+zCkTEiSRJkPPEPAsDIhb+NEcFQbggdpcUOUI51igONb7mFL+VpOh3XXi6NnbXop92PWGdm/R
	/qWMOUazjh0yFe0S+OAgl7NUSKEcykaIl9/FplYxrWIrZqHw5KM/2d+aXVQDPsnP6S34O2wE9ZO75
	Oimxo4uf0S/MmIKgWGYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0QYP-009LdO-8z; Mon, 05 Jul 2021 15:30:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0QYL-009LbY-It
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 15:30:34 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CA6A619C4;
 Mon,  5 Jul 2021 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625499033;
 bh=P1wCF5MjMasoUsUhzJZ3trQHMHTl86FvkoaoOo0K928=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h2zUvpc78/6QtnZ90Nb/FfYFzYkaX5necCuomTAarU32xpOIyWZOCCM7pbjQ1sY2G
 U5h7Or6BH35fSvNFZ6EqYxCHgcY0RZlZgBFQDqAdl3nIRkh868I6ZfdKA/OyC0vUCJ
 2/YszaoMX64e/KpCB/Gih0gSwW4ucOgRDedBUW2Uayva0OYGB1hxdekn9Butv9iKig
 wocqDu8otDFE/K5+Wg0sOL/qzQKavV3EO6q6N4ApJ0E2nDC+tVqJmG7zUbHsL5jTtM
 TbG+i/hGm6JexSvLCjJsYR5rWpO8wW5hW41tcm+yx4qq7SH97vQa8RxwepM/chZ8L5
 4zo3+IVwLAHaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: JK Kim <jongkang.kim2@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 25/41] nvme-pci: fix var. type for increasing
 cq_head
Date: Mon,  5 Jul 2021 11:29:45 -0400
Message-Id: <20210705153001.1521447-25-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210705153001.1521447-1-sashal@kernel.org>
References: <20210705153001.1521447-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_083033_708389_AA3BEC44 
X-CRM114-Status: GOOD (  13.42  )
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

From: JK Kim <jongkang.kim2@gmail.com>

[ Upstream commit a0aac973a26d1ac814b9e131e209eb39472a67ce ]

nvmeq->cq_head is compared with nvmeq->q_depth and changed the value
and cq_phase for handling the next cq db.

but, nvmeq->q_depth's type is u32 and max. value is 0x10000 when
CQP.MSQE is 0xffff and io_queue_depth is 0x10000.

current temp. variable for comparing with nvmeq->q_depth is overflowed
when previous nvmeq->cq_head is 0xffff.

in this case, nvmeq->cq_phase is not updated.
so, fix data type for temp. variable to u32.

Signed-off-by: JK Kim <jongkang.kim2@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c1f3446216c5..56263214ea06 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1027,7 +1027,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 {
-	u16 tmp = nvmeq->cq_head + 1;
+	u32 tmp = nvmeq->cq_head + 1;
 
 	if (tmp == nvmeq->q_depth) {
 		nvmeq->cq_head = 0;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
