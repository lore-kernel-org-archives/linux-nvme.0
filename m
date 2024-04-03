Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27609CD128A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ScYz9KkI/5PSnESo7ybEEMo4q5MzKk1Ie2pa5+YXf9w=; b=2NarysP1MJj3RnrEjXFDjePij8
	w1BYoBHzYrw4DlJiSo8OornFtYV/DU89wJhDZjSfl2AUlsq+Shs5ZSKINbPmsgGLvXbytCE1BDlO8
	Bl1LUXiIyHQ1y8jcx9L+UTaecGR4/wi3a+RiLZUGC/6wgsE8zHo3xIifAiZHMK1GXycKeEVh/GnJW
	wiNSQuAjE9h1w6mKQmFSQBxh6OV4MGVcjgWUnAyWcZr/R9ikOxeHB6EAv9WKdOiBRIw62u+99fAzd
	/qlq6p32b13iC1u1u8R3gsn0bOh2lAA+Ept3idbmxwERYgZWeh8ie9U9lhDaKo5Owo1nXcWhSeQDd
	jOnLFz+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs01U-0000000FzsJ-1ZL1;
	Wed, 03 Apr 2024 12:47:24 +0000
Received: from [2001:4bb8:199:60a5:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs01R-0000000Fzra-3roI;
	Wed, 03 Apr 2024 12:47:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] nvme: don't create a multipath node for zero capacity devices
Date: Wed,  3 Apr 2024 14:47:17 +0200
Message-Id: <20240403124717.931577-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Apparently there are nvme controllers around that report namespaces
in the namespace list which have zero capacity.  Return -ENXIO instead
of -ENODEV from nvme_update_ns_info_block so we don't create a hidden
multipath node for these namespaces but entirely ignore them.

Fixes: 46e7422cda84 ("nvme: move common logic into nvme_update_ns_info")
Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3b0498f320e6b9..ad60cf5581a419 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2089,7 +2089,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (id->ncap == 0) {
 		/* namespace not allocated or attached */
 		info->is_removed = true;
-		ret = -ENODEV;
+		ret = -ENXIO;
 		goto out;
 	}
 	lbaf = nvme_lbaf_index(id->flbas);
-- 
2.39.2


